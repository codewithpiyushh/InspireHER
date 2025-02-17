from langchain_community.llms import HuggingFaceHub
from langchain.vectorstores import Chroma
from langchain.embeddings import HuggingFaceEmbeddings
from langchain.document_loaders import PyPDFLoader, TextLoader,JSONLoader
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain.chains import RetrievalQA
from langchain.prompts import PromptTemplate
import json
import os
import re
from flask import Flask, request, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)  # Enable CORS for all routes

# 1. Hugging Face Hub API Token (from environment variable)
HUGGINGFACEHUB_API_TOKEN = ""
if not HUGGINGFACEHUB_API_TOKEN:
    raise ValueError("HUGGINGFACEHUB_API_TOKEN environment variable not set.")

documents = []

try:
    # Load PDF
    pdf_loader = PyPDFLoader("scheme.pdf")
    pdf_documents = pdf_loader.load()
    documents.extend(pdf_documents)
except FileNotFoundError:
    raise FileNotFoundError("scheme.pdf not found. Please provide the correct path.")
except Exception as e:
    raise RuntimeError(f"Error loading PDF: {e}")

def load_json_data(file_path):
    """Loads JSON data from a file, handling various structures."""
    try:
        with open(file_path, "r", encoding="utf-8") as f:
            data = json.load(f)

        if isinstance(data, list):  # List of dictionaries (LangChain's expected format)
            return data
        elif isinstance(data, dict):  # Single dictionary or nested dictionaries
            # Convert dictionary to a list of dictionaries (LangChain's expected format)
            return [data] # Treat the whole dictionary as one document
        else:
            print(f"Unsupported JSON structure in {file_path}. Treating as a single string.")
            return [{"text": json.dumps(data, indent=2)}] # Convert to string and create a single doc

    except FileNotFoundError:
        print(f"{file_path} not found. Skipping.")
        return []
    except json.JSONDecodeError as e:
        print(f"Error decoding JSON in {file_path}: {e}")
        return []
    except Exception as e:
        print(f"Error loading {file_path}: {e}")
        return []

try:
    # Load JSON files using the new function
    for json_file in ["governmentschemes.json"]:  # Add other JSON files here
        json_data = load_json_data(json_file)
        for item in json_data:
            documents.append(TextLoader(text=json.dumps(item)).load()[0]) # Create Langchain documents

except Exception as e:
    print(f"General error loading JSON: {e}")

# 3. Split text into chunks
text_splitter = RecursiveCharacterTextSplitter(chunk_size=500, chunk_overlap=50)
split_documents = text_splitter.split_documents(documents)

# 4. Initialize embedding model and create vector database
try:
    embeddings = HuggingFaceEmbeddings(model_name="sentence-transformers/all-MiniLM-L6-v2")
    db = Chroma.from_documents(split_documents, embeddings, persist_directory="chroma_db")
    db.persist()
except Exception as e:
    raise RuntimeError(f"Error creating Chroma DB: {e}")

# 5. Load LLM
try:
    llm = HuggingFaceHub(
        repo_id="meta-llama/Meta-Llama-3-8B",
        model_kwargs={"temperature": 0.5, "max_new_tokens": 512},
        huggingfacehub_api_token=HUGGINGFACEHUB_API_TOKEN,
    )
except Exception as e:
    raise RuntimeError(f"Error loading LLaMA model: {e}")

# 6. Create System Prompt Template
prompt_template = """
You are an AI-powered financial and business mentor designed to assist Indian rural women in entrepreneurship, financial literacy, government schemes, and digital empowerment.
Your responses should be:
- **Simple and Clear**: Use easy-to-understand language suitable for users with limited formal education.
- **Structured and Informative**: Provide details in a step-by-step manner for clarity.
- **Supportive and Encouraging**: Offer practical guidance with a positive and respectful tone.
- **Actionable**: Include necessary details such as eligibility, required documents, and application links.

### Structure:
1. **Government Schemes**: List relevant schemes.
2. **Eligibility**: Clearly mention who can apply.
3. **Application Process**: Provide easy-to-follow steps along with the application link and contact information.
4. **Required Documents**: List necessary paperwork.

Now, based on the following context and user query, generate a response that is professional, clear, and easy to understand:

**Context:** {context}
**User Input:** {question}
"""

custom_prompt = PromptTemplate(template=prompt_template, input_variables=["context", "question"])

# 7. Create RAG pipeline
qa_chain = RetrievalQA.from_chain_type(
    llm=llm,
    retriever=db.as_retriever(),
    chain_type="stuff",
    chain_type_kwargs={"prompt": custom_prompt},
)

def generate_response(user_input):
    try:
        result = qa_chain.invoke({"query": user_input})
        response_text = result.get("result", "Sorry, I couldn't generate a response.")
        # Ensure response contains only the assistant's reply
        match = re.search(r"(?i)Assistant", response_text)  # (?i) makes it case-insensitive

        if match:
            # Split at the "Assistant" and take the part *after* it
            cleaned_response = response_text.split(match.group(0))[-1].strip()
        else:
            # If "Assistant" is not found, return the whole response or handle it differently
            cleaned_response = response_text.strip() # Or some other default behavior
        return cleaned_response
    except Exception as e:
        print(f"Error in chat function: {e}")
        return "An error occurred."
@app.route('/chat', methods=['POST'])
# 8. Chat Function
def chat_endpoint():
    data = request.get_json()
    print(data)
    user_input = data.get('query')
    if not user_input:
        return jsonify({"error": "Missing 'query' parameter"}), 400
    response = generate_response(user_input)
    return jsonify({"response": response})


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5001, debug=True)
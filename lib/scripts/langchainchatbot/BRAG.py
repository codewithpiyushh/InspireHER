from langchain_community.llms import HuggingFaceHub
from langchain.vectorstores import Chroma
from langchain.embeddings import HuggingFaceEmbeddings
from langchain.document_loaders import TextLoader
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain.chains import RetrievalQA
from langchain.prompts import PromptTemplate
import os
import re
from flask import Flask, request, jsonify

app = Flask(__name__)

# 1. Hugging Face Hub API Token
HUGGINGFACEHUB_API_TOKEN = os.getenv("HUGGINGFACEHUB_API_TOKEN", "")
if not HUGGINGFACEHUB_API_TOKEN:
    raise ValueError("HUGGINGFACEHUB_API_TOKEN environment variable not set.")

# 2. List of text files to train on
text_files = ["dairybusiness.txt", "tutoringbusiness.txt", "tailoringbusiness.txt"]

# 3. Load and process multiple text files
all_documents = []
for file in text_files:
    loader = TextLoader(file, encoding="utf-8")
    documents = loader.load()
    all_documents.extend(documents)

# 4. Split text into chunks
text_splitter = RecursiveCharacterTextSplitter(chunk_size=500, chunk_overlap=50)
split_documents = text_splitter.split_documents(all_documents)

# 5. Initialize embedding model and create vector database
try:
    embeddings = HuggingFaceEmbeddings(model_name="sentence-transformers/all-MiniLM-L6-v2")
    db = Chroma.from_documents(split_documents, embeddings, persist_directory="chroma_db")
    db.persist()
except Exception as e:
    raise RuntimeError(f"Error creating Chroma DB: {e}")

# 6. Load LLM
try:
    llm = HuggingFaceHub(
        repo_id="meta-llama/Meta-Llama-3-8B",
        model_kwargs={"temperature": 0.5, "max_new_tokens": 512},
        huggingfacehub_api_token=HUGGINGFACEHUB_API_TOKEN,
    )
except Exception as e:
    raise RuntimeError(f"Error loading LLaMA model: {e}")

# 7. Create System Prompt Template
prompt_template = """
You are an AI-powered business mentor dedicated to helping Indian rural women start and grow their businesses.  
Your role is to provide guidance tailored to their specific business type, covering key aspects such as:  
- **Requirements**: Licenses, permits, and necessary skills.  
- **Startup Costs**: Estimated initial investment, potential funding sources, and cost-saving strategies.  
- **Practical Tips**: Step-by-step advice on launching and sustaining the business successfully.  

Your responses should be:  
- **Simple and Clear**: Use easy-to-understand language suitable for users with limited formal education.  
- **Structured and Informative**: Present information in an organized, step-by-step manner.  
- **Supportive and Encouraging**: Offer guidance in a positive and respectful tone.  
- **Actionable**: Include important details such as eligibility criteria, required documents, and relevant application links.  

Now, based on the following context and user query, generate a professional, clear, and easy-to-understand response:  

**Context:** {context}  
**User Input:** {question}  
"""

custom_prompt = PromptTemplate(template=prompt_template, input_variables=["context", "question"])

# 8. Create RAG pipeline
qa_chain = RetrievalQA.from_chain_type(
    llm=llm,
    retriever=db.as_retriever(),
    chain_type="stuff",
    chain_type_kwargs={"prompt": custom_prompt},
)

# 9. Chat Function
def generate_response(user_input):
    try:
        result = qa_chain.invoke({"query": user_input})
        response_text = result.get("result", "Sorry, I couldn't generate a response.")
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

# 10. Flask API Endpoint
@app.route('/chat', methods=['POST'])
def chat_endpoint():
    data = request.get_json()
    print("data ", data)
    user_input = data.get('query')
    if not user_input:
        return jsonify({"error": "Missing 'query' parameter"}), 400
    response = generate_response(user_input)
    return jsonify({"response": response})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)

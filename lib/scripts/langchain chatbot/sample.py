import os
import json
import textwrap
import glob
from typing import List, Dict
import numpy as np
from openai import OpenAI

# Import LangChain components
from langchain_community.vectorstores import Chroma
from langchain.chains import ConversationalRetrievalChain
from langchain.memory import ConversationBufferMemory
from langchain_community.embeddings import HuggingFaceHubEmbeddings
from langchain.embeddings import HuggingFaceEmbeddings

from langchain_community.document_loaders import PyPDFLoader, TextLoader
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain.schema import Document
from langchain.prompts import PromptTemplate

# Import Chainlit
from flask import Flask, request, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)  # Allow all origins

# 1. Hugging Face Hub API Token
HUGGINGFACEHUB_API_TOKEN = ""
OPENAI_API_KEY = ""  # Your provided API key

# Initialize OpenAI client
client = OpenAI(
    api_key=OPENAI_API_KEY,
    base_url="https://chatapi.akash.network/api/v1"
)

# Initialize memory
memory = ConversationBufferMemory(
    memory_key="chat_history",
    return_messages=True
)

def load_documents():
    """Loads PDFs, JSON, and text documents into a list of LangChain Document objects."""
    documents = []

    # Load PDF
    pdf_file = "scheme.pdf"
    if os.path.exists(pdf_file):
        try:
            pdf_loader = PyPDFLoader(pdf_file)
            documents.extend(pdf_loader.load())
            print(f"Loaded {len(documents)} pages from {pdf_file}")
        except Exception as e:
            print(f"Error loading PDF {pdf_file}: {e}")

    # Load JSON Files
    json_files = ["governmentschemes.json"]
    for json_file in json_files:
        if os.path.exists(json_file):
            try:
                with open(json_file, "r", encoding="utf-8") as f:
                    json_data = json.load(f)

                if isinstance(json_data, list):
                    for item in json_data:
                        documents.append(Document(page_content=json.dumps(item), metadata={"source": json_file}))
                elif isinstance(json_data, dict):
                    documents.append(Document(page_content=json.dumps(json_data), metadata={"source": json_file}))

                print(f"Loaded {len(json_data)} items from {json_file}")

            except Exception as e:
                print(f"Error loading JSON {json_file}: {e}")

    # Load Text Files
    txt_files = [
        "dairybusiness.txt",
        "tutoringbusiness.txt",
        "tailoringbusiness.txt",
    ]

    # Include all .txt files in the current directory
    txt_files.extend([f for f in glob.glob("*.txt") if f not in txt_files])

    for txt_file in txt_files:
        if os.path.exists(txt_file):
            try:
                loader = TextLoader(txt_file, encoding="utf-8")
                documents.extend(loader.load())
                print(f"Loaded text file: {txt_file}")
            except Exception as e:
                print(f"Error loading text file {txt_file}: {e}")

    return documents

def get_vector_db(documents=None):
    # Initialize embedding model
    embeddings = HuggingFaceHubEmbeddings(
        huggingfacehub_api_token=HUGGINGFACEHUB_API_TOKEN,
        repo_id="sentence-transformers/all-MiniLM-L6-v2",
        task="feature-extraction"
    )
    
    persist_directory = "chroma_db"
    
    # Check if the vector database already exists
    if os.path.exists(persist_directory) and os.path.isdir(persist_directory) and len(os.listdir(persist_directory)) > 0:
        try:
            print("Loading existing vector database...")
            db = Chroma(
                persist_directory=persist_directory,
                embedding_function=embeddings
            )
            print(f"Vector database loaded successfully with {db._collection.count()} documents")
            

            return db
        except Exception as e:
            print(f"Error loading existing database: {e}")
            print("Will create a new vector database")
    
    # If no existing database or documents provided, raise an error
    if not documents:
        raise ValueError("No existing database found and no documents provided to create one")
    
    # Create a new vector database
    try:
        print("Creating new vector database...")
        # Split text into chunks - increased chunk size for more context
        text_splitter = RecursiveCharacterTextSplitter(chunk_size=1000, chunk_overlap=100)
        split_documents = text_splitter.split_documents(documents)
        print(f"Split into {len(split_documents)} chunks")
        
        db = Chroma.from_documents(
            split_documents, 
            embeddings, 
            persist_directory=persist_directory
        )
        db.persist()
        print("New vector database created successfully")
        
        return db
    except Exception as e:
        raise RuntimeError(f"Error creating Chroma DB: {e}")

# 7. Create System Prompt Template
def query_llm_directly(user_query, context=None, chat_history=None):
    """Use the OpenAI client directly with improved prompt."""
    
    system_message = """You are an AI-powered financial and business mentor designed to assist Indian rural women in entrepreneurship, 
    financial literacy, government schemes, and digital empowerment .
     You MUST ONLY answer using the provided context. If the context does not contain the answer, respond with:
    
    "I don't have enough information to answer that. Please ask something else."
    DO NOT generate answers from your own knowledge.

    Your responses should be:
    - Detailed and Comprehensive: Provide in-depth information about schemes, processes, and opportunities.
    - Simple and Clear: Use easy-to-understand language suitable for users with limited formal education.
    - Structured and Informative: Provide details in a step-by-step manner for clarity.
    - Supportive and Encouraging: Offer practical guidance with a positive and respectful tone.
    - Actionable: Include all necessary details such as eligibility criteria, required documents, application processes, and benefits.
    - Culturally Appropriate: Consider the cultural context of rural Indian women when providing advice.
    

    
    For each government scheme or financial program mentioned, always include:
    1. Full name and brief description
    2. Complete eligibility criteria
    3. All required documents
    4. Step-by-step application process
    5. Expected benefits or outcomes
    6. Relevant contact information if available
    
    When discussing entrepreneurship opportunities, provide:
    1. Detailed business ideas suitable for rural settings
    2. Resources needed to start 
    3. Potential challenges and solutions
    4. Success stories when relevant
    
    DO NOT include sources or references at the end of your responses."""
    
    messages = [{"role": "system", "content": system_message}]
    
    # Add chat history for better continuity
    if chat_history:
        for message in chat_history[-5:]:  # Include last 5 messages for context
            messages.append(message)
    
    # Format the prompt with context
    if context:
        messages.append({"role": "user", "content": f"Context information (use this to formulate your answer):\n{context}\n\nUser question: {user_query}\n\nProvide a comprehensive, detailed response with all available information on the topic."})
    else:
        messages.append({"role": "user", "content": user_query})
    
    try:
        # Request a longer, more detailed response
        response = client.chat.completions.create(
            model="Meta-Llama-3-1-8B-Instruct-FP8",
            messages=messages,
            temperature=0.7,  # Slightly increased creativity
            max_tokens=1024,  # Ensure longer responses
        )
        return response.choices[0].message.content
    except Exception as e:
        print(f"Error calling OpenAI API: {e}")
        return f"Error: {str(e)}"


@app.route('/chat', methods=['POST','GET'])
def chat_endpoint():
    try:
        data = request.get_json()
        if not data or "query" not in data:
            return jsonify({"error": "Invalid request. 'query' field is required."}), 400

        user_query = data.get('query')
        print("user_query",user_query)
        chat_history = data.get("chat_history", [])
        print("chat_history",chat_history)
        documents = load_documents()
        print("documents",len(documents))
        db = get_vector_db(documents)
        retriever = db.as_retriever(search_kwargs={"k": 2})
        print("Vector database loaded successfully",retriever)
        ################################iske niche se error ara hai :(####################################################
        try:
            context_docs = retriever.get_relevant_documents(user_query)
            context_docs = np.array(context_docs).squeeze().tolist()
            print(f"Retrieved {len(context_docs)} documents.")
        except Exception as e:
            print(f"Error retrieving documents: {e}")
            return jsonify({"error": "Failed to retrieve relevant documents."}), 500

        if not context_docs:
            return jsonify({"error": "No relevant documents found."}), 404

        context = "\n".join([doc.page_content for doc in context_docs])        
        chat_history.append({"role": "user", "content": user_query})
        print(chat_history)
        response = query_llm_directly(user_query,context,chat_history)
        
        
        return json.dumps({"response": response}, ensure_ascii=False), 200, {'Content-Type': 'application/json; charset=utf-8'}
    except Exception as e:
        print(f"Error in API endpoint: {e}")
        return jsonify({"error": "Internal server error"}), 500


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
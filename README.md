
## <img src="https://github.com/user-attachments/assets/52f7ae17-b4fc-4a59-9e70-b23e8a24f22e" width="30" /> InspireHer: AI-Powered Financial Advisor for Rural Women

##  Overview
InspireHer is a transformative AI-powered platform designed to bridge the financial literacy gap for rural women. It offers personalized financial education, mentorship, and essential business tools, empowering women to start and grow their businesses with confidence. By fostering entrepreneurship and creating an inclusive ecosystem, InspireHer enables women like Lakshmi to achieve financial independence and turn their aspirations into reality.
## **Index**

1. [Key Features](#key-features)
2. [Demo Video](#demo-video)
3. [File Strcuture](#file-structure)
4. [Getting Started](#getting-started)  
   - [Prerequisites](#prerequisites)  
   - [Installation](#installation) 
5. [Architecture](#architecture)
6. [Tech Stack](#tech-stack)


## **Key Features**

### 1. Learn  
- **AI-Powered Chatbot**: RAG-based LLM chatbot developed with **LangChain**, providing step-by-step business and financial guidance.  
- **Expert Blogs**: Insights from industry leaders on financial literacy, business strategies, and market trends.  
- **Mentorship Program**: Personalized guidance from successful female entrepreneurs and financial advisors.  

### 2. Setup   
- **Location-Based Business Insights**: Uses **GPS-API** to recommend optimal business locations based on market demand and supplier proximity.  
- **Resource Buying Recommendation**: Connects users with **verified suppliers** for cost-effective purchases.  
- **Business Roadmaps**: AI-generated, step-by-step guides tailored to literacy levels and business types.  

### 3. Connect   
- **Female Entrepreneur Network**: Connects users with women in the same business sector to learn from their experiences.  
- **Community Engagement**: Discussion forums and collaborative spaces to foster learning and business growth.  

### 4. Finance   
- **Loan Scheme Comparison**: Helps users evaluate and apply for multiple loan options simultaneously.  
- **AI-Powered Legal & Government Insights**: Provides tailored recommendations on government funding and financial aid.  
- **Document Checklist**: Step-by-step guidance on required documents for seamless loan applications.  
- **Budgeting & Analytics Tools**: Helps users track expenses, plan finances, and ensure business sustainability.  

## **Demo Video**  




https://github.com/user-attachments/assets/d4fce425-3ee6-4276-8ec2-95c20721268a






## **File Structure**  

```
C:.
├── .flutter-plugins  
├── .flutter-plugins-dependencies 
├── .gitattributes 
├── .gitignore 
├── .metadata 
├── analysis_options.yaml 
├── flutter_application_1.iml 
├── pubspec.lock 
├── pubspec.yaml // Project dependencies and configurations
├── README.md 
├── structure.txt 
├── .dart_tool 
├── .idea 
├── android 
├── assets // Static assets like images and fonts
├── build // Build output directory
├── ios 
├── lib // Dart main folder where all the files are stored
│   ├── firstpage.dart // First page of frontend 
│   ├── main.dart // Entry point of the Flutter application
│   ├── navigation_menu.dart // Navigation_menu used to navigate throught the application
│   ├── conn 
│   │   ├── connect.dart // Feature of the application that connect mentors to user
│   │   └── mentorfile.dart // Mentor Profile page
│   ├── finance // Finance-related code
│   │   └── invest.dart // Feature of Application that give financial and investment options
│   ├── home // Home screen code
│   │   └── home_page.dart // Home page 
│   ├── l10n // Localization files
│   │   ├── app_en.arb // English localization resources
│   │   ├── app_hi.arb // Hindi localization resources
│   │   ├── app_localizations.dart // Localization support class
│   │   ├── app_localizations_en.dart // English localization delegate
│   │   └── app_localizations_hi.dart // Hindi localization delegate
│   ├── lear // 
│   │   └── try.dart // learn page 
│   ├── scripts // Python scripts and data
│   │   ├── application.py // Main application script
│   │   ├── chroma.sqlite3 // Chroma database file
│   │   ├── scheme.pdf // Scheme document (PDF)
│   │   └── setuppython.py // Python setup script
│   │   └── langchainchatbot // Langchain chatbot related files
│   │       ├── BRAG.py // BRAG chatbot script
│   │       ├── dairybusiness.txt // Data for dairy business
│   │       ├── governmentschemes.json // Government schemes data (JSON)
│   │       ├── scheme.pdf // Scheme document (PDF)
│   │       ├── SchemesRAG.py // Schemes RAG script
│   │       ├── tailoringbusiness.txt // Data for tailoring business
│   │       └── tutoringbusiness.txt // Data for tutoring business
│   └── set // Setup related code
│       └── setup.dart // Setup configuration
├── linux // Linux platform-specific code
├── macos // macOS platform-specific code
├── test // Widget tests
│   └── widget_test.dart // Example widget test
└── web // Web platform-specific code
```






## **Getting Started**  





## **Architecture**
![Copy of EY-Detailed Presentation](https://github.com/user-attachments/assets/5643232d-48fd-45d6-9de9-deb37743a6a5)

## **Tech stack**
- **Backend**: Flask (Python)
- **Frontend**: Flutter (Dart)
- **AI Model**: LLM (Meta Llama 3) using LangChain & Hugging Face
- **APIs**:
  - **GPS-API** for location-based business recommendations
  - **Hugging Face API** for AI model deployment
  
## **User Interaction**

<div align="center">
    <img src="https://github.com/user-attachments/assets/e79edf4b-8a16-406d-940e-93f8e6550eb3" width="30%" />
    <img src="https://github.com/user-attachments/assets/dd963a13-ffdd-4a7f-99b6-23730567dba7" width="30%" />
    <img src="https://github.com/user-attachments/assets/e0693b0b-ca30-4553-93cc-1dd58d303606" width="30%" />
</div>




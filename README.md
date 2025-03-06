
<h2 style="display: flex; align-items: center;">
  <img src="https://github.com/user-attachments/assets/1d13b529-cb68-4d49-9fef-22e40ab9f26a" width="95" height="60" style="margin-right: 10px;" />
  InspireHer: AI-Powered Financial Advisor for Rural Women
</h2>

##  Overview
InspireHer is an AI-powered platform designed to support rural women entrepreneurs by providing financial education, mentorship, and business resources. Using RAG-LLM technology, it offers personalized guidance, connects users with government-backed financial schemes, and links them to local suppliers and experts. The platform enhances financial literacy through courses, tutorials, and AI-driven funding insights. Features like a local trade network, business location recommendations, and micro-investment opportunities enable sustainable business growth. Real-time chat, mentorship, and video sharing foster a strong support network. This repository includes the codebase, chatbot models, and financial service integrations, welcoming contributions to expand its impact.

## **Key Features**
| **Learn** | **Setup** | **Finance** | **Connect** |
|----------|----------|----------|----------|
| **RAG-LLM Based Chatbot**: Provides personalized, business-specific financial education with step-by-step guidance based on the selected business type. | **Business Location Recommendations**: Uses GPS data to recommend optimal business locations based on local market demand, supply, and competition. | **AI-Powered Government Insights**: Chatbot trained on various government schemes, delivering personalized funding advice and eligibility criteria to help users maximize benefits. | **Mentorship Connections**: Connects users with experienced local female entrepreneurs from similar businesses and experts for business guidance. |
| **Delivers Actionable Insights**: Offers practical knowledge for business success. | **Resource Buying Recommendation**: Users can select necessary resources, and InspireHer connects them with nearby verified suppliers at competitive prices while also displaying their locations. | **Women-Centric Loan & Financial Schemes**: Connects women entrepreneurs to government-backed loan schemes, enabling them to explore options, check eligibility, and directly access financial institutions. | **Upload Images and Videos**: Enables women to share success stories and strategies through videos and images. |
| **Domain-Led Courses & Blogs by Experts**: Simplifies essential financial concepts with tutorials, interactive roadmaps, and engaging videos to empower smarter decision-making. | **Local Trade Network**: Creates a self-sustaining economy by linking users with local suppliers based on demand and supply, ensuring easy access to affordable resources. | **Micro-Investment Opportunities**: Empowers users to make small, impactful investments to grow their businesses sustainably. | **Chat Section**: Supports real-time communication for collaboration, mentorship, and instant query resolution. |



## **Demo Video**  

https://github.com/user-attachments/assets/d4fce425-3ee6-4276-8ec2-95c20721268a

## **Tech stack**
- **Backend**: Flask (Python)
- **Frontend**: Flutter (Dart)
- **AI Model**: LLM (Meta Llama 3) using LangChain & Hugging Face
- **APIs**:
  - **GPS-API** for location-based business recommendations
  - **Hugging Face API** for AI model deployment



## **File Structure**  

```
C:.
 
├── lib 
│   ├── firstpage.dart // First page of frontend 
│   ├── main.dart // Entry point of the Flutter application
│   ├── navigation_menu.dart // Navigation_menu used to navigate throught the application
│   ├── conn 
│   │   ├── connect.dart //  connect mentors to user
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
```



  
## **User Interaction**

<div align="center">
    <img src="https://github.com/user-attachments/assets/e79edf4b-8a16-406d-940e-93f8e6550eb3" width="20%" />
    <img src="https://github.com/user-attachments/assets/dd963a13-ffdd-4a7f-99b6-23730567dba7" width="20%" />
    <img src="https://github.com/user-attachments/assets/e0693b0b-ca30-4553-93cc-1dd58d303606" width="20%" />
</div>

## **Conclusion**
InspireHer empowers rural women entrepreneurs with financial literacy, business mentorship, and access to resources. Through AI-driven insights, local trade networks, and government-backed funding, it enables women to start, sustain, and grow their businesses. By fostering financial independence and community support, InspireHer is building a self-sustaining ecosystem of women-led businesses. 

## 📢 Connect with Us  

- [Piyush Singh](https://www.linkedin.com/in/piyushhh-singhh/)  
- [Nikita Babbar](https://www.linkedin.com/in/nikita-babbar-b0291026a/)



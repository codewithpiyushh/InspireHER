import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';



class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Scrollable scheme banners
              SizedBox(
                height: 220, // Increased height to ensure visibility
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: 3, // Adjust based on the number of images
                  itemBuilder: (context, index) {
                    final List<String> imagePaths = [
                      'assets/scheme1.png',
                      'assets/scheme2.jpg',
                      'assets/scheme3.webp',
                    ];
                    return _buildSchemeBanner(imagePath: imagePaths[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSchemeBanner({required String imagePath}) {
    return Container(
      width: 300, // Slightly wider to ensure visibility
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          imagePath,
          width: 300,
          height: 200, // Adjust height to match parent `SizedBox`
          fit: BoxFit.cover, // Ensures the image scales properly
        ),
      ),
    );
  }
}

class BusinessFormsScreen extends StatefulWidget {
  final String selectedBusiness;

  const BusinessFormsScreen({super.key, required this.selectedBusiness});

  @override
  _BusinessFormsScreenState createState() => _BusinessFormsScreenState();
}

class _BusinessFormsScreenState extends State<BusinessFormsScreen> {
  late String selectedBusiness;

  final Map<String, List<Map<String, String>>> businessForms = {
    "Dairy": [
      {
        "name": "Trade License",
        "link":
            "https://www.indiafilings.com/startup/trade-license-in-uttar-pradesh"
      },
      {
        "name": "FSSAI License",
        "link":
            "https://www.wikiprocedure.com/index.php?title=Uttar_Pradesh_-_Obtain_FSSAI_License_for_Dairy_Product_Manufacturing"
      },
      {"name": "GST Registration", "link": "https://www.gst.gov.in/"},
      {
        "name": "Pollution NOC",
        "link": "https://niveshmitra.up.nic.in/Default.aspx"
      },
    ],
    "Bakery": [
      {
        "name": "Trade License",
        "link":
            "https://www.indiafilings.com/startup/trade-license-in-uttar-pradesh"
      },
      {"name": "FSSAI License", "link": "https://www.startupindia.gov.in/"},
      {"name": "GST Registration", "link": "https://www.gst.gov.in/"},
    ],
    "SuperMarket": [
      {
        "name": "Trade License",
        "link":
            "https://www.indiafilings.com/startup/trade-license-in-uttar-pradesh"
      },
      {"name": "FSSAI License", "link": "https://www.startupindia.gov.in/"},
      {"name": "GST Registration", "link": "https://www.gst.gov.in/"},
    ],
    "Convenience": [
      {
        "name": "Trade License",
        "link":
            "https://www.indiafilings.com/startup/trade-license-in-uttar-pradesh"
      },
      {"name": "GST Registration", "link": "https://www.gst.gov.in/"},
    ],
  };

  @override
  void initState() {
    super.initState();
    selectedBusiness = widget.selectedBusiness;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forms Required for $selectedBusiness"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: businessForms.containsKey(selectedBusiness)
            ? ListView(
                children: businessForms[selectedBusiness]!.map((form) {
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(form["name"]!,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(form["link"]!,
                          style: const TextStyle(color: Colors.blue)),
                      trailing: const Icon(Icons.open_in_new,
                          color: Colors.blueAccent),
                      onTap: () async {
                        final Uri url = Uri.parse(form["link"]!);
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Could not launch the URL')),
                          );
                        }
                      },
                    ),
                  );
                }).toList(),
              )
            : const Center(
                child: Text("No forms available for this business.",
                    style: TextStyle(fontSize: 16)),
              ),
      ),
    );
  }
}

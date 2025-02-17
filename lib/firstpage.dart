import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'navigation_menu.dart';

class FrontPage extends StatefulWidget {
  const FrontPage({super.key});

  @override
  _FrontPageState createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  String selectedLanguage = 'en_US';
  String selectedBusiness = 'Dairy'; // Default business

  final List<String> businesses = [
    'Dairy/डेरी',
    'Bakery/बेकरी',
    'SuperMarket/सुपरमार्केट',
    'Convenience/सुविधा'
  ];

  final List<IconData> businessIcons = [
    Icons.inventory_2,
    Icons.storefront,
    Icons.factory,
    Icons.business_center,
  ];

  @override
  void initState() {
    super.initState();
    loadPreferences();
  }

  // ✅ Load saved preferences for language & business type
  Future<void> loadPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedLanguage = prefs.getString('selected_language') ?? 'en_US';
      selectedBusiness = prefs.getString('selected_business') ?? 'Dairy';
    });
  }

  // ✅ Save selected language
  Future<void> saveSelectedLanguage(String language) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_language', language);
  }

  // ✅ Save selected business type
  Future<void> saveSelectedBusiness(String business) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_business', business);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Language & Business')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Language/भाषा चुने:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // ✅ Language Dropdown
            DropdownButton<String>(
              value: selectedLanguage,
              items: [
                DropdownMenuItem(value: 'en_US', child: Text('English')),
                DropdownMenuItem(value: 'hi_IN', child: Text('हिन्दी')),
              ],
              onChanged: (String? newValue) async {
                if (newValue != null) {
                  setState(() {
                    selectedLanguage = newValue;
                  });
                  await saveSelectedLanguage(newValue);
                  Get.updateLocale(
                      Locale(newValue.split('_')[0], newValue.split('_')[1]));
                }
              },
              isExpanded: true,
            ),

            const SizedBox(height: 40),

            const Text(
              'Select Business Type/व्यवसाय चुनें:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // ✅ Business Type Selection (Wrap Layout)
            Wrap(
              spacing: 75,
              runSpacing: 20,
              children: businesses.asMap().entries.map((entry) {
                int index = entry.key;
                String business = entry.value;

                return GestureDetector(
                  onTap: () async {
                    setState(() {
                      selectedBusiness = business;
                    });
                    await saveSelectedBusiness(business);
                  },
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      color: selectedBusiness == business
                          ? Colors.blueAccent
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(0, 4))
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          businessIcons[index],
                          size: 40,
                          color: selectedBusiness == business
                              ? Colors.white
                              : Colors.black,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          business,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: selectedBusiness == business
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 50),

            // ✅ Proceed Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NavigationScreen()),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Text('Proceed', style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

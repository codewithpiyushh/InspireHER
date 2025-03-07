import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'navigation_menu.dart';
import '../l10n/app_localizations.dart';

class FrontPage extends StatefulWidget {
  const FrontPage({super.key});

  @override
  _FrontPageState createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  String selectedLanguage = 'en_US';
  String selectedBusiness = 'dairy'; // Default business
  List<String> businesses = [];

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadLocalizedBusinesses();
    });
  }

  // ✅ Load saved preferences for language & business type
  Future<void> loadPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedLanguage = prefs.getString('selected_language') ?? 'en_US';
      selectedBusiness = prefs.getString('selected_business') ?? 'dairy';
    });
  }

  void loadLocalizedBusinesses() {
    setState(() {
      businesses = [
        AppLocalizations.of(context)?.dairy ?? "dairy",
        AppLocalizations.of(context)?.bakery ?? "Bakery",
        AppLocalizations.of(context)?.supermarket ?? "Supermarket",
        AppLocalizations.of(context)?.convenience ?? "Convenience",
      ];
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
    print("Saved Business: $business"); // Debugging log
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            Text(
              AppLocalizations.of(context)?.select_language ??
                  'Select Language',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // ✅ Language Dropdown
            DropdownButton<String>(
              value: ['en_US', 'hi_IN', 'or', 'ta'].contains(selectedLanguage)
                  ? selectedLanguage
                  : 'en_US',
              items: [
                DropdownMenuItem(value: 'en_US', child: Text('English')),
                DropdownMenuItem(value: 'hi_IN', child: Text('हिन्दी')),
                DropdownMenuItem(value: 'or', child: Text('ଓଡ଼ିଆ')),
                DropdownMenuItem(value: 'ta', child: Text('தமிழ்')),
              ],
              onChanged: (String? newValue) async {
                if (newValue != null) {
                  setState(() {
                    selectedLanguage = newValue;
                  });
                  await saveSelectedLanguage(newValue);

                  // 🛠️ Handle cases where newValue has no underscore
                  List<String> localeParts = newValue.split('_');
                  String languageCode = localeParts[0]; // Always present
                  String? countryCode =
                      localeParts.length > 1 ? localeParts[1] : null;

                  Get.updateLocale(countryCode != null
                      ? Locale(languageCode, countryCode)
                      : Locale(languageCode)); // Handle single-part locales
                }
              },
              isExpanded: true,
            ),

            const SizedBox(height: 40),

            Text(
              AppLocalizations.of(context)?.select_business ??
                  'Select Business',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

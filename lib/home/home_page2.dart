import 'package:flutter/material.dart';
import '../finance/invest.dart';
import 'courses.dart';
import 'forms.dart';
import '../l10n/app_localizations.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with profile
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    // Profile image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/image23.jpg',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Name and greeting
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)?.namastetile??'Namaste',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)!.businessName,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A1A3F),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Help icon
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(10),
                      child:
                          const Icon(Icons.question_mark, color: Colors.black),
                    ),
                    const SizedBox(width: 12),
                    // Notification icon
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(10),
                          child: const Icon(Icons.notifications_outlined,
                              color: Colors.black),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Scrollable scheme banners
              SizedBox(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _buildSchemeBanner(imagePath: 'assets/scheme3.webp'),
                    _buildSchemeBanner(imagePath: 'assets/scheme2.jpg'),
                    _buildSchemeBanner(imagePath: 'assets/scheme1.png'),
                  ],
                ),
              ),

              // Quick Services title
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                child: Text(
                  AppLocalizations.of(context)!.quick,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),

              // Quick Services icons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildQuickServiceItem(
                      Icons.book,
                      AppLocalizations.of(context)!.courses,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GovernmentCoursesPage(),
                          ),
                        );
                      },
                    ),
                    _buildQuickServiceItem(
                      Icons.description,
                      AppLocalizations.of(context)!.forms,
                      () async {
                        String selectedBusiness =
                            await BusinessPreferences.getSelectedBusiness();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BusinessFormsScreen(
                              selectedBusiness: selectedBusiness,
                            ),
                          ),
                        );
                      },
                    ),
                    _buildQuickServiceItem(
                      Icons.trending_up,
                      AppLocalizations.of(context)!.invest,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FinancePage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )

              // Dashboard title
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSchemeBanner({required String imagePath}) {
    return Container(
      width: 280, // Reduced width to create the hole effect
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Image.asset(
              imagePath,
              width: 280,
              height: 360,
              fit: BoxFit.cover,
            ),
            Positioned(
              right:
                  -10, // Slightly overlaps the next banner for the hole effect
              top: 0,
              bottom: 0,
              child: Container(
                width: 20,
                decoration: BoxDecoration(
                  color: Colors.transparent, // Creates the hole effect
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickServiceItem(
      IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 32, color: Colors.blue),
          const SizedBox(height: 8),
          Text(label,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

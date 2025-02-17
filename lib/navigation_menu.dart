import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'conn/connect.dart'; // Import Connection Page
import 'lear/try.dart'; // Import Learning Page
import 'set/setup.dart'; // Import Setup Page
import 'finance/invest.dart'; // Import Finance Page
import 'home/home_page.dart';
import 'l10n/app_localizations.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0; // Default page is Home

  final List<Widget> _pages = [
    DairyDashboard(), // Home Page
    HomePage(), // Connection Page
    LearnScreen(), // Learning Page
    NearbyShopsScreen(), // Setup Page (Settings)
    FinancePage(), // Finance Page
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 250, 250),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color.fromARGB(255, 56, 125, 193),
        items: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.home,
                  size: 30, color: Color.fromARGB(255, 4, 60, 123)),
              Text(AppLocalizations.of(context)!.home, style: TextStyle(fontSize: 12, color: Colors.black)),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.link,
                  size: 30, color: Color.fromARGB(255, 4, 60, 123)),
              Text(AppLocalizations.of(context)!.connecting,
                  style: TextStyle(fontSize: 12, color: Colors.black)),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.school,
                  size: 30, color: Color.fromARGB(255, 4, 60, 123)),
              Text(AppLocalizations.of(context)!.Learning,
                  style: TextStyle(fontSize: 12, color: Colors.black)),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.location_on,
                  size: 30, color: Color.fromARGB(255, 4, 60, 123)),
              Text(AppLocalizations.of(context)!.setuping,
                  style: TextStyle(fontSize: 12, color: Colors.black)),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.attach_money,
                  size: 30, color: Color.fromARGB(255, 4, 60, 123)),
              Text(AppLocalizations.of(context)!.financing,
                  style: TextStyle(fontSize: 12, color: Colors.black)),
            ],
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // Change the page when tapped
          });
        },
      ),
      body: _pages[_selectedIndex], // Show selected page
    );
  }
}

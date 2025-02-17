import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import Get package
import 'firstpage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart'; // Correct import

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Use GetMaterialApp for GetX support
      debugShowCheckedModeBanner: false,
      locale: Get.deviceLocale, // Set to device's default locale
      fallbackLocale: Locale('en'), // Fallback language
      supportedLocales: [
        Locale('en'), // English
        Locale('hi'), // Hindi
      ],

      localizationsDelegates: [
        AppLocalizations.delegate, // Corrected name
        GlobalMaterialLocalizations.delegate, // Fixed typo
        GlobalWidgetsLocalizations.delegate, // Fixed typo
        GlobalCupertinoLocalizations.delegate, // Fixed typo
      ],

      home: FrontPage(), // Main screen
    );
  }
}

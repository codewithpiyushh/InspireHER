import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
    Locale('ta')
  ];

  /// No description provided for @title1.
  ///
  /// In en, this message translates to:
  /// **'From Sunrise to Harvest: Daily Stories from the Field'**
  String get title1;

  /// No description provided for @author1.
  ///
  /// In en, this message translates to:
  /// **'Kavita Singh'**
  String get author1;

  /// No description provided for @title2.
  ///
  /// In en, this message translates to:
  /// **'From Grass to Glass: Insights for Efficient Milk Production'**
  String get title2;

  /// No description provided for @author2.
  ///
  /// In en, this message translates to:
  /// **'Renu Dalal'**
  String get author2;

  /// No description provided for @title3.
  ///
  /// In en, this message translates to:
  /// **'Cream of the Crop: Tips to Boost Dairy Productivity'**
  String get title3;

  /// No description provided for @author3.
  ///
  /// In en, this message translates to:
  /// **'Ritu Kalonia'**
  String get author3;

  /// No description provided for @title4.
  ///
  /// In en, this message translates to:
  /// **'The Daily Moo: Your Guide to Thriving in Dairy Farming'**
  String get title4;

  /// No description provided for @author4.
  ///
  /// In en, this message translates to:
  /// **'Sanjay Singh'**
  String get author4;

  /// No description provided for @title5.
  ///
  /// In en, this message translates to:
  /// **'From Pasture to Profit: Maximizing Your Dairy Farm\'s Potential'**
  String get title5;

  /// No description provided for @author5.
  ///
  /// In en, this message translates to:
  /// **'Deepak Kumar'**
  String get author5;

  String get learnTitle;
  String get nameNeeta;

  String get writeMessage;
  String get financialCourses;
  String get seeAll;
  String get all;
  String get financialLiteracy;
  String get microInvestment;
  String get creditUse;
  String get namastetile;
  String get ongoingCourse;
  String get askChatbot;
  String get businessAddress;
  String get businessName;
  String get finance;
  String get loanSchemes;
  String get investmentOptions;
  String get loanCalculator;
  String get loanAmount;
  String get interestRate;
  String get timePeriod;
  String get years;
  String get calculateEMI;
  String get monthlyEMI;
  String get maximumLoanAmount;
  String get contact;
  String get expectedReturns;
  String get minimumAmount;
  String get duration;
  String get profileName;
  String get designation;
  String get location;
  String get scheduleCall;
  String get following;
  String get readMore;
  String get postContent;
  String get postDesignation;
  String get postAuthor;
  String get postSection;
  String get message;
  String get profitLastMonth;
  String get profitValue;
  String get sales;
  String get salesValue;
  String get connectionInfo;
  String get message5;
  String get message4;
  String get message3;
  String get message2;
  String get message1;
  String get messages;
  String get videosForYou;
  String get financeExpert;
  String get dairyFarmExpert;
  String get poojaPandey;
  String get topMentor;
  String get becomeAMentor;
  String get connect;
  String get fullScreenVideo;
  String get sheelaDevi;
  String get nearbyShops;
  String get dairy;
  String get bakery;
  String get supermarket;
  String get convenience;
  String get search;
  String get select_business;
  String get select_language;
  String get home;
  String get connecting;
  String get Learning;
  String get setuping;
  String get financing;
  String get introductionToBusiness;
  String get hintText;
  String get quick;
  String get courses;
  String get forms;
  String get invest;
  String get nameNikita;
  String get nameManya;
  String get nameShagun;
  String get cattleFeedingGuide;
  String get cattleFeedingContent;
  String get grass;
  String get grassDescription;
  String get hay;
  String get twoDaysAgo;

  String get oneDayAgo;
  String get npddTitle;
  String get npddContent;
  String get npddPoint1;
  String get npddPoint2;
  String get npddPoint3;
  String get suppliers;
  String get cattles;
  String get containers;
  String get milkCoolers;
  String get packaging;
  String get transportation;
  String get fooder;

  String get sureshCattle;
  String get sureshCattleDesc;
  String get maheshCattles;
  String get maheshCattlesDesc;
  String get rajeshLivestock;
  String get rajeshLivestockDesc;
  String get vikramDairyFarms;
  String get vikramDairyFarmsDesc;

  String get fashionTrends;
  String get fashionTrendsDesc;
  String get wearWellLtd;
  String get wearWellLtdDesc;
  String get styleHub;
  String get styleHubDesc;
  String get eliteFabrics;
  String get eliteFabricsDesc;

  String get homeStyleFurnishings;
  String get homeStyleFurnishingsDesc;
  String get woodCrafters;
  String get woodCraftersDesc;
  String get elegantLiving;
  String get elegantLivingDesc;
  String get timberArtisans;
  String get timberArtisansDesc;

  String get motherMilkPackagers;
  String get motherMilkPackagersDesc;
  String get rutuPackagers;
  String get rutuPackagersDesc;
  String get purePackDairy;
  String get purePackDairyDesc;
  String get ecoWrapSolutions;
  String get ecoWrapSolutionsDesc;

  String get speedyLogistics;
  String get speedyLogisticsDesc;
  String get safeHaulMovers;
  String get safeHaulMoversDesc;
  String get swiftTransit;
  String get swiftTransitDesc;
  String get guardianFreight;
  String get guardianFreightDesc;

  String get greenHarvest;
  String get greenHarvestDesc;
  String get agroFeedSupply;
  String get agroFeedSupplyDesc;
  String get freshGraze;
  String get freshGrazeDesc;
  String get nutriFeedSolutions;
  String get nutriFeedSolutionsDesc;
  String get whatAreYouLookingFor;
  String get becomeasupplier;
  String get fodder;
  String get placestosetup;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
    case 'or':
      return AppLocalizationsHi();
    case 'ta':
      return AppLocalizationsHi();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}

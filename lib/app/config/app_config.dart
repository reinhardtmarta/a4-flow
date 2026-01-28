import 'package:shared_preferences/shared_preferences.dart';

class AppConfig {
  static late SharedPreferences _prefs;

  // App metadata
  static const String appName = 'A4 Flow';
  static const String appVersion = '1.0.0';
  static const String appSlug = 'a4-flow';

  // Canvas configuration
  static const double a4Width = 210.0; // mm
  static const double a4Height = 297.0; // mm
  static const double dpi = 96.0;
  static const double mmToPixels = dpi / 25.4;

  // Editor configuration
  static const int maxUndoActions = 50;
  static const double minZoom = 0.25;
  static const double maxZoom = 4.0;

  // Supported languages
  static const List<String> supportedLanguages = [
    'pt_BR', // Portuguese (Brazil)
    'en_US', // English (United States)
    'es_ES', // Spanish
    'fr_FR', // French
    'de_DE', // German
    'it_IT', // Italian
    'zh_CN', // Chinese (Simplified)
    'ru_RU', // Russian
  ];

  // Default settings
  static const String defaultLanguage = 'pt_BR';
  static const bool defaultDarkMode = false;
  static const String defaultUnit = 'mm'; // mm, cm, pt

  // Feature flags
  static const bool enableAdMob = true;
  static const bool enableCloudSync = false; // Always false - local only
  static const bool enableBeta = false;

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static SharedPreferences get prefs => _prefs;

  // Preference helpers
  static String getLanguage() {
    return _prefs.getString('language') ?? defaultLanguage;
  }

  static Future<void> setLanguage(String language) async {
    await _prefs.setString('language', language);
  }

  static bool getDarkMode() {
    return _prefs.getBool('darkMode') ?? defaultDarkMode;
  }

  static Future<void> setDarkMode(bool isDark) async {
    await _prefs.setBool('darkMode', isDark);
  }

  static String getUnit() {
    return _prefs.getString('unit') ?? defaultUnit;
  }

  static Future<void> setUnit(String unit) async {
    await _prefs.setString('unit', unit);
  }

  static bool getTermsAccepted() {
    return _prefs.getBool('termsAccepted') ?? false;
  }

  static Future<void> setTermsAccepted(bool accepted) async {
    await _prefs.setBool('termsAccepted', accepted);
  }

  static bool getAdWarningShown() {
    return _prefs.getBool('adWarningShown') ?? false;
  }

  static Future<void> setAdWarningShown(bool shown) async {
    await _prefs.setBool('adWarningShown', shown);
  }
}

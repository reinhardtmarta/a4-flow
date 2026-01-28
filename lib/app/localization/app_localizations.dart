import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'localization_pt_br.dart';
import 'localization_en_us.dart';
import 'localization_es.dart';
import 'localization_fr.dart';
import 'localization_de.dart';
import 'localization_it.dart';
import 'localization_zh_cn.dart';
import 'localization_ru.dart';

class AppLocalizations {
  final Locale locale;
  late Map<String, String> _localizedStrings;

  AppLocalizations(this.locale) {
    _loadLocalizedStrings();
  }

  void _loadLocalizedStrings() {
    final languageCode = locale.languageCode;
    final countryCode = locale.countryCode;
    final fullCode = countryCode != null ? '${languageCode}_$countryCode' : languageCode;

    switch (fullCode) {
      case 'pt_BR':
        _localizedStrings = localizationPtBr;
        break;
      case 'en_US':
      case 'en':
        _localizedStrings = localizationEnUs;
        break;
      case 'es_ES':
      case 'es':
        _localizedStrings = localizationEs;
        break;
      case 'fr_FR':
      case 'fr':
        _localizedStrings = localizationFr;
        break;
      case 'de_DE':
      case 'de':
        _localizedStrings = localizationDe;
        break;
      case 'it_IT':
      case 'it':
        _localizedStrings = localizationIt;
        break;
      case 'zh_CN':
      case 'zh':
        _localizedStrings = localizationZhCn;
        break;
      case 'ru_RU':
      case 'ru':
        _localizedStrings = localizationRu;
        break;
      default:
        _localizedStrings = localizationPtBr;
    }
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = [
    Locale('pt', 'BR'),
    Locale('en', 'US'),
    Locale('es', 'ES'),
    Locale('fr', 'FR'),
    Locale('de', 'DE'),
    Locale('it', 'IT'),
    Locale('zh', 'CN'),
    Locale('ru', 'RU'),
  ];

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }

  // Common translations
  String get appName => translate('appName');
  String get home => translate('home');
  String get settings => translate('settings');
  String get newDocument => translate('newDocument');
  String get openDocument => translate('openDocument');
  String get save => translate('save');
  String get export => translate('export');
  String get delete => translate('delete');
  String get cancel => translate('cancel');
  String get confirm => translate('confirm');
  String get language => translate('language');
  String get theme => translate('theme');
  String get darkMode => translate('darkMode');
  String get lightMode => translate('lightMode');
  String get unit => translate('unit');
  String get about => translate('about');
  String get termsOfService => translate('termsOfService');
  String get privacyPolicy => translate('privacyPolicy');
  String get adWarning => translate('adWarning');
  
  // Editor modes
  String get articleMode => translate('articleMode');
  String get spreadsheetMode => translate('spreadsheetMode');
  String get drawingMode => translate('drawingMode');
  String get calculatorMode => translate('calculatorMode');
  String get symbolsMode => translate('symbolsMode');
  String get latexMode => translate('latexMode');
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.supportedLocales
        .any((l) => l.languageCode == locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

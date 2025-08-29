// import 'package:flutter/material.dart';
// import 'ar.dart';
// import 'en.dart';

// class AppLocalizations {
//   AppLocalizations(this.locale);

//   final Locale locale;

//   static AppLocalizations? of(BuildContext context) {
//     return Localizations.of<AppLocalizations>(context, AppLocalizations);
//   }

//   static const LocalizationsDelegate<AppLocalizations> delegate =
//       _AppLocalizationsDelegate();

//   Map<String, String> get translations {
//     switch (locale.languageCode) {
//       case 'ar':
//         return ar;
//       case 'en':
//       default:
//         return en;
//     }
//   }

//   String translate(String key) {
//     return translations[key] ?? key;
//   }
// }

// class _AppLocalizationsDelegate
//     extends LocalizationsDelegate<AppLocalizations> {
//   const _AppLocalizationsDelegate();

//   @override
//   bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

//   @override
//   Future<AppLocalizations> load(Locale locale) async {
//     return AppLocalizations(locale);
//   }

//   @override
//   bool shouldReload(_AppLocalizationsDelegate old) => false;
// }
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:property_system/l10n/ar.dart';
import 'package:property_system/l10n/en.dart';

class AppLocalizations {
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  final Locale locale;

  AppLocalizations(this.locale);

  static const Map<String, Map<String, String>> _localizedValues = {
    'ar': ar,
    'en': en,
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['ar', 'en'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
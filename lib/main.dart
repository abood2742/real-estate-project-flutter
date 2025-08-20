
// import 'package:flutter/material.dart';
// import 'package:property_system/client/screens/initial_page.dart';
// import 'notification/socket_service.dart'; // استدعاء الملف الجديد

// void main() {
//   runApp(PropertySystem());
// }

// class PropertySystem extends StatelessWidget {
//   const PropertySystem({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // إنشاء خدمة الـ Socket وتشغيل الاتصال
//     final SocketService socketService = SocketService();
//     socketService.connect();

//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       builder: (context, child) {
//         return Directionality(
//           textDirection: TextDirection.rtl, // تعيين الاتجاه إلى RTL هنا
//           child: child!,
//         );
//       },
//       home: Scaffold(
//         backgroundColor: Colors.white,
//         body: InitialPage(),
//       ),
//     );
//   }
// }


// // import 'package:flutter/material.dart';
// // import 'package:flutter_localizations/flutter_localizations.dart';

// // void main() {
// //   runApp(MyApp());
// // }

// // class MyApp extends StatefulWidget {
// //   @override
// //   State<MyApp> createState() => _MyAppState();
// // }

// // class _MyAppState extends State<MyApp> {
// //   Locale _locale = Locale('ar'); // اللغة الافتراضية: عربية

// //   void _changeLanguage(String langCode) {
// //     setState(() {
// //       _locale = Locale(langCode);
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'MyApp',
// //       locale: _locale,
// //       supportedLocales: [
// //         Locale('ar', ''), // Arabic
// //         Locale('en', ''), // English
// //       ],
// //       localizationsDelegates: [
// //         GlobalMaterialLocalizations.delegate,
// //         GlobalWidgetsLocalizations.delegate,
// //         GlobalCupertinoLocalizations.delegate,
// //       ],
// //       home: HomePage(onChangeLanguage: _changeLanguage),
// //     );
// //   }
// // }

// // class HomePage extends StatelessWidget {
// //   final Function(String) onChangeLanguage;
// //   HomePage({required this.onChangeLanguage});

// //   // ترجمات النصوص داخل الكود
// //   final Map<String, Map<String, String>> translations = {
// //     'en': {'welcome': 'Welcome', 'login': 'Login'},
// //     'ar': {'welcome': 'أهلاً وسهلاً', 'login': 'تسجيل الدخول'},
// //   };

// //   String tr(BuildContext context, String key) {
// //     String lang = Localizations.localeOf(context).languageCode;
// //     return translations[lang]?[key] ?? key;
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text(tr(context, 'welcome'))),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Text(tr(context, 'login'), style: TextStyle(fontSize: 24)),
// //             SizedBox(height: 30),
// //             ElevatedButton(
// //               onPressed: () => onChangeLanguage('en'),
// //               child: Text('Switch to English'),
// //             ),
// //             SizedBox(height: 10),
// //             ElevatedButton(
// //               onPressed: () => onChangeLanguage('ar'),
// //               child: Text('التبديل إلى العربية'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:property_system/client/screens/initial_page.dart';
import 'notification/socket_service.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(const PropertySystem());
}

class LocalizationProvider with ChangeNotifier {
  Locale _locale = const Locale('ar'); // اللغة الافتراضية عربية

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (_locale != locale) {
      _locale = locale;
      notifyListeners();
    }
  }
}

class PropertySystem extends StatelessWidget {
  const PropertySystem({super.key});

  @override
  Widget build(BuildContext context) {
    // إنشاء خدمة الـ Socket وتشغيل الاتصال
    final SocketService socketService = SocketService();
    socketService.connect();

    return ChangeNotifierProvider(
      create: (_) => LocalizationProvider(),
      child: Consumer<LocalizationProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: provider.locale,
            supportedLocales: const [
              Locale('en', ''),
              Locale('ar', ''),
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            builder: (context, child) {
              return Directionality(
                textDirection: provider.locale.languageCode == 'ar'
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child: child!,
              );
            },
            home: Scaffold(
              backgroundColor: Colors.white,
              body: InitialPage(),
            ),
          );
        },
      ),
    );
  }
}
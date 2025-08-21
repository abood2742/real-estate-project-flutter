
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
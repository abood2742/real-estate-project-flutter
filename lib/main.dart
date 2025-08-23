import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:property_system/client/models/profile.model.dart';
import 'package:property_system/client/services/user_profile.service.dart';
import 'package:provider/provider.dart';
import 'package:property_system/client/screens/initial_page.dart';
import 'notification/socket_service.dart';
import 'l10n/app_localizations.dart';

void main() async {
  String? id = await PropertySystem().getUser();

  runApp(OverlaySupport.global(
      // مهم جداً
      child: PropertySystem(id: id)));
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
  final String? id;
  const PropertySystem({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    if (id != null) {
      // إنشاء خدمة الـ Socket وتشغيل الاتصال
      final SocketService socketService = SocketService();
      socketService.connect(id!);
    }

    return ChangeNotifierProvider(
      create: (_) => LocalizationProvider(),
      child: Consumer<LocalizationProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            theme: ThemeData(
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white), // تغيير لون الأيقونات (بما في ذلك السهم)
          backgroundColor: Colors.blue, // لون الخلفية للتوافق
        ),
      ),
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

  Future<String?> getUser() async {
    ProfileModel? user = await ProfileService().getProfile();
    if (user == (null)) {
      return null;
    }
    return user.id;
  }
}

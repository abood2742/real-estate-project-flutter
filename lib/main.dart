import 'package:flutter/material.dart';
import 'package:property_system/client/screens/main/main_page.dart';


void main() {
  runApp(PropertySystem());
}

class PropertySystem extends StatelessWidget {
  const PropertySystem({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl, // تعيين الاتجاه إلى RTL هنا
          child: child!,
        );
      },
      home: Scaffold(
        backgroundColor: Colors.white,
        body: MainPage(),
      ),
    );
  }
}

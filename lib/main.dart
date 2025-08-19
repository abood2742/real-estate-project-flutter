
import 'package:flutter/material.dart';
import 'package:property_system/client/screens/initial_page.dart';
import 'socket_service.dart'; // استدعاء الملف الجديد

void main() {
  runApp(PropertySystem());
}

class PropertySystem extends StatelessWidget {
  const PropertySystem({super.key});

  @override
  Widget build(BuildContext context) {
    // إنشاء خدمة الـ Socket وتشغيل الاتصال
    final SocketService socketService = SocketService();
    socketService.connect();

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
        body: InitialPage(),
      ),
    );
  }
}

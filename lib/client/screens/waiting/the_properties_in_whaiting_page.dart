import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:property_system/client/screens/waiting/expired_properties_to_push_page.dart';
import 'package:property_system/client/screens/waiting/properties_dont_pushed_yet_page.dart';


class ThePropertiesInWhaitingPage extends StatelessWidget {
  const ThePropertiesInWhaitingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 53, 150, 148),
          // أزلت toolbarHeight أو خليته صغير إذا حبيت:
          toolbarHeight: 40, // جرب 70 لو 56 صغير جدا لك
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '  حالة النشر',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              const SizedBox(width: 8),
              SizedBox(
                height: 30, // صغر حجم الانميشن
                width: 30,
                child: Lottie.asset(
                  'assets/push.json',
                  repeat: true,
                  animate: true,
                ),
              ),
            ],
          ),
          centerTitle: true,
          bottom: const TabBar( 
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(icon: Icon(Icons.done), text: 'عقارات نشرت وانتهت'),
              Tab(icon: Icon(Icons.line_axis), text: ' عقارات لم تنشر بعد'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ExpiredPropertiesToPushPage(),
            PropertiesDontPushedYetPage(),
          ],
        ),
      ),
    );
  }
}

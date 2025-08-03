import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:property_system/client_user/screens/cloused_compailent_page.dart';
import 'package:property_system/client_user/screens/existing_compailent_page.dart';

class ComplaientPage extends StatelessWidget {
  const ComplaientPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF3D60C6),
          // أزلت toolbarHeight أو خليته صغير إذا حبيت:
          toolbarHeight: 40, // جرب 70 لو 56 صغير جدا لك
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'تقديم شكوى',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              const SizedBox(width: 8),
              SizedBox(
                height: 30, // صغر حجم الانميشن
                width: 30,
                child: Lottie.asset(
                  'assets/complaint.json',
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
              Tab(icon: Icon(Icons.report_problem), text: 'الشكاوى القائمة'),
              Tab(icon: Icon(Icons.done), text: 'الشكاوى المنتهية'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ExistingCompailentPage(),
            ClousedCompailentPage(),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:property_system/client/screens/saved/SavedOfficesPage.dart';
import 'package:property_system/client/screens/saved/SavedPropertiesPage.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF3D60C6),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'محفوظات',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                SizedBox(width: 6),
                SizedBox(
                  height: 40,
                  width: 40,
                  child: Lottie.asset(
                    'assets/more_Animation.json',
                    repeat: true,
                    animate: true,
                  ),
                ),
              ],
            ),
            centerTitle: true,
            bottom: TabBar(
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              tabs: [
                Tab(icon: Icon(Icons.home), text: 'العقارات'),
                Tab(icon: Icon(Icons.business), text: 'المكاتب'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              SavedPropertiesPage(), // ✅ صفحة العقارات
              SavedOfficesPage(),    // ✅ صفحة المكاتب
            ],
          ),
        ),
      ),
    );
  }
}

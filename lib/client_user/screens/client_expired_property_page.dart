import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:property_system/client_user/screens/SavedOfficesPage.dart';
import 'package:property_system/client_user/screens/SavedPropertiesPage.dart';
import 'package:property_system/client_user/screens/client_experid_for_rent_page_.dart';
import 'package:property_system/client_user/screens/client_expired_for_buy_page.dart';

class ClientExpiredPropertyPage extends StatelessWidget {
  const ClientExpiredPropertyPage({super.key});

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
                  'عقاراتك المنتهية',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                SizedBox(width: 6),
                // SizedBox(
                //   height: 40,
                //   width: 40,
                //   child: Lottie.asset(
                //     'assets/more_Animation.json',
                //     repeat: true,
                //     animate: true,
                //   ),
                // ),
              ],
            ),
            centerTitle: true,
            bottom: TabBar(
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              tabs: [
                Tab(icon: Icon(Icons.home), text: 'عقارات الشراء '),
                Tab(icon: Icon(Icons.business), text: 'عقارات الايجار'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ClientExpiredForBuyPage(),
              ClientExpiredForRentPage(),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:property_system/client/screens/main/more/client_properties/client_experid_for_rent_page_.dart';
// import 'package:property_system/client/screens/main/more/client_properties/client_expired_for_buy_page.dart';

// class ClientExpiredPropertyPage extends StatelessWidget {
//   const ClientExpiredPropertyPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: DefaultTabController(
//         length: 2,
//         child: Scaffold(
//           appBar: AppBar(
//             backgroundColor: Color(0xFF3D60C6),
//             title: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   'عقاراتك المنتهية',
//                   style: TextStyle(fontSize: 20, color: Colors.white),
//                 ),
//                 SizedBox(width: 6),
//                 // SizedBox(
//                 //   height: 40,
//                 //   width: 40,
//                 //   child: Lottie.asset(
//                 //     'assets/more_Animation.json',
//                 //     repeat: true,
//                 //     animate: true,
//                 //   ),
//                 // ),
//               ],
//             ),
//             centerTitle: true,
//             bottom: TabBar(
//               indicatorColor: Colors.white,
//               labelColor: Colors.white,
//               unselectedLabelColor: Colors.white70,
//               tabs: [
//                 Tab(icon: Icon(Icons.home), text: 'عقارات الشراء '),
//                 Tab(icon: Icon(Icons.business), text: 'عقارات الايجار'),
//               ],
//             ),
//           ),
//           body: TabBarView(
//             children: [
//               ClientExpiredForBuyPage(),
//               ClientExpiredForRentPage(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:property_system/client/screens/main/more/client_properties/client_experid_for_rent_page_.dart';
import 'package:property_system/client/screens/main/more/client_properties/client_expired_for_buy_page.dart';
import 'package:property_system/l10n/app_localizations.dart';

class ClientExpiredPropertyPage extends StatelessWidget {
  const ClientExpiredPropertyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF3D60C6),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                localizations.translate('your_expired_properties'),
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontFamily: 'Pacifico',
                ),
              ),
              // const SizedBox(width: 6),
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
              Tab(
                icon: const Icon(Icons.home),
                text: localizations.translate('properties_for_sale'),
              ),
              Tab(
                icon: const Icon(Icons.business),
                text: localizations.translate('properties_for_rent'),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ClientExpiredForBuyPage(),
            ClientExpiredForRentPage(),
          ],
        ),
      ),
    );
  }
}
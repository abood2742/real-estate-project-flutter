// // 
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:property_system/client/screens/favorite/Favorite_Offices_Page.dart';
// import 'package:property_system/client/screens/favorite/Favorite_Properties_Page.dart';
// import 'package:property_system/l10n/app_localizations.dart';
// import 'package:property_system/office/reservation/reservation_rent.dart';
// import 'package:property_system/office/reservation/reservation_sell.dart';

// class OfficeReservationPage extends StatelessWidget {
//   const OfficeReservationPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final localizations = AppLocalizations.of(context)!;

//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: const Color.fromARGB(255, 79, 142, 147),
//           title: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 'حجز عقار',
//                 style: const TextStyle(fontSize: 20, color: Colors.white),
//               ),
//               const SizedBox(width: 6),
//               SizedBox(
//                 height: 30,
//                 width: 30,
//                 child: Lottie.asset(
//                   'assets/Reservation.json',height: 40,width: 30,
                  
//                   repeat: true,
//                   animate: true,
//                 ),
//               ),
//             ],
//           ),
//           centerTitle: true,
//           bottom: TabBar(
//             indicatorColor: Colors.white,
//             labelColor: Colors.white,
//             unselectedLabelColor: Colors.white70,
//             tabs: [
//               Tab(
               
//                 text:'للبيع'
//               ),
//               Tab(
                
//                 text: 'للشراء'
//               ),
//             ],
//           ),
//         ),
//         body: const TabBarView(
//           children: [
//             ReservationSell(),
//             ReservationRent(),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:property_system/client/screens/favorite/Favorite_Offices_Page.dart';
import 'package:property_system/client/screens/favorite/Favorite_Properties_Page.dart';
import 'package:property_system/l10n/app_localizations.dart';
import 'package:property_system/office/reservation/reservation_rent.dart';
import 'package:property_system/office/reservation/reservation_sell.dart';

class OfficeReservationPage extends StatelessWidget {
  const OfficeReservationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 79, 142, 147),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'حجز عقار',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Lottie.asset(
                'assets/Reservation.json',
                height: 70, // حجم أكبر
                width: 70,
                repeat: true,
                animate: true,
              ),
            ],
          ),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: 'للبيع'),
              Tab(text: 'للشراء'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ReservationSell(),
            ReservationRent(),
          ],
        ),
      ),
    );
  }
}

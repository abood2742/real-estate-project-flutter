// // ThePropertiesInWaitingPage.dart
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:property_system/office/screens/waiting/Accepted_Properties_Page.dart';
// import 'package:property_system/office/screens/waiting/Pending_Properties_Page.dart';
// import 'package:property_system/l10n/app_localizations.dart';

// class MyPropertiesPage extends StatelessWidget {
//   const MyPropertiesPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final localizations = AppLocalizations.of(context)!;

//     return DefaultTabController(
//       length: 2,
//       initialIndex: 0, // الافتراضي: ExpiredPropertiesToPushPage
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: const Color.fromARGB(255, 39, 161, 199),
//           toolbarHeight: 40,
//           title: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 localizations.translate('عقاراتي'),
//                 style: const TextStyle(
//                   fontSize: 20,
//                   color: Colors.white,
//                   fontFamily: 'Pacifico',
//                 ),
//               ),
//               const SizedBox(width: 8),
//               SizedBox(
//                 height: 30,
//                 width: 30,
//                 child: Lottie.asset(
//                   'assets/push.json',
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
//                 icon: const Icon(Icons.done),
//                 text: localizations.translate('عقارات منشورة'),
//               ),
//               Tab(
//                 icon: const Icon(Icons.line_axis),
//                 text: localizations.translate('عقارات في انتظار الموافقة'),
//               ),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: const [
//             AcceptedPropertiesPage(),
//             PendingPropertiesPage(),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:property_system/office/screens/waiting/Accepted_Properties_Page.dart';
import 'package:property_system/office/screens/waiting/Pending_Properties_Page.dart';
import 'package:property_system/l10n/app_localizations.dart';

class MyPropertiesPage extends StatelessWidget {
  const MyPropertiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return DefaultTabController(
      length: 2,
      initialIndex: 0, // الافتراضي: ExpiredPropertiesToPushPage
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 39, 161, 199),
          toolbarHeight: 40,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                localizations.translate('my_properties'),
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontFamily: 'Pacifico',
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                height: 30,
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
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(
                icon: const Icon(Icons.done),
                text: localizations.translate('published_properties'),
              ),
              Tab(
                icon: const Icon(Icons.line_axis),
                text: localizations.translate('pending_properties'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: const [
            AcceptedPropertiesPage(),
            PendingPropertiesPage(),
          ],
        ),
      ),
    );
  }
}

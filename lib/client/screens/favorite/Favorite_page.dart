
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:property_system/client/screens/favorite/Favorite_Offices_Page.dart';
// import 'package:property_system/client/screens/favorite/Favorite_Properties_Page.dart';
// import 'package:property_system/l10n/app_localizations.dart';

// class FavoritePage extends StatelessWidget {
//   const FavoritePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final localizations = AppLocalizations.of(context)!;

//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           leading: const BackButton(
//             color: Colors.white, // تغيير لون السهم إلى الأبيض
//           ),
//           backgroundColor: const Color.fromARGB(255, 17, 150, 199),
//           title: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 localizations.translate('favorites'),
//                 style: const TextStyle(fontSize: 24, color: Colors.white),
//               ),
//               const SizedBox(width: 6),
//               // استخدام Lottie من الإنترنت
//               SizedBox(
//                 height: kToolbarHeight, // مناسب لارتفاع AppBar
//                 width: kToolbarHeight,
//                 child: Lottie.asset(
//                   'assets/more_Animation.json',
//                   fit: BoxFit.contain,
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
//                 icon: const Icon(Icons.home),
//                 text: localizations.translate('properties'),
//               ),
//               Tab(
//                 icon: const Icon(Icons.business),
//                 text: localizations.translate('offices'),
//               ),
//             ],
//           ),
//         ),
//         body: const TabBarView(
//           children: [
//             FavoritePropertiesPage(),
//             FavoriteOfficesPage(),
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

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120), // ✅ طول أكبر
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: const Color.fromARGB(255, 17, 150, 199),
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ✅ النص + الأنيميشن بالنصف الأول
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        localizations.translate('favorites'),
                        style: const TextStyle(fontSize: 24, color: Colors.white),
                      ),
                      const SizedBox(width: 6),
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: Lottie.asset(
                          'assets/more_Animation.json',
                          fit: BoxFit.contain,
                          repeat: true,
                          animate: true,
                        ),
                      ),
                    ],
                  ),
                ),

                // ✅ التاب بار بالنصف التاني
                const Divider(color: Colors.white, height: 1),
                Expanded(
                  child: TabBar(
                    indicatorColor: Colors.white,
                    labelColor: Colors.white,
                       dividerColor: Colors.white, // ✅ الخط الأبيض بين التابات
                    dividerHeight: 2,
                    unselectedLabelColor: Colors.white70,
                    tabs: [
                      Tab(
                        icon: const Icon(Icons.home),
                        text: localizations.translate('properties'),
                      ),
                      
                      Tab(
                        icon: const Icon(Icons.business),
                        text: localizations.translate('offices'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            FavoritePropertiesPage(),
            FavoriteOfficesPage(),
          ],
        ),
      ),
    );
  }
}

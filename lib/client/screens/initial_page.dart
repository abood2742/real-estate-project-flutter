// import 'package:flutter/material.dart';
// import 'package:property_system/client/screens/auth/login/login_page.dart';
// import 'package:property_system/client/screens/auth/register/start_register_page.dart';
// import 'package:property_system/l10n/app_localizations.dart';

// class InitialPage extends StatelessWidget {
//   const InitialPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final localizations = AppLocalizations.of(context)!;

//     return Scaffold(
//       body: Center(
//         child: ListView(
//           shrinkWrap: true,
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
//               child: Container(
//                 height: 400,
//                 width: 330,
//                 decoration: BoxDecoration(
//                   color: Colors.white70,
//                   borderRadius: BorderRadius.circular(24),
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(24),
//                   child: Image.asset(
//                     'assets/images/init.png',
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//             Text(
//               localizations.translate('property_system'),
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 fontFamily: 'Pacifico',
//                 color: Color.fromARGB(255, 57, 15, 125),
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 50),
//             Text(
//               'تطبيق ادارة العقارات الأول في سورية والعالم',
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 fontFamily: 'Pacifico',
//                 fontSize: 20,
//                 color: Colors.lightBlue,
//               ),
//             ),
//             const SizedBox(height: 100),
//             Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 18),
//                 // child: ElevatedButton(
//                 //   style: ElevatedButton.styleFrom(
//                 //     backgroundColor: const Color(0xFF1565C0),
//                 //     padding:
//                 //         const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                 //     shape: RoundedRectangleBorder(
//                 //       borderRadius: BorderRadius.circular(16),
//                 //     ),
//                 //   ),
//                 //   onPressed: () {
//                 //     Navigator.push(
//                 //       context,
//                 //       MaterialPageRoute(builder: (context) => const LoginPage()),
//                 //     );
//                 //   },
//                 //   child: Text(
//                 //     localizations.translate('complete'),
//                 //     style: const TextStyle(
//                 //       fontFamily: 'Pacifico',
//                 //       color: Colors.white,
//                 //       fontSize: 18,
//                 //     ),
//                 //   ),
//                 // ),
//                 child: OutlinedButton(
//                   style: OutlinedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     side: const BorderSide(color: Colors.blue, width: 1),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   ),
//                   onPressed: () {
//                     Navigator.push(context,
//                           MaterialPageRoute(builder: (context) {
//                         return RegisterPage();
//                       }));
//                   },
//                   child: const Text(
//                     "استمرار",
//                     style: TextStyle(color: Colors.blue),
//                   ),
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:property_system/client/screens/auth/login/login_page.dart';
import 'package:property_system/client/screens/auth/register/start_register_page.dart';
import 'package:property_system/l10n/app_localizations.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
              child: Container(
                height: 400,
                width: 330,
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    'assets/images/init.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Text(
              localizations.translate('property_system'),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Pacifico',
                color: Color.fromARGB(255, 57, 15, 125),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50),
            Text(
              localizations.translate('app_description'),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 20,
                color: Colors.lightBlue,
              ),
            ),
            const SizedBox(height: 100),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Colors.blue, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return LoginPage();
                        }));
                  },
                  child: Text(
                    localizations.translate('continue'),
                    style: const TextStyle(color: Colors.blue),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

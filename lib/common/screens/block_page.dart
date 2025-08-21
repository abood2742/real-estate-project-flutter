// import 'package:flutter/material.dart';
// import 'package:property_system/client/screens/auth/login/login_page.dart';

// class BlockPage extends StatelessWidget {
//   const BlockPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           const SizedBox(
//             height: 100,
//           ),
//           const Text(
//             'عذرا ان هذا الحساب محظور',
//             textDirection: TextDirection.rtl,
//             style: TextStyle(
//               color: const Color.fromARGB(255, 37, 33, 148),
//               fontFamily: 'Pacifico',
//               fontSize: 24,
//             ),
//           ),
//           const SizedBox(
//             height: 100,
//           ),
//           const Row(
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 25),
//                 child: Text(
//                   'سبب الحظر ',
//                   style: TextStyle(
//                     color: Color.fromARGB(66, 5, 134, 63),
//                     fontFamily: 'Pacifico',
//                     fontSize: 20,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Text(
//                 ' تعليق غير أخلاقي  ',
//                 style: TextStyle(
//                   color: Color.fromARGB(255, 42, 46, 42),
//                   fontFamily: 'Pacifico',
//                   fontSize: 20,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 100,
//           ),
//           const Row(
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 25),
//                 child: Text(
//                   'تاريخ الحظر ',
//                   style: TextStyle(
//                     color: Color.fromARGB(66, 5, 134, 63),
//                     fontFamily: 'Pacifico',
//                     fontSize: 20,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Text(
//                 ' 8 / 8 / 2020 ',
//                 style: TextStyle(
//                   color: Color.fromARGB(255, 42, 46, 42),
//                   fontFamily: 'Pacifico',
//                   fontSize: 20,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 200,
//           ),
//           GestureDetector(
//             onTap: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) {
//                 return LoginPage();
//               }));
//             },
//             child: Container(
//               decoration: BoxDecoration(
//                   color: const Color.fromARGB(255, 31, 37, 145),
//                   borderRadius: BorderRadius.circular(16)),
//               height: 50,
//               width: 300,
//               child: const Center(
//                 child: Text(
//                   'تسجيل الدخول بحساب آخر',
//                   style: TextStyle(
//                       fontFamily: 'Pacifico',
//                       color: Colors.white,
//                       fontSize: 18),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:property_system/client/screens/auth/login/login_page.dart';
import 'package:property_system/l10n/app_localizations.dart';

class BlockPage extends StatelessWidget {
  const BlockPage({
    super.key,
    required this.blockReason,
    required this.blockDate,
  });

  final String blockReason;
  final String blockDate;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 100),
          Text(
            localizations.translate('account_blocked_message'),
            style: const TextStyle(
              color: Color.fromARGB(255, 37, 33, 148),
              fontFamily: 'Pacifico',
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  localizations.translate('block_reason'),
                  style: const TextStyle(
                    color: Color.fromARGB(66, 5, 134, 63),
                    fontFamily: 'Pacifico',
                    fontSize: 20,
                  ),
                ),
              ),
              Text(
                localizations.translate(blockReason.toLowerCase()),
                style: const TextStyle(
                  color: Color.fromARGB(255, 42, 46, 42),
                  fontFamily: 'Pacifico',
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  localizations.translate('block_date'),
                  style: const TextStyle(
                    color: Color.fromARGB(66, 5, 134, 63),
                    fontFamily: 'Pacifico',
                    fontSize: 20,
                  ),
                ),
              ),
              Text(
                blockDate,
                style: const TextStyle(
                  color: Color.fromARGB(255, 42, 46, 42),
                  fontFamily: 'Pacifico',
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 200),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 31, 37, 145),
                borderRadius: BorderRadius.circular(16),
              ),
              height: 50,
              width: 300,
              child: Center(
                child: Text(
                  localizations.translate('login_with_another_account'),
                  style: const TextStyle(
                    fontFamily: 'Pacifico',
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
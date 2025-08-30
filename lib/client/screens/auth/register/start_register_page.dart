
// import 'package:flutter/material.dart';
// import 'package:property_system/client/screens/auth/login/login_page.dart';
// import 'package:property_system/client/screens/auth/register/verification_code.dart';
// import 'package:property_system/client/services/register_service_done.dart';

// class RegisterPage extends StatefulWidget {
//   const RegisterPage({super.key});

//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }

// String? phoneNumber, email;

// class _RegisterPageState extends State<RegisterPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Register account',
//           style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontFamily: 'Pacifico',
//               color: Colors.white,
//               fontSize: 24),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           children: [
//             const Spacer(flex: 1),
//             TextField(
//               onChanged: (value) {
//                 phoneNumber = value;
//               },
//               decoration: InputDecoration(
//                 suffixIcon: const Icon(
//                   Icons.phone_android_outlined,
//                   color: Colors.lightBlue,
//                 ),
//                 hintText: "Phone Number",
//                 filled: true,
//                 fillColor: Colors.white,
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: const BorderSide(color: Colors.black, width: 1),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: const BorderSide(color: Colors.black, width: 1.5),
//                 ),
//               ),
//             ),
//             const Spacer(flex: 2),
//             TextField(
//               onChanged: (value) {
//                 email = value;
//               },
//               decoration: InputDecoration(
//                 suffixIcon: const Icon(
//                   Icons.email,
//                   color: Colors.lightBlue,
//                 ),
//                 hintText: "Email",
//                 filled: true,
//                 fillColor: Colors.white,
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: const BorderSide(color: Colors.black, width: 1),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: const BorderSide(color: Colors.black, width: 1.5),
//                 ),
//               ),
//             ),
//             const Spacer(flex: 3),

//             // زر Register بنفس ستايل InitialPage
//             OutlinedButton(
//               style: OutlinedButton.styleFrom(
//                 backgroundColor: Colors.white,
//                 side: const BorderSide(color: Colors.blue, width: 1),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               ),
//               onPressed: () async {
//                 try {
//                   var token = await RegisterService()
//                       .startRegisterPost(email: email!, phoneNumber: phoneNumber!);

//                   if (token != null) {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const VerificationCode(),
//                       ),
//                     );
//                   }
//                 } catch (e) {
//                   print('Error: $e');
//                 }
//               },
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 100),
//                 child: const Text(
//                   "Register",
//                   style: TextStyle(
//                     fontFamily: 'Pacifico',
//                     color: Colors.blue,
//                     fontSize: 18,
//                   ),
//                 ),
//               ),
//             ),

//             const Spacer(flex: 2),

//             Row(
//               children: [
//                 const Spacer(flex: 1),
//                 const Text(
//                   'You already have an account?',
//                   style: TextStyle(fontFamily: 'Pacifico'),
//                 ),
//                 const Spacer(flex: 2),
//                 GestureDetector(
//                     onTap: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) {
//                         return const LoginPage();
//                       }));
//                     },
//                     child: const Text(
//                       'Sign in',
//                       style: TextStyle(
//                         fontFamily: 'Pacifico',
//                         color: Color.fromARGB(255, 14, 18, 95),
//                       ),
//                     )),
//                 const Spacer(flex: 2),
//               ],
//             ),
//             const Spacer(flex: 2),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:property_system/client/screens/auth/login/login_page.dart';
import 'package:property_system/client/screens/auth/register/verification_code.dart';
import 'package:property_system/client/services/register_service_done.dart';
import 'package:property_system/l10n/app_localizations.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

String? phoneNumber, email;

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations.translate('register_account'),
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Pacifico',
              color: Colors.white,
              fontSize: 24),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const Spacer(flex: 1),
            TextField(
              onChanged: (value) {
                phoneNumber = value;
              },
              decoration: InputDecoration(
                suffixIcon: const Icon(
                  Icons.phone_android_outlined,
                  color: Colors.lightBlue,
                ),
                hintText: localizations.translate('phone_number'),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.black, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.black, width: 1.5),
                ),
              ),
            ),
            const Spacer(flex: 2),
            TextField(
              onChanged: (value) {
                email = value;
              },
              decoration: InputDecoration(
                suffixIcon: const Icon(
                  Icons.email,
                  color: Colors.lightBlue,
                ),
                hintText: localizations.translate('email'),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.black, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.black, width: 1.5),
                ),
              ),
            ),
            const Spacer(flex: 3),

            // زر Register بنفس ستايل InitialPage
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(color: Colors.blue, width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              onPressed: () async {
                try {
                  var token = await RegisterService()
                      .startRegisterPost(email: email!, phoneNumber: phoneNumber!);

                  if (token != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VerificationCode(),
                      ),
                    );
                  }
                } catch (e) {
                  print('Error: $e');
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Text(
                  localizations.translate('register'),
                  style: const TextStyle(
                    fontFamily: 'Pacifico',
                    color: Colors.blue,
                    fontSize: 18,
                  ),
                ),
              ),
            ),

            const Spacer(flex: 2),

            Row(
              children: [
                const Spacer(flex: 1),
                Text(
                  localizations.translate('already_have_account'),
                  style: const TextStyle(fontFamily: 'Pacifico'),
                ),
                const Spacer(flex: 2),
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const LoginPage();
                      }));
                    },
                    child: Text(
                      localizations.translate('sign_in'),
                      style: const TextStyle(
                        fontFamily: 'Pacifico',
                        color: Color.fromARGB(255, 14, 18, 95),
                      ),
                    )),
                const Spacer(flex: 2),
              ],
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}

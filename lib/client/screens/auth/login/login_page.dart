// import 'package:flutter/material.dart';
// import 'package:property_system/client/screens/auth/register/register_page.dart';
// import 'package:property_system/client/services/login_service.dart';
// import 'package:property_system/client/screens/main/main_page.dart';
// import 'package:property_system/client/services/token_service.dart';
// import 'package:property_system/l10n/app_localizations.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title:Text(
//   AppLocalizations.of(context)!.translate('login'),
//   style: const TextStyle(
//     fontWeight: FontWeight.bold,
//     fontFamily: 'Pacifico',
//     color: Color.fromARGB(255, 31, 37, 145),
//     fontSize: 24,
//   ),
// )
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           children: [
//             Spacer(
//               flex: 1,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(bottom: 15, top: 50),
//               child: Text(
//                 'Login to your account ',
//                 style: TextStyle(
//                     fontFamily: 'Pacifico',
//                     color: const Color.fromARGB(255, 31, 37, 145),
//                     fontSize: 18),
//               ),
//             ),
//             Spacer(
//               flex: 1,
//             ),
//             TextField(
//               onChanged: (value) {
//                 _emailController.text = value;
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
//                   borderSide: BorderSide(color: Colors.black, width: 1),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide(color: Colors.black, width: 1.5),
//                 ),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide(color: Colors.black),
//                 ),
//               ),
//             ),
//             Spacer(
//               flex: 2,
//             ),
//             TextField(
//               onChanged: (value) {
//                 _passwordController.text = value;
//               },
//               decoration: InputDecoration(
//                 suffixIcon: const Icon(
//                   Icons.key,
//                   color: Colors.lightBlue,
//                 ),
//                 hintText: "Password",
//                 filled: true,
//                 fillColor: Colors.white,
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide(color: Colors.black, width: 1),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide(color: Colors.black, width: 1.5),
//                 ),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide(color: Colors.black),
//                 ),
//               ),
//             ),
//             Spacer(
//               flex: 3,
//             ),
//             GestureDetector(
//               onTap: () async {
//                 var success = await login();

//                 if (success == true)
//                   Navigator.pushReplacement(context,
//                       MaterialPageRoute(builder: (context) {
//                     return MainPage();
//                   }));
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: const Color.fromARGB(255, 31, 37, 145),
//                     borderRadius: BorderRadius.circular(16)),
//                 height: 50,
//                 width: 300,
//                 child: Center(
//                   child: Text(
//                     'LOGIN',
//                     style: TextStyle(
//                         fontFamily: 'Pacifico',
//                         color: Colors.white,
//                         fontSize: 22),
//                   ),
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: () async {
//                 print('accessToken = ${await AuthService.getAccessToken()} ');
//                 Navigator.pushReplacement(context,
//                     MaterialPageRoute(builder: (context) {
//                   return MainPage();
//                 }));
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: const Color.fromARGB(255, 31, 37, 145),
//                     borderRadius: BorderRadius.circular(16)),
//                 height: 50,
//                 width: 300,
//                 child: Center(
//                   child: Text(
//                     'skip',
//                     style: TextStyle(
//                         fontFamily: 'Pacifico',
//                         color: Colors.white,
//                         fontSize: 22),
//                   ),
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: () async {
//                 await AuthService.clearAccessToken();
//                 Navigator.pushReplacement(context,
//                     MaterialPageRoute(builder: (context) {
//                   return MainPage();
//                 }));
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: const Color.fromARGB(255, 31, 37, 145),
//                     borderRadius: BorderRadius.circular(16)),
//                 height: 50,
//                 width: 300,
//                 child: const Center(
//                   child: Text(
//                     'skip 2',
//                     style: TextStyle(
//                         fontFamily: 'Pacifico',
//                         color: Colors.white,
//                         fontSize: 22),
//                   ),
//                 ),
//               ),
//             ),
//             Spacer(
//               flex: 3,
//             ),
//             Row(
//               children: [
//                 Spacer(
//                   flex: 1,
//                 ),
//                 Text(
//                   'You are havent any account ?',
//                   style: TextStyle(fontFamily: 'Pacifico'),
//                 ),
//                 Spacer(
//                   flex: 3,
//                 ),
//                 GestureDetector(
//                     onTap: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) {
//                         return RegisterPage();
//                       }));
//                     },
//                     child: Text(
//                       'Sign up',
//                       style: TextStyle(
//                         fontFamily: 'Pacifico',
//                         color: const Color.fromARGB(255, 14, 18, 95),
//                       ),
//                     )),
//                 Spacer(
//                   flex: 2,
//                 ),
//               ],
//             ),
//             Spacer(
//               flex: 3,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<bool?> login() async {
//     final email = _emailController.text;
//     final password = _passwordController.text;

//     var authModel =
//         await LoginService().login(email: email, password: password);
//     if (authModel?.accessToken != null) {
//       return true;
//     } else {
//       return false;
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:property_system/client/screens/auth/register/register_page.dart';
import 'package:property_system/client/screens/main/main_page.dart';
import 'package:property_system/client/services/login_service.dart';
import 'package:property_system/client/services/token_service.dart';
import 'package:property_system/l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final localizations = AppLocalizations.of(context)!;
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(localizations.translate('generic_error_try_again')),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final authModel =
          await LoginService().login(email: email, password: password);
      if (authModel?.accessToken != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(localizations.translate('invalid_credentials')),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(localizations.translate('generic_error_try_again')),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations.translate('login'),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Pacifico',
            color: Color.fromARGB(255, 31, 37, 145),
            fontSize: 24,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const Spacer(flex: 1),
            Padding(
              padding: const EdgeInsets.only(bottom: 15, top: 50),
              child: Text(
                localizations.translate('login_to_your_account'),
                style: const TextStyle(
                  fontFamily: 'Pacifico',
                  color: Color.fromARGB(255, 31, 37, 145),
                  fontSize: 18,
                ),
              ),
            ),
            const Spacer(flex: 1),
            TextField(
              controller: _emailController,
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
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.black),
                ),
              ),
            ),
            const Spacer(flex: 2),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                suffixIcon: const Icon(
                  Icons.key,
                  color: Colors.lightBlue,
                ),
                hintText: localizations.translate('password'),
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
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.black),
                ),
              ),
            ),
            const Spacer(flex: 3),
            _isLoading
                ? const CircularProgressIndicator()
                : GestureDetector(
                    onTap: _login,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 31, 37, 145),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      height: 50,
                      width: 300,
                      child: Center(
                        child: Text(
                          localizations.translate('login').toUpperCase(),
                          style: const TextStyle(
                            fontFamily: 'Pacifico',
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                  ),
            const Spacer(flex: 1),
            GestureDetector(
              onTap: () {
                print(AuthService.getAccessToken());

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()),
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
                    localizations.translate('skip'),
                    style: const TextStyle(
                      fontFamily: 'Pacifico',
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(flex: 1),
            GestureDetector(
              onTap: () {
                print(AuthService.getAccessToken());
                AuthService.clearAccessToken();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()),
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
                    localizations.translate('skip2'),
                    style: const TextStyle(
                      fontFamily: 'Pacifico',
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(flex: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  localizations.translate('no_account'),
                  style: const TextStyle(fontFamily: 'Pacifico'),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterPage()),
                    );
                  },
                  child: Text(
                    localizations.translate('signup'),
                    style: const TextStyle(
                      fontFamily: 'Pacifico',
                      color: Color.fromARGB(255, 14, 18, 95),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}

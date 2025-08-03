import 'package:flutter/material.dart';
import 'package:property_system/client/screens/auth/login/login_page.dart';
import 'package:property_system/client/screens/auth/register/verification_code.dart';
import 'package:property_system/client/models/start_register_model.dart';
import 'package:property_system/client/services/register_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register1Page extends StatefulWidget {
  Register1Page({super.key});

  @override
  State<Register1Page> createState() => _Register1PageState();
}

String? phoneNumber, email;

class _Register1PageState extends State<Register1Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rigester account',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Pacifico',
              color: const Color.fromARGB(255, 31, 37, 145),
              fontSize: 24),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const Spacer(
              flex: 1,
            ),
            TextField(
              onChanged: (value) {
                phoneNumber = value;
              },
              decoration: InputDecoration(
                suffixIcon: const Icon(
                  Icons.phone_android_outlined,
                  color: Colors.lightBlue,
                ),
                hintText: "Phone Number",
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.black, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.black, width: 1.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            TextField(
              onChanged: (value) {
                email = value;
              },
              decoration: InputDecoration(
                suffixIcon: const Icon(
                  Icons.email,
                  color: Colors.lightBlue,
                ),
                hintText: "Email",
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.black, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.black, width: 1.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            const Spacer(
              flex: 3,
            ),
            GestureDetector(
              onTap: () async {
                try {
                  var token = await RegisterService().startRegisterPost(
                      email: email!, phoneNumber: phoneNumber!);

                  if (token != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VerificationCode(),
                      ),
                    );
                  }
                } catch (e) {
                  print('Error: $e');
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 31, 37, 145),
                    borderRadius: BorderRadius.circular(16)),
                height: 50,
                width: 300,
                child: const Center(
                  child: Text(
                    'Register',
                    style: TextStyle(
                        fontFamily: 'Pacifico',
                        color: Colors.white,
                        fontSize: 22),
                  ),
                ),
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            Row(
              children: [
                const Spacer(
                  flex: 1,
                ),
                const Text(
                  'You are have already account ?',
                  style: TextStyle(fontFamily: 'Pacifico'),
                ),
                const Spacer(
                  flex: 3,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return LoginPage();
                      }));
                    },
                    child: const Text(
                      'Sign in',
                      style: TextStyle(
                        fontFamily: 'Pacifico',
                        color: const Color.fromARGB(255, 14, 18, 95),
                      ),
                    )),
                const Spacer(
                  flex: 2,
                ),
              ],
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }

  // Future<StartRegisterModel?> postMethode() async {
  //   var token = await RegisterService()
  //       .startRegisterPost(email: email!, phoneNumber: phoneNumber!);

  //   return token;
  // }
}

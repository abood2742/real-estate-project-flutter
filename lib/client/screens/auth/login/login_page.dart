import 'package:flutter/material.dart';
//import 'package:property_system/client/models/auth_model.dart';
import 'package:property_system/client/screens/auth/register/registerType_page.dart';
//import 'package:property_system/client/screens/auth/register/register_page.dart';
import 'package:property_system/client/screens/main/home_page.dart';
import 'package:property_system/client/services/login_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
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
            Spacer(
              flex: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15, top: 50),
              child: Text(
                'Login to your account ',
                style: TextStyle(
                    fontFamily: 'Pacifico',
                    color: const Color.fromARGB(255, 31, 37, 145),
                    fontSize: 18),
              ),
            ),
            Spacer(
              flex: 1,
            ),
            TextField(
              onChanged: (value) {
                _emailController.text = value;
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
            Spacer(
              flex: 2,
            ),
            TextField(
              onChanged: (value) {
                _passwordController.text = value;
              },
              decoration: InputDecoration(
                suffixIcon: const Icon(
                  Icons.key,
                  color: Colors.lightBlue,
                ),
                hintText: "Password",
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
            Spacer(
              flex: 3,
            ),
            GestureDetector(
              onTap: () async{
                var success = await login();

                if (success == true)
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomePage();
                  }));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 31, 37, 145),
                    borderRadius: BorderRadius.circular(16)),
                height: 50,
                width: 300,
                child: Center(
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                        fontFamily: 'Pacifico',
                        color: Colors.white,
                        fontSize: 22),
                  ),
                ),
              ),
            ),
            Spacer(
              flex: 3,
            ),
            Row(
              children: [
                Spacer(
                  flex: 1,
                ),
                Text(
                  'You are havent any account ?',
                  style: TextStyle(fontFamily: 'Pacifico'),
                ),
                Spacer(
                  flex: 3,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return RegistertypePage();
                      }));
                    },
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        fontFamily: 'Pacifico',
                        color: const Color.fromARGB(255, 14, 18, 95),
                      ),
                    )),
                Spacer(
                  flex: 2,
                ),
              ],
            ),
            Spacer(
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }

  Future<bool?> login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    print('$email + email');
    print('$password + password');

    var authModel =
        await LoginService().login(email: email, password: password);
    if (authModel?.accessToken != null) {
      return true;
    } else {
      return false;
    }
  }
}

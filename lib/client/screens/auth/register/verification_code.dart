import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:property_system/client/screens/auth/register/user_info_enter_page.dart';
import 'package:property_system/client/services/register_service.dart';

class VerificationCode extends StatefulWidget {
  const VerificationCode({super.key});

  @override
  State<VerificationCode> createState() => _VerificationCodeState();
}

class _VerificationCodeState extends State<VerificationCode> {
  String verifyCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              'لقد تم تسجيل طلبك سيصلك رمز تحقق',
              style: TextStyle(
                  color: Colors.blue, fontFamily: 'pacifico', fontSize: 24),
            ),
            SizedBox(
              height: 60,
            ),
            Text(
              '   أدخل رمز التحقق    ',
              style: TextStyle(
                  color: const Color.fromARGB(255, 49, 54, 59),
                  fontFamily: 'pacifico',
                  fontSize: 20),
            ),
            SizedBox(
              height: 80,
            ),
            PinCodeTextField(
              appContext: context,
              length: 6,
              obscureText: false,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(10),
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor: Colors.white,
                selectedFillColor: Colors.white,
                inactiveFillColor: Colors.grey.shade300,
              ),
              animationDuration: Duration(milliseconds: 300),
              backgroundColor: Colors.white,
              enableActiveFill: true,
              onCompleted: (v) async {
                print("Code entered: $v");
                setState(() {
                  verifyCode = v;
                });
              },
              onChanged: (value) {
                print(value);
              },
            ),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 139, 141, 181),
                    borderRadius: BorderRadius.circular(16)),
                height: 40,
                width: 250,
                child: const Center(
                  child: Text(
                    '  إعادة إرسال رمز التحقق ',
                    style: TextStyle(
                        fontFamily: 'Pacifico',
                        color: Colors.white,
                        fontSize: 14),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            GestureDetector(
              onTap: () async {
                if (verifyCode.isNotEmpty) {
                  var message = await RegisterService()
                      .verifyCodePost(verifyCode: verifyCode);
                  print(message);
                  if (message!) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return UserInfoEnterPage();
                    }));
                  }
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
                    '  تأكيد  ',
                    style: TextStyle(
                        fontFamily: 'Pacifico',
                        color: Colors.white,
                        fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

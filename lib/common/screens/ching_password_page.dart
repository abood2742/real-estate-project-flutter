import 'package:flutter/material.dart';
import 'package:property_system/client/components/Custom_textField.dart';
import 'package:property_system/client/components/custom_button.dart';

class ChingPasswordPage extends StatefulWidget {
  const ChingPasswordPage({super.key});

  @override
  State<ChingPasswordPage> createState() => _ChingPasswordPageState();
}

class _ChingPasswordPageState extends State<ChingPasswordPage> {
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void handleChangePassword() {
    if (newPasswordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('كلمتا المرور غير متطابقتين')),
      );
      return;
    }

    // منطق تغيير كلمة المرور هنا (API, تحقق، إلخ)

    // الرجوع للصفحة السابقة بعد التعديل
    Navigator.pop(context); // بدون تمرير 'password_changed'
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'تغيير كلمة المرور',
          style: TextStyle(color: Colors.white, fontFamily: 'Pacifico'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(
              controller: currentPasswordController,
              hintText: 'كلمة المرور الحالية',
              obscureText: true,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              controller: newPasswordController,
              hintText: 'كلمة المرور الجديدة',
              obscureText: true,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              controller: confirmPasswordController,
              hintText: 'تأكيد كلمة المرور الجديدة',
              obscureText: true,
            ),
            const SizedBox(height: 24),
            CustomButon(
              text: 'تأكيد',
              onTap: handleChangePassword,
            ),
          ],
        ),
      ),
    );
  }
}

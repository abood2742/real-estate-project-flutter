// import 'package:flutter/material.dart';
// import 'package:property_system/client/components/Custom_textField.dart';
// import 'package:property_system/client/components/custom_button.dart';
// import 'package:property_system/client/services/ching_password_service.dart';

// class ChingPasswordProfilePage extends StatefulWidget {
//   const ChingPasswordProfilePage({super.key});

//   @override
//   State<ChingPasswordProfilePage> createState() => _ChingPasswordProfilePageState();
// }

// class _ChingPasswordProfilePageState extends State<ChingPasswordProfilePage> {
//   final currentPasswordController = TextEditingController();
//   final newPasswordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();

// //.............................................
// void handleChangePassword() async {
//   final current = currentPasswordController.text;
//   final newPass = newPasswordController.text;
//   final confirm = confirmPasswordController.text;

//   // 🔹 Validation بسيطة
//   if (current.isEmpty || newPass.isEmpty || confirm.isEmpty) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('يرجى ملء جميع الحقول')),
//     );
//     return;
//   }

//   if (newPass != confirm) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('كلمة المرور الجديدة وتأكيدها غير متطابقين')),
//     );
//     return;
//   }

//   // 🔹 استدعاء الخدمة
//   final service = ChangePasswordService();
//   bool success = await service.changePassword(
//     currentPassword: current,
//     newPassword: newPass,
//     confirmPassword: confirm,
//   );

//   // 🔹 عرض رسالة نجاح أو فشل
//   if (success) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('تم تغيير كلمة المرور بنجاح')),
//     );

//     // مسح الحقول بعد النجاح
//     currentPasswordController.clear();
//     newPasswordController.clear();
//     confirmPasswordController.clear();
//   } else {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('فشل تغيير كلمة المرور')),
//     );
//   }
// }



//   @override
//   void dispose() {
//     currentPasswordController.dispose();
//     newPasswordController.dispose();
//     confirmPasswordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'تغيير كلمة المرور',
//           style: TextStyle(color: Colors.white, fontFamily: 'Pacifico'),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             CustomTextField(
//               controller: currentPasswordController,
//               hintText: 'كلمة المرور الحالية',
//               obscureText: true,
//             ),
//             const SizedBox(height: 12),
//             CustomTextField(
//               controller: newPasswordController,
//               hintText: 'كلمة المرور الجديدة',
//               obscureText: true,
//             ),
//             const SizedBox(height: 12),
//             CustomTextField(
//               controller: confirmPasswordController,
//               hintText: 'تأكيد كلمة المرور الجديدة',
//               obscureText: true,
//             ),
//             const SizedBox(height: 24),
//             CustomButon(
//               text: 'تأكيد',
//             onTap: handleChangePassword, // ربط الزر بالدالة
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:property_system/client/components/Custom_textField.dart';
import 'package:property_system/client/components/custom_button.dart';
import 'package:property_system/client/services/profile_service_done.dart';

class ChingPasswordProfilePage extends StatefulWidget {
  const ChingPasswordProfilePage({super.key});

  @override
  State<ChingPasswordProfilePage> createState() =>
      _ChingPasswordProfilePageState();
}

class _ChingPasswordProfilePageState extends State<ChingPasswordProfilePage> {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isCurrentPasswordObscure = true;
  bool isNewPasswordObscure = true;
  bool isConfirmPasswordObscure = true;

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void handleChangePassword() async {
    final current = currentPasswordController.text;
    final newPass = newPasswordController.text;
    final confirm = confirmPasswordController.text;

    // 🔹 Validation بسيطة
    if (current.isEmpty || newPass.isEmpty || confirm.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى ملء جميع الحقول')),
      );
      return;
    }

    if (newPass != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('كلمة المرور الجديدة وتأكيدها غير متطابقين')),
      );
      return;
    }

    // 🔹 استدعاء الخدمة
    final service = ProfileService();
    bool success = await service.changePassword(
      currentPassword: current,
      newPassword: newPass,
      confirmPassword: confirm,
    );

    // 🔹 عرض رسالة نجاح أو فشل
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم تغيير كلمة المرور بنجاح')),
      );

      // مسح الحقول بعد النجاح
      currentPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('فشل تغيير كلمة المرور')),
      );
    }
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
              obscureText: isCurrentPasswordObscure,
              suffixIcon: IconButton(
                icon: Icon(
                  isCurrentPasswordObscure
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    isCurrentPasswordObscure = !isCurrentPasswordObscure;
                  });
                },
              ),
            ),
            const SizedBox(height: 12),
            CustomTextField(
              controller: newPasswordController,
              hintText: 'كلمة المرور الجديدة',
              obscureText: isNewPasswordObscure,
              suffixIcon: IconButton(
                icon: Icon(
                  isNewPasswordObscure
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    isNewPasswordObscure = !isNewPasswordObscure;
                  });
                },
              ),
            ),
            const SizedBox(height: 12),
            CustomTextField(
              controller: confirmPasswordController,
              hintText: 'تأكيد كلمة المرور الجديدة',
              obscureText: isConfirmPasswordObscure,
              suffixIcon: IconButton(
                icon: Icon(
                  isConfirmPasswordObscure
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    isConfirmPasswordObscure = !isConfirmPasswordObscure;
                  });
                },
              ),
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'تأكيد',
              onTap: handleChangePassword,
            ),
          ],
        ),
      ),
    );
  }
}

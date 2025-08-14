// // import 'package:flutter/material.dart';

// // class CustomTextField extends StatelessWidget {
// //   CustomTextField({this.hintText,this.inputType, this.onChanged, this.obscureText = false, required TextEditingController controller});
// //   Function(String)? onChanged;
// //   String? hintText;
// //   TextInputType?  inputType;
// //   bool? obscureText;
// //   @override
// //   Widget build(BuildContext context) {
// //     return TextField(
// //       obscureText: obscureText!,
// //       onChanged: onChanged,
// //       keyboardType: inputType,
// //       decoration: InputDecoration(
// //         hintText: hintText,
// //         enabledBorder: OutlineInputBorder(
// //           borderSide: BorderSide(),
// //           borderRadius: BorderRadius.circular(8),
// //         ),
// //         border: OutlineInputBorder(
// //           borderSide: BorderSide(),
// //           borderRadius: BorderRadius.circular(8),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';

// class CustomTextField extends StatelessWidget {
//   final TextEditingController controller;
//   final Function(String)? onChanged;
//   final String? hintText;
//   final TextInputType? inputType;
//   final bool obscureText;

//   const CustomTextField({
//     Key? key,
//     required this.controller,
//     this.hintText,
//     this.inputType,
//     this.onChanged,
//     this.obscureText = false,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: controller, // 🔹 ربط الحقل بالـ controller
//       obscureText: obscureText,
//       onChanged: onChanged,
//       keyboardType: inputType,
//       decoration: InputDecoration(
//         hintText: hintText,
//         enabledBorder: OutlineInputBorder(
//           borderSide: const BorderSide(),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         border: OutlineInputBorder(
//           borderSide: const BorderSide(),
//           borderRadius: BorderRadius.circular(8),
//         ),
//       ),
//     );
//   }
// }
// /*
// ما الذي تغير؟

// عملت متغير نهائي final TextEditingController controller;

// حفظت قيمة الـ controller اللي تجي من الـ constructor.

// أضفت controller: controller في الـ TextField نفسه.

// */ 

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  final String? hintText;
  final TextInputType? inputType;
  final bool obscureText;

  const CustomTextField({
    Key? key,
    required this.controller,
    this.hintText,
    this.inputType,
    this.onChanged,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, // ربط الـ controller بالحقل
      obscureText: obscureText,
      onChanged: onChanged,
      keyboardType: inputType,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(),
          borderRadius: BorderRadius.circular(8),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

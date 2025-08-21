// import 'package:flutter/material.dart';



// class PushComplaintPage extends StatefulWidget {
//   @override
//   _PushComplaintPageState createState() => _PushComplaintPageState();
// }

// class _PushComplaintPageState extends State<PushComplaintPage> {
//   String? selectedReason;
//   final TextEditingController descriptionController = TextEditingController();

//   final List<String> reasons = [
//     'تسرب مياه أو مشاكل في السباكة',
//     'الكهرباء لا تعمل بشكل جيد',
//     'التكييف أو التدفئة لا تعمل',
//     'الحشرات أو القوارض',
//     'الأثاث مكسور أو مفقود',
//     'أخرى',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl, // دعم اللغة العربية
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text(' تقديم شكوى ',
//               style: TextStyle(
//                   color: Colors.white, fontFamily: 'Pacifico', fontSize: 20)),
//           backgroundColor: Color.fromARGB(255, 83, 54, 155),
//           centerTitle: true,
//           elevation: 0,
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: ListView(
//             children: [
//               Text(
//                 'معلومات العميل',
//                 style:
//                     TextStyle(fontFamily: 'Pacifico', color: Colors.blueAccent),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Expanded(
//                 child: TextField(
//                   style: const TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     hintText: " اسم العميل ",
//                     hintStyle: const TextStyle(color: Colors.white),
//                     filled: true,
//                     //  fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       //   borderSide: BorderSide.none,
//                       borderSide: BorderSide(color: Colors.black, width: 1),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Expanded(
//                 child: TextField(
//                   style: const TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     hintText: " الإيميل  ",
//                     hintStyle: const TextStyle(color: Colors.white),
//                     filled: true,
//                     //  fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       //   borderSide: BorderSide.none,
//                       borderSide: BorderSide(color: Colors.black, width: 1),
//                     ),
//                   ),
//                 ),
//               ),
//               //

//               const SizedBox(height: 16),
//               Text(
//                 'معلومات المكتب',
//                 style:
//                     TextStyle(fontFamily: 'Pacifico', color: Colors.blueAccent),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Expanded(
//                 child: TextField(
//                   style: const TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     hintText: " إسم المكتب ",
//                     hintStyle: const TextStyle(color: Colors.white),
//                     filled: true,
//                     //  fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       //   borderSide: BorderSide.none,
//                       borderSide: BorderSide(color: Colors.black, width: 1),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Expanded(
//                 child: TextField(
//                   style: const TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     hintText: " حساب المكتب  ",
//                     hintStyle: const TextStyle(color: Colors.white),
//                     filled: true,
//                     //  fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       //   borderSide: BorderSide.none,
//                       borderSide: BorderSide(color: Colors.black, width: 1),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 'معلومات العقار',
//                 style:
//                     TextStyle(fontFamily: 'Pacifico', color: Colors.blueAccent),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Expanded(
//                 child: TextField(
//                   style: const TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     hintText: " إسم العقار ",
//                     hintStyle: const TextStyle(color: Colors.white),
//                     filled: true,
//                     //  fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       //   borderSide: BorderSide.none,
//                       borderSide: BorderSide(color: Colors.black, width: 1),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Expanded(
//                 child: TextField(
//                   style: const TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     hintText: " الموقع  ",
//                     hintStyle: const TextStyle(color: Colors.white),
//                     filled: true,
//                     //  fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       //   borderSide: BorderSide.none,
//                       borderSide: BorderSide(color: Colors.black, width: 1),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               const Text(
//                 'سبب الشكوى',
//                 style: TextStyle(
//                     fontFamily: 'Pacifico',
//                     color: Color.fromARGB(255, 83, 54, 155)),
//               ),
//               const SizedBox(height: 16),
//               DropdownButtonFormField<String>(
//                 value: selectedReason,
//                 items: reasons.map((reason) {
//                   return DropdownMenuItem(
//                     value: reason,
//                     child: Text(reason),
//                   );
//                 }).toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     selectedReason = value;
//                   });
//                 },
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: 'اختر سبب الشكوى',
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 'وصف الشكوى ',
//                 style:
//                     TextStyle(fontFamily: 'Pacifico', color: Colors.blueAccent),
//               ),
//               const SizedBox(height: 16),
//               TextField(
//                 controller: descriptionController,
//                 maxLines: 4,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: 'اكتب تفاصيل الشكوى هنا...',
//                 ),
//               ),
//               const SizedBox(height: 24),
//               Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // تنفيذ إلغاء الشكوى
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                               content: Text(
//                             'تم إلغاء الشكوى',
//                             style: TextStyle(
//                                 color: Colors.white, fontFamily: 'Pacifico'),
//                           )),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.grey[400],
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                       ),
//                       child: const Text(
//                         'إلغاء الشكوى',
//                         style: TextStyle(
//                             color: Colors.white, fontFamily: 'Pacifico'),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // تنفيذ حظر المكتب
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                               content: Text(
//                             'تم حظر المكتب',
//                             style: TextStyle(
//                                 color: Colors.white, fontFamily: 'Pacifico'),
//                           )),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.red,
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                       ),
//                       child: const Text(
//                         'حظر المكتب',
//                         style: TextStyle(
//                             color: Colors.white, fontFamily: 'Pacifico'),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               Expanded(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // تنفيذ إلغاء الشكوى
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                           content: Text(
//                         'تم إرسال الشكوى',
//                         style: TextStyle(
//                             color: Colors.white, fontFamily: 'Pacifico'),
//                       )),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color.fromARGB(255, 104, 115, 214),
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                   ),
//                   child: const Text(
//                     'إرسال الشكوى',
//                     style:
//                         TextStyle(color: Colors.white, fontFamily: 'Pacifico'),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 24),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class SectionHeader extends StatelessWidget {
//   final String title;

//   const SectionHeader({super.key, required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Text(title,
//         style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
//   }
// }

// class InfoCard extends StatelessWidget {
//   final String label;
//   final String value;

//   const InfoCard({super.key, required this.label, required this.value});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 4),
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey.shade300),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         children: [
//           Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
//           Expanded(child: Text(value)),
//         ],
//       ),
//     );
//   }
// }





// // import 'package:flutter/material.dart';
// // import 'package:google_fonts/google_fonts.dart';

// // void main() {
// //   runApp(const ComplaintApp());
// // }

// // class ComplaintApp extends StatelessWidget {
// //   const ComplaintApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: ComplaintPage(),
// //       debugShowCheckedModeBanner: false,
// //     );
// //   }
// // }

// // class ComplaintPage extends StatefulWidget {
// //   const ComplaintPage({super.key});

// //   @override
// //   State<ComplaintPage> createState() => _ComplaintPageState();
// // }

// // class _ComplaintPageState extends State<ComplaintPage> {
// //   String? selectedReason;
// //   final TextEditingController descriptionController = TextEditingController();

// //   final List<String> reasons = [
// //     'تسرب مياه أو مشاكل في السباكة',
// //     'الكهرباء لا تعمل بشكل جيد',
// //     'التكييف أو التدفئة لا تعمل',
// //     'الحشرات أو القوارض',
// //     'الأثاث مكسور أو مفقود',
// //     'أخرى',
// //   ];

// //   @override
// //   Widget build(BuildContext context) {
// //     return Directionality(
// //       textDirection: TextDirection.rtl, // دعم العربية
// //       child: Scaffold(
// //         appBar: AppBar(
// //           title: Text(
// //             'تقديم شكوى',
// //             style: GoogleFonts.cairo(
// //               color: Colors.white,
// //               fontSize: 20,
// //               fontWeight: FontWeight.bold,
// //             ),
// //           ),
// //           backgroundColor: const Color.fromARGB(255, 83, 54, 155),
// //           centerTitle: true,
// //         ),
// //         body: Padding(
// //           padding: const EdgeInsets.all(16.0),
// //           child: ListView(
// //             children: [
// //               sectionTitle('معلومات العميل'),
// //               customTextField('اسم العميل'),
// //               customTextField('الإيميل'),

// //               sectionTitle('معلومات المكتب'),
// //               customTextField('اسم المكتب'),
// //               customTextField('حساب المكتب'),

// //               sectionTitle('معلومات العقار'),
// //               customTextField('اسم العقار'),
// //               customTextField('الموقع'),

// //               sectionTitle('سبب الشكوى'),
// //               DropdownButtonFormField<String>(
// //                 value: selectedReason,
// //                 items: reasons.map((reason) {
// //                   return DropdownMenuItem(
// //                     value: reason,
// //                     child: Text(reason, style: GoogleFonts.cairo()),
// //                   );
// //                 }).toList(),
// //                 onChanged: (value) {
// //                   setState(() {
// //                     selectedReason = value;
// //                   });
// //                 },
// //                 decoration: InputDecoration(
// //                   hintText: 'اختر سبب الشكوى',
// //                   hintStyle: GoogleFonts.cairo(),
// //                   border: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(12),
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(height: 16),

// //               sectionTitle('وصف الشكوى'),
// //               TextField(
// //                 controller: descriptionController,
// //                 maxLines: 4,
// //                 style: GoogleFonts.cairo(),
// //                 decoration: InputDecoration(
// //                   hintText: 'اكتب تفاصيل الشكوى هنا...',
// //                   hintStyle: GoogleFonts.cairo(),
// //                   border: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(12),
// //                   ),
// //                 ),
// //               ),

// //               const SizedBox(height: 24),
// //               Row(
// //                 children: [
// //                   Expanded(
// //                     child: ElevatedButton(
// //                       onPressed: () {
// //                         ScaffoldMessenger.of(context).showSnackBar(
// //                           const SnackBar(content: Text('تم إلغاء الشكوى')),
// //                         );
// //                       },
// //                       style: ElevatedButton.styleFrom(
// //                         backgroundColor: Colors.grey[400],
// //                         padding: const EdgeInsets.symmetric(vertical: 16),
// //                       ),
// //                       child: Text('إلغاء الشكوى', style: GoogleFonts.cairo()),
// //                     ),
// //                   ),
// //                   const SizedBox(width: 12),
// //                   Expanded(
// //                     child: ElevatedButton(
// //                       onPressed: () {
// //                         ScaffoldMessenger.of(context).showSnackBar(
// //                           const SnackBar(content: Text('تم حظر المكتب')),
// //                         );
// //                       },
// //                       style: ElevatedButton.styleFrom(
// //                         backgroundColor: Colors.red,
// //                         padding: const EdgeInsets.symmetric(vertical: 16),
// //                       ),
// //                       child: Text('حظر المكتب', style: GoogleFonts.cairo()),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   // عناصر مكررة مساعدة

// //   Widget sectionTitle(String title) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: 12),
// //       child: Text(
// //         title,
// //         style: GoogleFonts.cairo(
// //           fontSize: 18,
// //           fontWeight: FontWeight.bold,
// //           color: const Color.fromARGB(255, 83, 54, 155),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget customTextField(String hint) {
// //     return Padding(
// //       padding: const EdgeInsets.only(bottom: 12),
// //       child: TextField(
// //         style: GoogleFonts.cairo(),
// //         decoration: InputDecoration(
// //           hintText: hint,
// //           hintStyle: GoogleFonts.cairo(),
// //           filled: true,
// //           fillColor: Colors.grey.shade100,
// //           border: OutlineInputBorder(
// //             borderRadius: BorderRadius.circular(12),
// //             borderSide: const BorderSide(color: Colors.black),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:property_system/l10n/app_localizations.dart';

// class PushComplaintPage extends StatefulWidget {
//   @override
//   _PushComplaintPageState createState() => _PushComplaintPageState();
// }

// class _PushComplaintPageState extends State<PushComplaintPage> {
//   String? selectedReason;
//   final TextEditingController descriptionController = TextEditingController();

//   final List<String> reasons = [
//     'water_leakage_or_plumbing_issues',
//     'electrical_issues',
//     'ac_or_heating_issues',
//     'pests_or_rodents',
//     'broken_or_missing_furniture',
//     'other',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final localizations = AppLocalizations.of(context)!;

//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(
//             localizations.translate('submit_complaint'),
//             style: const TextStyle(
//                 color: Colors.white, fontFamily: 'Pacifico', fontSize: 20),
//           ),
//           backgroundColor: const Color.fromARGB(255, 83, 54, 155),
//           centerTitle: true,
//           elevation: 0,
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: ListView(
//             children: [
//               Text(
//                 localizations.translate('client_information'),
//                 style: const TextStyle(
//                     fontFamily: 'Pacifico', color: Colors.blueAccent),
//               ),
//               const SizedBox(height: 10),
//               Expanded(
//                 child: TextField(
//                   style: const TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     hintText: localizations.translate('client_name'),
//                     hintStyle: const TextStyle(color: Colors.white),
//                     filled: true,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: const BorderSide(color: Colors.black, width: 1),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Expanded(
//                 child: TextField(
//                   style: const TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     hintText: localizations.translate('email'),
//                     hintStyle: const TextStyle(color: Colors.white),
//                     filled: true,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: const BorderSide(color: Colors.black, width: 1),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 localizations.translate('office_information'),
//                 style: const TextStyle(
//                     fontFamily: 'Pacifico', color: Colors.blueAccent),
//               ),
//               const SizedBox(height: 10),
//               Expanded(
//                 child: TextField(
//                   style: const TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     hintText: localizations.translate('office_name'),
//                     hintStyle: const TextStyle(color: Colors.white),
//                     filled: true,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: const BorderSide(color: Colors.black, width: 1),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Expanded(
//                 child: TextField(
//                   style: const TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     hintText: localizations.translate('office_account'),
//                     hintStyle: const TextStyle(color: Colors.white),
//                     filled: true,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: const BorderSide(color: Colors.black, width: 1),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 localizations.translate('property_information'),
//                 style: const TextStyle(
//                     fontFamily: 'Pacifico', color: Colors.blueAccent),
//               ),
//               const SizedBox(height: 10),
//               Expanded(
//                 child: TextField(
//                   style: const TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     hintText: localizations.translate('property_name'),
//                     hintStyle: const TextStyle(color: Colors.white),
//                     filled: true,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: const BorderSide(color: Colors.black, width: 1),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Expanded(
//                 child: TextField(
//                   style: const TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     hintText: localizations.translate('property_location'),
//                     hintStyle: const TextStyle(color: Colors.white),
//                     filled: true,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: const BorderSide(color: Colors.black, width: 1),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 localizations.translate('complaint_reason'),
//                 style: const TextStyle(
//                     fontFamily: 'Pacifico',
//                     color: Color.fromARGB(255, 83, 54, 155)),
//               ),
//               const SizedBox(height: 16),
//               DropdownButtonFormField<String>(
//                 value: selectedReason,
//                 items: reasons.map((reason) {
//                   return DropdownMenuItem(
//                     value: reason,
//                     child: Text(localizations.translate(reason)),
//                   );
//                 }).toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     selectedReason = value;
//                   });
//                 },
//                 decoration: InputDecoration(
//                   border: const OutlineInputBorder(),
//                   hintText: localizations.translate('select_complaint_reason'),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 localizations.translate('complaint_description'),
//                 style: const TextStyle(
//                     fontFamily: 'Pacifico', color: Colors.blueAccent),
//               ),
//               const SizedBox(height: 16),
//               TextField(
//                 controller: descriptionController,
//                 maxLines: 4,
//                 decoration: InputDecoration(
//                   border: const OutlineInputBorder(),
//                   hintText: localizations.translate('write_complaint_details'),
//                 ),
//               ),
//               const SizedBox(height: 24),
//               Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text(
//                               localizations.translate('complaint_canceled'),
//                               style: const TextStyle(
//                                   color: Colors.white, fontFamily: 'Pacifico'),
//                             ),
//                           ),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.grey[400],
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                       ),
//                       child: Text(
//                         localizations.translate('cancel_complaint'),
//                         style: const TextStyle(
//                             color: Colors.white, fontFamily: 'Pacifico'),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text(
//                               localizations.translate('office_blocked'),
//                               style: const TextStyle(
//                                   color: Colors.white, fontFamily: 'Pacifico'),
//                             ),
//                           ),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.red,
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                       ),
//                       child: Text(
//                         localizations.translate('block_office'),
//                         style: const TextStyle(
//                             color: Colors.white, fontFamily: 'Pacifico'),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               Expanded(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text(
//                           localizations.translate('complaint_submitted'),
//                           style: const TextStyle(
//                               color: Colors.white, fontFamily: 'Pacifico'),
//                         ),
//                       ),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color.fromARGB(255, 104, 115, 214),
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                   ),
//                   child: Text(
//                     localizations.translate('submit_complaint'),
//                     style: const TextStyle(
//                         color: Colors.white, fontFamily: 'Pacifico'),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 24),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class SectionHeader extends StatelessWidget {
//   final String title;

//   const SectionHeader({super.key, required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       title,
//       style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//     );
//   }
// }

// class InfoCard extends StatelessWidget {
//   final String label;
//   final String value;

//   const InfoCard({super.key, required this.label, required this.value});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 4),
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey.shade300),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         children: [
//           Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
//           Expanded(child: Text(value)),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:property_system/l10n/app_localizations.dart';

class PushComplaintPage extends StatefulWidget {
  @override
  _PushComplaintPageState createState() => _PushComplaintPageState();
}

class _PushComplaintPageState extends State<PushComplaintPage> {
  String? selectedReason;
  final TextEditingController descriptionController = TextEditingController();

  final List<String> reasons = [
    'water_leakage_or_plumbing_issues',
    'electrical_issues',
    'ac_or_heating_issues',
    'pests_or_rodents',
    'broken_or_missing_furniture',
    'other',
  ];

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            localizations.translate('submit_complaint'),
            style: const TextStyle(
                color: Colors.white, fontFamily: 'Pacifico', fontSize: 20),
          ),
          backgroundColor: const Color.fromARGB(255, 83, 54, 155),
          centerTitle: true,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Text(
                localizations.translate('client_information'),
                style: const TextStyle(
                    fontFamily: 'Pacifico', color: Colors.blueAccent),
              ),
              const SizedBox(height: 10),
              TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: localizations.translate('client_name'),
                  hintStyle: const TextStyle(color: Colors.white),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black, width: 1),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: localizations.translate('email'),
                  hintStyle: const TextStyle(color: Colors.white),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black, width: 1),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                localizations.translate('office_information'),
                style: const TextStyle(
                    fontFamily: 'Pacifico', color: Colors.blueAccent),
              ),
              const SizedBox(height: 10),
              TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: localizations.translate('office_name'),
                  hintStyle: const TextStyle(color: Colors.white),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black, width: 1),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: localizations.translate('office_account'),
                  hintStyle: const TextStyle(color: Colors.white),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black, width: 1),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                localizations.translate('property_information'),
                style: const TextStyle(
                    fontFamily: 'Pacifico', color: Colors.blueAccent),
              ),
              const SizedBox(height: 10),
              TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: localizations.translate('property_name'),
                  hintStyle: const TextStyle(color: Colors.white),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black, width: 1),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: localizations.translate('property_location'),
                  hintStyle: const TextStyle(color: Colors.white),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black, width: 1),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                localizations.translate('complaint_reason'),
                style: const TextStyle(
                    fontFamily: 'Pacifico',
                    color: Color.fromARGB(255, 83, 54, 155)),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedReason,
                items: reasons.map((reason) {
                  return DropdownMenuItem(
                    value: reason,
                    child: Text(localizations.translate(reason)),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedReason = value;
                  });
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: localizations.translate('select_complaint_reason'),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                localizations.translate('complaint_description'),
                style: const TextStyle(
                    fontFamily: 'Pacifico', color: Colors.blueAccent),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: localizations.translate('write_complaint_details'),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              localizations.translate('complaint_canceled'),
                              style: const TextStyle(
                                  color: Colors.white, fontFamily: 'Pacifico'),
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[400],
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        localizations.translate('cancel_complaint'),
                        style: const TextStyle(
                            color: Colors.white, fontFamily: 'Pacifico'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              localizations.translate('office_blocked'),
                              style: const TextStyle(
                                  color: Colors.white, fontFamily: 'Pacifico'),
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        localizations.translate('block_office'),
                        style: const TextStyle(
                            color: Colors.white, fontFamily: 'Pacifico'),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        localizations.translate('complaint_submitted'),
                        style: const TextStyle(
                            color: Colors.white, fontFamily: 'Pacifico'),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 104, 115, 214),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  localizations.translate('submit_complaint'),
                  style: const TextStyle(
                      color: Colors.white, fontFamily: 'Pacifico'),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String label;
  final String value;

  const InfoCard({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
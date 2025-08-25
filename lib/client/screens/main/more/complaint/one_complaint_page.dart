
// import 'package:flutter/material.dart';
// import 'package:property_system/l10n/app_localizations.dart';

// class OneComplaintPage extends StatelessWidget {
//   const OneComplaintPage({
//     super.key,
//     required this.complaintName,
//     required this.submissionDate,
//     required this.complaintReason,
//     required this.complaintStatus,
//   });

//   final String complaintName;
//   final String submissionDate;
//   final String complaintReason;
//   final String complaintStatus;

//   @override
//   Widget build(BuildContext context) {
//     final localizations = AppLocalizations.of(context)!;

//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: ListView(
//           children: [
//             Text(
//               localizations.translate('complaint_info'),
//               style: const TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 fontFamily: 'Cairo',
//               ),
//             ),
//             const SizedBox(height: 20),
//             Card(
//               child: ListTile(
//                 leading: const Icon(Icons.person),
//                 title: Text(localizations.translate('complaint_name')),
//                 trailing: Text(
//                   complaintName,
//                   style: const TextStyle(color: Colors.blue, fontSize: 20),
//                 ),
//               ),
//             ),
//             Card(
//               child: ListTile(
//                 leading: const Icon(Icons.calendar_today),
//                 title: Text(localizations.translate('submission_date')),
//                 trailing: Text(
//                   submissionDate,
//                   style: const TextStyle(color: Colors.blue, fontSize: 20),
//                 ),
//               ),
//             ),
//             Card(
//               child: ListTile(
//                 leading: const Icon(Icons.warning),
//                 title: Text(localizations.translate('complaint_reason')),
//                 trailing: Text(
//                   complaintReason,
//                   style: const TextStyle(color: Colors.blue, fontSize: 20),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 24),
//             Text(
//               localizations.translate('complaint_status'),
//               style: const TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 fontFamily: 'Cairo',
//               ),
//             ),
//             const SizedBox(height: 10),
//             Card(
//               color: Colors.orange.shade100,
//               child: ListTile(
//                 leading: const Icon(Icons.info, color: Colors.orange),
//                 title: Text(
//                   localizations.translate(complaintStatus.toLowerCase()),
//                   style: const TextStyle(fontWeight: FontWeight.w600),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

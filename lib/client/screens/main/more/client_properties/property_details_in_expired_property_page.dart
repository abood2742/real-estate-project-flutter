// // import 'package:flutter/material.dart';
// // import 'package:property_system/client/components/card_info_components.dart';
// // import 'package:property_system/client/screens/main/more/complaint/push_complaint_page.dart';

// // class ClientPagePropertyInExpiredPropertyPage extends StatelessWidget {
// //   ClientPagePropertyInExpiredPropertyPage(
// //       {super.key,
// //       required this.pushedOffice,
// //       required this.pushedOfficeAccount,
// //       required this.propertyArea,
// //       required this.propertyLocation,
// //       required this.propertyPrice,
// //       required this.propertyType});
// //   String pushedOffice,
// //       pushedOfficeAccount,
// //       propertyPrice,
// //       propertyLocation,
// //       propertyType,
// //       propertyArea;
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: ListView(
// //         padding: const EdgeInsets.all(16),
// //         children: [
// //           CardInfoComponents(
// //             name: 'المكتب الناشر',
// //             nameName: pushedOffice,
// //           ),
// //           SizedBox(height: 20),
// //           CardInfoComponents(
// //             name: 'حساب المكتب الناشر',
// //             nameName: pushedOfficeAccount,
// //           ),
// //           SizedBox(height: 20),
// //           CardInfoComponents(
// //             name: ' سعر العقار',
// //             nameName: propertyPrice,
// //           ),
// //           SizedBox(height: 20),
// //           CardInfoComponents(
// //             name: 'مكان العقار',
// //             nameName: propertyLocation,
// //           ),
// //           SizedBox(height: 20),
// //           CardInfoComponents(
// //             name: 'نوع العقار',
// //             nameName: propertyType,
// //           ),
// //           SizedBox(height: 20),
// //           CardInfoComponents(
// //             name: 'مساحة العقار',
// //             nameName: propertyArea,
// //           ),
// //           SizedBox(height: 50),
// //           ElevatedButton(
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: Colors.blueAccent,
// //               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(10),
// //               ),
// //             ),
// //             onPressed: () {
// //               Navigator.push(
// //                 context,
// //                 MaterialPageRoute(builder: (context) => PushComplaintPage()),
// //               );
// //             },
// //             child: const Text(
// //               'عرض على الخريطة',
// //               style: TextStyle(
// //                 fontSize: 14,
// //                 color: Colors.white,
// //                 fontFamily: 'Pacifico',
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:property_system/client/components/card_info_components.dart';
// import 'package:property_system/client/screens/main/more/complaint/push_complaint_page.dart';
// import 'package:property_system/l10n/app_localizations.dart';

// class ClientPagePropertyInExpiredPropertyPage extends StatelessWidget {
//   const ClientPagePropertyInExpiredPropertyPage({
//     super.key,
//     required this.pushedOffice,
//     required this.pushedOfficeAccount,
//     required this.propertyArea,
//     required this.propertyLocation,
//     required this.propertyPrice,
//     required this.propertyType,
//   });

//   final String pushedOffice;
//   final String pushedOfficeAccount;
//   final String propertyPrice;
//   final String propertyLocation;
//   final String propertyType;
//   final String propertyArea;

//   @override
//   Widget build(BuildContext context) {
//     final localizations = AppLocalizations.of(context)!;

//     return Scaffold(
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           CardInfoComponents(
//             name: localizations.translate('publishing_office'),
//             nameName: pushedOffice,
//           ),
//           const SizedBox(height: 20),
//           CardInfoComponents(
//             name: localizations.translate('publishing_office_account'),
//             nameName: pushedOfficeAccount,
//           ),
//           const SizedBox(height: 20),
//           CardInfoComponents(
//             name: localizations.translate('property_price'),
//             nameName: propertyPrice,
//           ),
//           const SizedBox(height: 20),
//           CardInfoComponents(
//             name: localizations.translate('property_location'),
//             nameName: propertyLocation,
//           ),
//           const SizedBox(height: 20),
//           CardInfoComponents(
//             name: localizations.translate('property_type'),
//             nameName: propertyType,
//           ),
//           const SizedBox(height: 20),
//           CardInfoComponents(
//             name: localizations.translate('property_area'),
//             nameName: propertyArea,
//           ),
//           const SizedBox(height: 50),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.blueAccent,
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) =>  PushComplaintPage()),
//               );
//             },
//             child: Text(
//               localizations.translate('submit_complaint'),
//               style: const TextStyle(
//                 fontSize: 14,
//                 color: Colors.white,
//                 fontFamily: 'Pacifico',
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:property_system/client/components/card_info_components.dart';
import 'package:property_system/client/screens/main/more/complaint/push_complaint_page.dart';
import 'package:property_system/l10n/app_localizations.dart';

class ClientPagePropertyInExpiredPropertyPage extends StatelessWidget {
  const ClientPagePropertyInExpiredPropertyPage({
    super.key,
    required this.pushedOffice,
    required this.pushedOfficeAccount,
    required this.propertyArea,
    required this.propertyLocation,
    required this.propertyPrice,
    required this.propertyType,
  });

  final String pushedOffice;
  final String pushedOfficeAccount;
  final String propertyPrice;
  final String propertyLocation;
  final String propertyType;
  final String propertyArea;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CardInfoComponents(
            name: localizations.translate('publishing_office'),
            nameName: pushedOffice,
          ),
          const SizedBox(height: 20),
          CardInfoComponents(
            name: localizations.translate('publishing_office_account'),
            nameName: pushedOfficeAccount,
          ),
          const SizedBox(height: 20),
          CardInfoComponents(
            name: localizations.translate('property_price'),
            nameName: propertyPrice,
          ),
          const SizedBox(height: 20),
          CardInfoComponents(
            name: localizations.translate('property_location'),
            nameName: propertyLocation,
          ),
          const SizedBox(height: 20),
          CardInfoComponents(
            name: localizations.translate('property_type'),
            nameName: propertyType,
          ),
          const SizedBox(height: 20),
          CardInfoComponents(
            name: localizations.translate('property_area'),
            nameName: propertyArea,
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  PushComplaintPage()),
              );
            },
            child: Text(
              localizations.translate('submit_complaint'),
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontFamily: 'Pacifico',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:property_system/client/components/complaint_card_office.dart';
// import 'package:property_system/client/components/complaint_card_property.dart';
// import 'package:property_system/client/models/complaient/get_case_3_complainet_model.dart';
// import 'package:property_system/client/models/complaient/get_case_4_complainet_model.dart';
// import 'package:property_system/client/services/complaint_office_service.dart';
// import 'package:property_system/client/services/complaint_property_service.dart';
// import 'package:property_system/l10n/app_localizations.dart';
// import 'package:property_system/office/screens/complaints/office_manager_user_office_complainet_case_3.dart';
// import 'package:property_system/office/screens/complaints/office_manager_user_property_complainet_case_4.dart';

// class OfficeComplaintPage extends StatefulWidget {
//   const OfficeComplaintPage({super.key});

//   @override
//   State<OfficeComplaintPage> createState() => _OfficeComplaintPageState();
// }

// class _OfficeComplaintPageState extends State<OfficeComplaintPage> {
//   List<GetCase3ComplainetModel>? officeComplaints = [];
//   List<GetCase4ComplainetModel>? propertyComplaints = [];

//   @override
//   void initState() {
//     super.initState();
//     getAllComplaints();
//   }

//   getAllComplaints() async {
//     final officeComplaints =
//         await OfficeComplaintService().getComplaintsOnOffice();

//     final propertyComplaints =
//         await PropertyComplaintService().getAllComplaintsOnOfficeProperties();

//     setState(() {
//       this.officeComplaints = officeComplaints;
//       this.propertyComplaints = propertyComplaints;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final localizations = AppLocalizations.of(context)!;

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF3D60C6),
//         toolbarHeight: 50,
//         title: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               'الشكاوى',
//               style: const TextStyle(
//                 fontSize: 20,
//                 color: Colors.white,
//                 fontFamily: 'Pacifico',
//               ),
//             ),
//             const SizedBox(width: 8),
//             SizedBox(
//               height: 50,
//               width: 50,
//               child: Lottie.asset(
//                 'assets/complaint.json',
//                 repeat: true,
//                 animate: true,
//               ),
//             ),
//           ],
//         ),
//         centerTitle: true,
//       ),
//       body: officeComplaints == null || propertyComplaints == null
//           ? const Center(child: CircularProgressIndicator())
//           : (officeComplaints!.isEmpty && propertyComplaints!.isEmpty)
//               ? Center(
//                   child: Text(localizations.translate('no_complaints')),
//                 )
//               : ListView(
//                   padding: const EdgeInsets.all(8),
//                   children: [
//                     // عرض شكاوى المكاتب
//                     ...officeComplaints!.map(
//                       (officeComplaint) => OfficeComplaintCard(
//                         onTap: () {
//                           Navigator.push(context,
//                               MaterialPageRoute(builder: (context) {
//                             return OfficeUserComplainetCase3(
//                               complaint: officeComplaint,
//                             );
//                           }));
//                         },
//                         name:
//                             "${officeComplaint.user.firstName} ${officeComplaint.user.lastName}",
//                         date: officeComplaint.date,
//                         title: officeComplaint.title,
//                       ),
//                     ),

//                     // عرض شكاوى العقارات
//                     ...propertyComplaints!.map(
//                       (propertyComplaint) => PropertyComplaintCard(
//                         onTap: () {
//                           Navigator.push(context,
//                               MaterialPageRoute(builder: (context) {
//                             return OfficeUserPropertyComplainetCase4(
//                               complaint: propertyComplaint,
//                             );
//                           }));
//                         },
//                         date: propertyComplaint.date,
//                         title: propertyComplaint.title,
//                         city: propertyComplaint.propertyModel.location.city,
//                         propertyNumber:
//                             propertyComplaint.propertyModel.propertyNumber,
//                         type: propertyComplaint.propertyModel.propertyType.name,
//                       ),
//                     ),
//                   ],
//                 ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:property_system/client/components/complaint_card_office.dart';
import 'package:property_system/client/components/complaint_card_property.dart';
import 'package:property_system/client/models/complaient/get_case_3_complainet_model.dart';
import 'package:property_system/client/models/complaient/get_case_4_complainet_model.dart';
import 'package:property_system/client/services/complaint_office_service.dart';
import 'package:property_system/client/services/complaint_property_service.dart';
import 'package:property_system/l10n/app_localizations.dart';
import 'package:property_system/office/screens/complaints/office_manager_user_office_complainet_case_3.dart';
import 'package:property_system/office/screens/complaints/office_manager_user_property_complainet_case_4.dart';

class OfficeComplaintPage extends StatefulWidget {
  const OfficeComplaintPage({super.key});

  @override
  State<OfficeComplaintPage> createState() => _OfficeComplaintPageState();
}

class _OfficeComplaintPageState extends State<OfficeComplaintPage> {
  List<GetCase3ComplainetModel>? officeComplaints = [];
  List<GetCase4ComplainetModel>? propertyComplaints = [];

  @override
  void initState() {
    super.initState();
    getAllComplaints();
  }

  getAllComplaints() async {
    final officeComplaints =
        await OfficeComplaintService().getComplaintsOnOffice();

    final propertyComplaints =
        await PropertyComplaintService().getAllComplaintsOnOfficeProperties();

    setState(() {
      this.officeComplaints = officeComplaints;
      this.propertyComplaints = propertyComplaints;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3D60C6),
        toolbarHeight: 50,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              localizations.translate('complaints'),
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontFamily: 'Pacifico',
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              height: 50,
              width: 50,
              child: Lottie.asset(
                'assets/complaint.json',
                repeat: true,
                animate: true,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: officeComplaints == null || propertyComplaints == null
          ? const Center(child: CircularProgressIndicator())
          : (officeComplaints!.isEmpty && propertyComplaints!.isEmpty)
              ? Center(
                  child: Text(localizations.translate('no_complaints')),
                )
              : ListView(
                  padding: const EdgeInsets.all(8),
                  children: [
                    // عرض شكاوى المكاتب
                    ...officeComplaints!.map(
                      (officeComplaint) => OfficeComplaintCard(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return OfficeUserComplainetCase3(
                              complaint: officeComplaint,
                            );
                          }));
                        },
                        name:
                            "${officeComplaint.user.firstName} ${officeComplaint.user.lastName}",
                        date: officeComplaint.date,
                        title: officeComplaint.title,
                      ),
                    ),

                    // عرض شكاوى العقارات
                    ...propertyComplaints!.map(
                      (propertyComplaint) => PropertyComplaintCard(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return OfficeUserPropertyComplainetCase4(
                              complaint: propertyComplaint,
                            );
                          }));
                        },
                        date: propertyComplaint.date,
                        title: propertyComplaint.title,
                        city: propertyComplaint.propertyModel.location.city,
                        propertyNumber:
                            propertyComplaint.propertyModel.propertyNumber,
                        type: propertyComplaint.propertyModel.propertyType.name,
                      ),
                    ),
                  ],
                ),
    );
  }
}

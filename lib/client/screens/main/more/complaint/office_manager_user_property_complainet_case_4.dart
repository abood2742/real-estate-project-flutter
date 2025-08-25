// import 'package:flutter/material.dart';

// class OfficeManagerUserPropertyComplainetCase4 extends StatelessWidget {
//   final Map<String, dynamic> complaint;

//   OfficeManagerUserPropertyComplainetCase4(
//       {super.key,
//       required this.complaint,
//       required this.title,
//       required this.contained,
//       required this.date,
//       required this.name,
//       required this.phone,
//       required this.post});
//   String date, contained, title;
//   String name, post, phone;
//   @override
//   Widget build(BuildContext context) {
//     final office = complaint["office"] ?? {};
//     final List photos = complaint["officeComplaintPhotos"] ?? [];

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "تفاصيل الشكوى",
//           style: TextStyle(color: Colors.white, fontFamily: 'Pacifico'),
//         ),
//         backgroundColor: Colors.teal,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // 📝 كرت معلومات الشكوى
//             SizedBox(
//               width: double.infinity,
//               child: Card(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16)),
//                 elevation: 5,
//                 child: Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(" معلومات الشكوى",
//                           style: Theme.of(context)
//                               .textTheme
//                               .titleLarge!
//                               .copyWith(color: Colors.teal[700])),
//                       const SizedBox(height: 12),
//                       Text("العنوان: $title,"),
//                       Text("المحتوى: $contained,"),
//                       Text("التاريخ: $date,"),
//                       const SizedBox(height: 12),
//                       if (photos.isNotEmpty) ...[
//                         Text("📷 صور الشكوى",
//                             style: Theme.of(context).textTheme.titleMedium),
//                         const SizedBox(height: 10),
//                         SizedBox(
//                           height: 160,
//                           child: ListView.separated(
//                             scrollDirection: Axis.horizontal,
//                             itemCount: photos.length,
//                             separatorBuilder: (_, __) =>
//                                 const SizedBox(width: 8),
//                             itemBuilder: (context, index) {
//                               final photo = photos[index];
//                               return ClipRRect(
//                                 borderRadius: BorderRadius.circular(12),
//                                 child: Image.network(
//                                   photo["url"] ?? "",
//                                   width: 220,
//                                   height: 160,
//                                   fit: BoxFit.cover,
//                                   errorBuilder: (_, __, ___) => Container(
//                                     color: Colors.grey[300],
//                                     width: 220,
//                                     height: 160,
//                                     child: const Icon(Icons.broken_image),
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ]
//                     ],
//                   ),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 20),

//             // 🏢 كرت معلومات المكتب
//             SizedBox(
//               width: double.infinity,
//               child: Card(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16)),
//                 elevation: 5,
//                 child: Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("🏢 معلومات العميل الذي اشتكى",
//                           style: Theme.of(context)
//                               .textTheme
//                               .titleLarge!
//                               .copyWith(color: Colors.teal[700])),
//                       const SizedBox(height: 12),
//                      Text("الإسم : $name,"),
//                       Text("البريد: $post"),
//                       Text("الهاتف: $phone,"),
//                     ],
//                   ),

//                 ),
//               ),

//             ),
//           ],
//         ),
//       ),

//       // 🔘 زر عائم في أسفل الزاوية اليسارية
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => OfficeDetailesPage(officeId: office["id"] ?? ""),
//             ),
//           );
//         },
//         icon: const Icon(Icons.home, color: Colors.white),
//         label: Text(
//           office["name"] ?? "العقار",
//           style: const TextStyle(
//               color: Colors.white, fontFamily: 'Pacifico', fontSize: 16),
//         ),
//         backgroundColor: const Color.fromARGB(255, 4, 70, 125),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
//     );
//   }
// }

// // صفحة المكتب (مثال)
// class OfficeDetailesPage extends StatelessWidget {
//   final String officeId;
//   const OfficeDetailesPage({super.key, required this.officeId});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("عقار $officeId")),
//       body: Center(child: Text("تفاصيل العقار برقم: $officeId")),
//     );
//   }
// }
// import 'package:flutter/material.dart';

// class ClientUserOfficeComplaintCase1 extends StatelessWidget {
//   final Map<String, dynamic> complaint;

//   ClientUserOfficeComplaintCase1(
//       {super.key,
//       required this.complaint,
//       required this.title,
//       required this.contained,
//       required this.date,
//       required this.name,
//       required this.phone,
//       required this.post});
//   String date, contained, title;
//   String name, post, phone;
//   @override
//   Widget build(BuildContext context) {
//     final office = complaint["office"] ?? {};
//     final List photos = complaint["officeComplaintPhotos"] ?? [];

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "تفاصيل الشكوى",
//           style: TextStyle(color: Colors.white, fontFamily: 'Pacifico'),
//         ),
//         backgroundColor: Colors.teal,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // 📝 كرت معلومات الشكوى
//             SizedBox(
//               width: double.infinity,
//               child: Card(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16)),
//                 elevation: 5,
//                 child: Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(" معلومات الشكوى",
//                           style: Theme.of(context)
//                               .textTheme
//                               .titleLarge!
//                               .copyWith(color: Colors.teal[700])),
//                       const SizedBox(height: 12),
//                       Text("العنوان: $title,"),
//                       Text("المحتوى: $contained,"),
//                       Text("التاريخ: $date,"),
//                       const SizedBox(height: 12),
//                       if (photos.isNotEmpty) ...[
//                         Text("📷 صور الشكوى",
//                             style: Theme.of(context).textTheme.titleMedium),
//                         const SizedBox(height: 10),
//                         SizedBox(
//                           height: 160,
//                           child: ListView.separated(
//                             scrollDirection: Axis.horizontal,
//                             itemCount: photos.length,
//                             separatorBuilder: (_, __) =>
//                                 const SizedBox(width: 8),
//                             itemBuilder: (context, index) {
//                               final photo = photos[index];
//                               return ClipRRect(
//                                 borderRadius: BorderRadius.circular(12),
//                                 child: Image.network(
//                                   photo["url"] ?? "",
//                                   width: 220,
//                                   height: 160,
//                                   fit: BoxFit.cover,
//                                   errorBuilder: (_, __, ___) => Container(
//                                     color: Colors.grey[300],
//                                     width: 220,
//                                     height: 160,
//                                     child: const Icon(Icons.broken_image),
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ]
//                     ],
//                   ),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 20),

//             // 🏢 كرت معلومات المكتب
//             SizedBox(
//               width: double.infinity,
//               child: Card(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16)),
//                 elevation: 5,
//                 child: Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("🏢 معلومات المكتب",
//                           style: Theme.of(context)
//                               .textTheme
//                               .titleLarge!
//                               .copyWith(color: Colors.teal[700])),
//                       const SizedBox(height: 12),
//                      Text("الإسم : $name,"),
//                       Text("البريد: $post"),
//                       Text("الهاتف: $phone,"),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),

//       // 🔘 زر عائم في أسفل الزاوية اليسارية
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => OfficeDetailesPage(officeId: office["id"] ?? ""),
//             ),
//           );
//         },
//         icon: const Icon(Icons.business, color: Colors.white),
//         label: Text(
//           office["name"] ?? "المكتب",
//           style: const TextStyle(
//               color: Colors.white, fontFamily: 'Pacifico', fontSize: 16),
//         ),
//         backgroundColor: const Color.fromARGB(255, 4, 70, 125),
//       ),

//       floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,

// //من هنا
//  floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => OfficeDetailesPage(officeId: office["id"] ?? ""),
//             ),
//           );
//         },
//         icon: const Icon(Icons.business, color: Colors.white),
//         label: Text(
//           office["name"] ?? "المكتب",
//           style: const TextStyle(
//               color: Colors.white, fontFamily: 'Pacifico', fontSize: 16),
//         ),
//         backgroundColor: const Color.fromARGB(255, 4, 70, 125),
//       ),

//       floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
// //الى هنا

//     );
//   }
// }

// // صفحة المكتب (مثال)
// class OfficeDetailesPage extends StatelessWidget {
//   final String officeId;
//   const OfficeDetailesPage({super.key, required this.officeId});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("مكتب $officeId")),
//       body: Center(child: Text("تفاصيل المكتب برقم: $officeId")),
//     );
//   }
// }
// class proeDetailesPage extends StatelessWidget {
//   final String officeId;
//   const proeDetailesPage({super.key, required this.officeId});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("عقار $officeId")),
//       body: Center(child: Text("تفاصيل العقار برقم: $officeId")),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:property_system/client/screens/auth/register/start_register_page.dart';

class OfficeManagerUserPropertyComplainetCase4 extends StatelessWidget {
  final Map<String, dynamic> complaint;

  OfficeManagerUserPropertyComplainetCase4({
    super.key,
    required this.complaint,
    required this.title,
    required this.contained,
    required this.date,
    required this.name,
    required this.phone,
    required this.clientEmail,
  });

  String date, contained, title;
  String name, clientEmail, phone;

  @override
  Widget build(BuildContext context) {
    final office = complaint["office"] ?? {};
    final property = complaint["property"] ?? {}; // افتراض بيانات العقار
    final List photos = complaint["officeComplaintPhotos"] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "تفاصيل الشكوى",
          style: TextStyle(color: Colors.white, fontFamily: 'Pacifico'),
        ),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📝 كرت معلومات الشكوى
            SizedBox(
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "معلومات الشكوى",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: const Color.fromARGB(255, 18, 48, 131)),
                      ),
                      const SizedBox(height: 12),
                      Text("العنوان: $title,"),
                      Text("المحتوى: $contained,"),
                      Text("التاريخ: $date,"),
                      const SizedBox(height: 12),
                      if (photos.isNotEmpty) ...[
                        Text(
                          "📷 صور الشكوى",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 160,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: photos.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: 8),
                            itemBuilder: (context, index) {
                              final photo = photos[index];
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  photo["url"] ?? "",
                                  width: 220,
                                  height: 160,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    color: Colors.grey[300],
                                    width: 220,
                                    height: 160,
                                    child: const Icon(Icons.broken_image),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🏢 كرت معلومات المكتب
            SizedBox(
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "🏢 معلومات العميل",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: const Color.fromARGB(255, 25, 61, 130)),
                      ),
                      const SizedBox(height: 12),
                      Text("الإسم: $name,"),
                      Text("الإيميل: $clientEmail"),
                      Text("الهاتف: $phone,"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // 🔘 استخدام Stack لإضافة زرين عائمين
      floatingActionButton: Stack(
        children: [
          // زر المكتب في الزاوية اليسرى السفلية
          Positioned(
            bottom: 10,
            left: 16, // الزاوية اليسرى
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Client(officeId: office["id"] ?? ""),
                  ),
                );
              },
              icon: const Icon(Icons.home, color: Colors.white),
              label: Text(
                office["name"] ?? "العقار",
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Pacifico',
                  fontSize: 16,
                ),
              ),
              backgroundColor: const Color.fromARGB(255, 4, 70, 125),
            ),
          ),
          // زر العقار في الزاوية اليمنى السفلية
          Positioned(
            bottom: 10,
            right: 28, // الزاوية اليمنى
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        proeDetailesPage(propertyId: property["id"] ?? ""),
                  ),
                );
              },
              icon: const Icon(Icons.verified_user,
                  color: Colors.white), // أيقونة للعقار
              label: Text(
                property["name"] ?? "العميل",
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Pacifico',
                  fontSize: 16,
                ),
              ),
              backgroundColor: const Color.fromARGB(255, 4, 70, 125),
            ),
          ),
        ],
      ),
    );
  }
}

// صفحة المكتب (مثال)
class Client extends StatelessWidget {
  final String officeId;
  const Client({super.key, required this.officeId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "عميل $officeId",
          style: const TextStyle(color: Colors.white, fontFamily: 'Pacifico'),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Center(child: Text("تفاصيل المكتب برقم: $officeId")),
    );
  }
}

// صفحة العقار (مع تصحيح اسم المعامل)
class proeDetailesPage extends StatelessWidget {
  final String propertyId; // تصحيح من officeId إلى propertyId
  const proeDetailesPage({super.key, required this.propertyId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "العقار $propertyId",
          style: const TextStyle(color: Colors.white, fontFamily: 'Pacifico'),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Center(child: Text("تفاصيل العقار برقم: $propertyId")),
    );
  }
}

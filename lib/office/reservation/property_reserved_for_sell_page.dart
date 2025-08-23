// // // import 'package:flutter/material.dart';

// // // class PropertyReservedForSellPage extends StatelessWidget {
// // //   final String email;
// // //   const PropertyReservedForSellPage({super.key, required this.email});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         centerTitle: true,
// // //         elevation: 2,
// // //         backgroundColor: const Color.fromARGB(255, 63, 22, 97),
// // //         title: const Text(
// // //           'صفحة العقار المحجوز للإيجار',
// // //           style: TextStyle(color: Colors.white, fontFamily: 'Pacifico'),
// // //         ),
// // //       ),
// // //       body: Padding(
// // //         padding: const EdgeInsets.all(16.0),
// // //         child: Column(
// // //           children: [
// // //             // بطاقة حساب المستخدم
// // //             Card(
// // //               shape: RoundedRectangleBorder(
// // //                 borderRadius: BorderRadius.circular(16),
// // //               ),
// // //               elevation: 4,
// // //               child: ListTile(
// // //                 leading: const CircleAvatar(
// // //                   backgroundColor: Colors.deepPurple,
// // //                   child: Icon(Icons.person, color: Colors.white),
// // //                 ),
// // //                 title: const Text(
// // //                   'حساب العميل الناشر',
// // //                   style: TextStyle(
// // //                       fontWeight: FontWeight.bold, color: Colors.blue),
// // //                 ),
// // //                 subtitle: Text(
// // //                   email,
// // //                   style: const TextStyle(
// // //                     fontFamily: 'Pacifico',
// // //                     fontSize: 16,
// // //                   ),
// // //                 ),
// // //               ),
// // //             ),
// // //             const SizedBox(height: 20),
// // //             const Text(
// // //               'صور العقار',
// // //               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// // //             ),
// // //             const SizedBox(height: 12),

// // //             // شبكة الصور
// // //             Expanded(
// // //               child: GridView.count(
// // //                 crossAxisCount: 2,
// // //                 mainAxisSpacing: 12,
// // //                 crossAxisSpacing: 12,
// // //                 children: const [
// // //                   _PropertyImage(assetPath: 'assets/images/init.png'),
// // //                   _PropertyImage(assetPath: 'assets/images/init.png'),
// // //                   _PropertyImage(assetPath: 'assets/images/init.png'),
// // //                   _PropertyImage(assetPath: 'assets/images/init.png'),
// // //                 ],
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // // // ويدجت صغير للصور
// // // class _PropertyImage extends StatelessWidget {
// // //   final String assetPath;
// // //   const _PropertyImage({required this.assetPath});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return ClipRRect(
// // //       borderRadius: BorderRadius.circular(16),
// // //       child: Image.asset(
// // //         assetPath,
// // //         fit: BoxFit.cover,
// // //       ),
// // //     );
// // //   }
// // // }
// // import 'package:flutter/material.dart';

// // class PropertyReservedForSellPage extends StatelessWidget {
// //   final String email;
// //   const PropertyReservedForSellPage({super.key, required this.email});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         centerTitle: true,
// //         elevation: 2,
// //         backgroundColor: const Color.fromARGB(255, 63, 22, 97),
// //         title: const Text(
// //           'صفحة العقار المحجوز للإيجار',
// //           style: TextStyle(color: Colors.white, fontFamily: 'Pacifico'),
// //         ),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: ListView(
// //           children: [
// //             // بطاقة حساب المستخدم
// //             Card(
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(16),
// //               ),
// //               elevation: 4,
// //               child: ListTile(
// //                 leading: const CircleAvatar(
// //                   backgroundColor: Colors.deepPurple,
// //                   child: Icon(Icons.person, color: Colors.white),
// //                 ),
// //                 title: const Text(
// //                   'حساب العميل الناشر',
// //                   style: TextStyle(
// //                       fontWeight: FontWeight.bold, color: Colors.blue),
// //                 ),
// //                 subtitle: Text(
// //                   'email',
// //                   style: const TextStyle(
// //                     fontFamily: 'Pacifico',
// //                     fontSize: 16,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //             const SizedBox(height: 20),
// //             const Text(
// //               'صور العقار',
// //               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //             ),
// //             const SizedBox(height: 12),

// //             // شبكة الصور
// //             Expanded(
// //               child: GridView.count(
// //                 crossAxisCount: 2,
// //                 mainAxisSpacing: 12,
// //                 crossAxisSpacing: 12,
// //                 children: const [
// //                   _PropertyImage(assetPath: 'assets/images/init.png'),
// //                   _PropertyImage(assetPath: 'assets/images/init.png'),
// //                   _PropertyImage(assetPath: 'assets/images/init.png'),
// //                   _PropertyImage(assetPath: 'assets/images/init.png'),
// //                 ],
// //               ),
// //             ),
// //             const SizedBox(height: 20),
// //             const Text(
// //               'معلومات المكتب',
// //               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //             ),
// //             const SizedBox(height: 12),
// //    Card(
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(16),
// //               ),
// //               elevation: 4,
// //               child: ListTile(
// //                 leading: const Icon(Icons.location_city),
// //                 title: const Text(
// //                   'موقع المكتب ',
// //                   style: TextStyle(
// //                       fontWeight: FontWeight.bold, color: Colors.blue),
// //                 ),
// //                 subtitle: Text(
// //                   'الصالحية',
// //                   style: const TextStyle(
// //                     fontFamily: 'Pacifico',
// //                     fontSize: 16,
// //                   ),
// //                 ),
// //               ),
// //             ),

// //                const SizedBox(height: 12),
// //    Card(
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(16),
// //               ),
// //               elevation: 4,
// //               child: ListTile(
// //                 leading: const Icon(Icons.person),
// //                 title: const Text(
// //                   'إسم صاحب المكتب ',
// //                   style: TextStyle(
// //                       fontWeight: FontWeight.bold, color: Colors.blue),
// //                 ),
// //                 subtitle: Text(
// //                   'محمود سليمان',
// //                   style: const TextStyle(
// //                     fontFamily: 'Pacifico',
// //                     fontSize: 16,
// //                   ),
// //                 ),
// //               ),
// //             ),

// //              const SizedBox(height: 12),
// //    Card(
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(16),
// //               ),
// //               elevation: 4,
// //               child: ListTile(
// //                 leading: const Icon(Icons.person),
// //                 title: const Text(
// //                   'رقم التواصل',
// //                   style: TextStyle(
// //                       fontWeight: FontWeight.bold, color: Colors.blue),
// //                 ),
// //                 subtitle: Text(
// //                   '0985129560',
// //                   style: const TextStyle(
// //                     fontFamily: 'Pacifico',
// //                     fontSize: 16,
// //                   ),
// //                 ),
// //               ),
// //             ),

// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // // ويدجت الصورة مع تكبير عند الضغط
// // class _PropertyImage extends StatelessWidget {
// //   final String assetPath;
// //   const _PropertyImage({required this.assetPath});

// //   @override
// //   Widget build(BuildContext context) {
// //     return GestureDetector(
// //       onTap: () {
// //         Navigator.push(
// //           context,
// //           MaterialPageRoute(
// //             builder: (_) => FullScreenImage(assetPath: assetPath),
// //           ),
// //         );
// //       },
// //       child: ClipRRect(
// //         borderRadius: BorderRadius.circular(16),
// //         child: Image.asset(
// //           assetPath,
// //           fit: BoxFit.cover,
// //         ),
// //       ),
// //     );
// //   }
// // }

// // // صفحة الصورة المكبرة
// // class FullScreenImage extends StatelessWidget {
// //   final String assetPath;
// //   const FullScreenImage({super.key, required this.assetPath});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.black,
// //       body: GestureDetector(
// //         onTap: () => Navigator.pop(context),
// //         child: Center(
// //           child: Hero(
// //             tag: assetPath, // لعمل أنيميشن انتقال سلس
// //             child: Image.asset(assetPath, fit: BoxFit.contain),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';

// class PropertyReservedForSellPage extends StatelessWidget {
//   final String email;
//   const PropertyReservedForSellPage({super.key, required this.email});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         elevation: 2,
//         backgroundColor: const Color.fromARGB(255, 63, 22, 97),
//         title: const Text(
//           'صفحة العقار المحجوز للإيجار',
//           style: TextStyle(color: Colors.white, fontFamily: 'Pacifico'),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView(
//           children: [
//             // بطاقة حساب المستخدم
//             Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               elevation: 4,
//               child: ListTile(
//                 leading: const CircleAvatar(
//                   backgroundColor: Colors.deepPurple,
//                   child: Icon(Icons.person, color: Colors.white),
//                 ),
//                 title: const Text(
//                   'حساب العميل الناشر',
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold, color: Colors.blue),
//                 ),
//                 subtitle: Text(
//                   email,
//                   style: const TextStyle(
//                     fontFamily: 'Pacifico',
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 20),
//             const Text(
//               'صور العقار',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 12),

//             // شبكة الصور (بدون Expanded)
//             GridView.count(
//               crossAxisCount: 2,
//               mainAxisSpacing: 12,
//               crossAxisSpacing: 12,
//               shrinkWrap: true, // ضروري
//               physics: const NeverScrollableScrollPhysics(), // عشان ما يتعارض مع ListView
//               children: const [
//                 _PropertyImage(assetPath: 'assets/images/init.png'),
//                 _PropertyImage(assetPath: 'assets/images/init.png'),
//                 _PropertyImage(assetPath: 'assets/images/init.png'),
//                 _PropertyImage(assetPath: 'assets/images/init.png'),
//               ],
//             ),

//             const SizedBox(height: 20),
//             const Text(
//               'معلومات المكتب',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 12),

//             Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               elevation: 4,
//               child: const ListTile(
//                 leading: Icon(Icons.location_city),
//                 title: Text(
//                   'موقع المكتب ',
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold, color: Colors.blue),
//                 ),
//                 subtitle: Text(
//                   'الصالحية',
//                   style: TextStyle(
//                     fontFamily: 'Pacifico',
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 12),
//             Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               elevation: 4,
//               child: const ListTile(
//                 leading: Icon(Icons.person),
//                 title: Text(
//                   'إسم صاحب المكتب ',
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold, color: Colors.blue),
//                 ),
//                 subtitle: Text(
//                   'محمود سليمان',
//                   style: TextStyle(
//                     fontFamily: 'Pacifico',
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 12),
//             Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               elevation: 4,
//               child: const ListTile(
//                 leading: Icon(Icons.phone),
//                 title: Text(
//                   'رقم التواصل',
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold, color: Colors.blue),
//                 ),
//                 subtitle: Text(
//                   '0985129560',
//                   style: TextStyle(
//                     fontFamily: 'Pacifico',
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ويدجت الصورة مع تكبير عند الضغط
// class _PropertyImage extends StatelessWidget {
//   final String assetPath;
//   const _PropertyImage({required this.assetPath});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (_) => FullScreenImage(assetPath: assetPath),
//           ),
//         );
//       },
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(16),
//         child: Image.asset(
//           assetPath,
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }
// }

// // صفحة الصورة المكبرة
// class FullScreenImage extends StatelessWidget {
//   final String assetPath;
//   const FullScreenImage({super.key, required this.assetPath});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: GestureDetector(
//         onTap: () => Navigator.pop(context),
//         child: Center(
//           child: Hero(
//             tag: assetPath,
//             child: Image.asset(assetPath, fit: BoxFit.contain),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:property_system/office/reservation/soled_page_property_reserved_for_sell_page.dart';

class PropertyReservedForSellPage extends StatelessWidget {
  final String email;
  const PropertyReservedForSellPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        backgroundColor: const Color.fromARGB(255, 63, 22, 97),
        title: const Text(
          ' عقار محجوز للبيع',
          style: TextStyle(color: Colors.white, fontFamily: 'Pacifico'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // بطاقة حساب المستخدم
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.deepPurple,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                title: const Text(
                  'حساب العميل الذي حجز العقار',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                subtitle: Text(
                  email,
                  style: const TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              'صور العقار',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // شبكة الصور (بدون Expanded)
            GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                _PropertyImage(assetPath: 'assets/images/init.png'),
                _PropertyImage(assetPath: 'assets/images/init.png'),
                _PropertyImage(assetPath: 'assets/images/init.png'),
                _PropertyImage(assetPath: 'assets/images/init.png'),
              ],
            ),

            const SizedBox(height: 20),
            const Text(
              'معلومات العقار',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: const ListTile(
                leading: Icon(Icons.location_city),
                title: Text(
                  'موقع العقار ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                subtitle: Text(
                  'الصالحية',
                  style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 16,
                  ),
                ),
              ),
            ),

             Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: const ListTile(
                leading: Icon(Icons.location_city),
                title: Text(
                  ' نبذه عن هذا العقار ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                subtitle: Text(
                  'الصالحية',
                  style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: const ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  'إسم صاحب العقار ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                subtitle: Text(
                  'محمود سليمان',
                  style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: const ListTile(
                leading: Icon(Icons.phone),
                title: Text(
                  'رقم التواصل',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                subtitle: Text(
                  '0985129560',
                  style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // زر "تم البيع"
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
       
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return  SoledPagePropertyReservedForSellPage();
                }));
          },
          child: const Text(
            "تم البيع",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

// ويدجت الصورة مع تكبير عند الضغط
class _PropertyImage extends StatelessWidget {
  final String assetPath;
  const _PropertyImage({required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FullScreenImage(assetPath: assetPath),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          assetPath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

// صفحة الصورة المكبرة
class FullScreenImage extends StatelessWidget {
  final String assetPath;
  const FullScreenImage({super.key, required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: Hero(
            tag: assetPath,
            child: Image.asset(assetPath, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}

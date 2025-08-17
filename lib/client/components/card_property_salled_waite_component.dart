// import 'package:flutter/material.dart';

// class CardToPropertySalledOrRentedInWaiteComponent extends StatelessWidget {
//   final String imageUrl;

//   final String date;
//   final String location;
//   final VoidCallback? onTap;

//   const CardToPropertySalledOrRentedInWaiteComponent({
//     Key? key,
//     required this.imageUrl,

//     required this.date,
//     required this.location,
//     this.onTap,

//   }) : super(key: key);

//   String _formatDate(DateTime date) {
//     return '${date.year}/${date.month}/${date.day}';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(16),
//           color: Colors.white,
//         ),
//         width: 300,
//         height: 450,
//         margin: const EdgeInsets.all(10),
//         child: Column(
//           children: [
//             // صورة العقار
//             Container(
//               height: 380,
//               width: double.infinity,
//               child: Image.network(
//                 imageUrl,
//                 fit: BoxFit.cover,
//               ),
//             ),

//             // معلومات العقار
//             Container(
//               padding: const EdgeInsets.all(10),
//               child: Column(
//                 children: [
//                   // التاريخ + الشقة
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                        date,
//                         textDirection: TextDirection.rtl,
//                       ),
//                       Text(
//                         'شقة : تم البيع',
//                         textDirection: TextDirection.rtl,
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 10),

//                   // اسم المالك + ايقونة
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Text(
//                         location,
//                         textDirection: TextDirection.rtl,
//                       ),
//                       const SizedBox(width: 6),
//                       const Icon(Icons.location_on, size: 16),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class CardPropertySalledWaiteComponent extends StatelessWidget {
  final String imageUrl;
  final String date;
  final String location;
  final VoidCallback? onTap;

  const CardPropertySalledWaiteComponent({
    Key? key,
    required this.imageUrl,
    required this.date,
    required this.location,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            width: 300,
            height: 450,
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
        
                // صورة العقار + الحواف
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 380,
                    width: 280,
                    fit: BoxFit.cover,
                  ),
                ),
        
                // معلومات العقار
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(date, textDirection: TextDirection.rtl),
                          const Text(' تم البيع', textDirection: TextDirection.rtl),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(location, textDirection: TextDirection.rtl),
                          const SizedBox(width: 6),
                          const Icon(Icons.location_on, size: 16),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10,),
        Divider(height: 1,color: const Color.fromARGB(255, 65, 128, 221),),
        SizedBox(height: 10,),
      ],
    );
  }
}

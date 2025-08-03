import 'package:flutter/material.dart';
import 'package:property_system/client_user/components/rectangle.dart';



class SearchModel extends StatelessWidget {
  const SearchModel({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Center(
          child: Row(
            children: [
              Rectangle(name: 'Home ',  icon: Icons.home,),
              Rectangle(name: 'Home ',  icon: Icons.home,),
              Rectangle(name: 'Home ',  icon: Icons.home,),
            ],
          ),
        ),
      ),
    );
  }
}

// class PropertyBox extends StatelessWidget {
//   const PropertyBox({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 320,
//       height: 320,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 6,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // صورة العقار
//           Container(
//             height: 180,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//               image: DecorationImage(
//                 image: AssetImage('assets/images/pic1.jpg'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // الاسم والسعر
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: const [
//                     Text(
//                       'Deppartment',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       '20000\$',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 6),
//                 // الموقع
//                 Row(
//                   children: [
//                     const Icon(Icons.location_on, size: 16, color: Colors.grey),
//                     const SizedBox(width: 4),
//                     Text(
//                       'Bab sharqi, Damascus',
//                       style: TextStyle(color: Colors.grey[600]),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 12),
//                 // تفاصيل
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: const [
//                     FeatureItem(icon: Icons.bathtub, label: '4 baths'),
//                     FeatureItem(icon: Icons.bed, label: '3 rooms'),
//                     FeatureItem(icon: Icons.crop_square, label: '30 m²'),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class FeatureItem extends StatelessWidget {
//   final IconData icon;
//   final String label;

//   const FeatureItem({required this.icon, required this.label, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Icon(icon, size: 16, color: Colors.grey[700]),
//         const SizedBox(width: 4),
//         Text(label, style: TextStyle(color: Colors.grey[700])),
//       ],
//     );
//   }
// }

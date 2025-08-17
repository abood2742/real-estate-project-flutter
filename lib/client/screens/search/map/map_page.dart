// // import 'package:flutter/material.dart';
// // import 'package:flutter_map/flutter_map.dart';
// // import 'package:latlong2/latlong.dart';

// // class MapPage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text('خريطة تفاعلية')),
// //       body: FlutterMap(
// //         options: MapOptions(
// //           center: LatLng(31.9686, 99.9018), // إحداثيات الموقع
// //           zoom: 10,
// //         ),
// //         children: [
// //           TileLayer(
// //             urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
// //             subdomains: ['a', 'b', 'c'],
// //           ),
// //           MarkerLayer(
// //             markers: [
// //               Marker(
// //                 point: LatLng(31.9686, 99.9018),
// //                 width: 40,
// //                 height: 40,
// //                 builder: (context) => Icon(Icons.location_on, color: Colors.red, size: 40),
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';


// // class MapPage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text('خريطة تفاعلية')),
// //       body: FlutterMap(
// //         options: MapOptions(
// //           initialCenter: LatLng(31.9686, 99.9018), // تم تغيير center إلى initialCenter
// //           initialZoom: 10, // تم تغيير zoom إلى initialZoom
// //         ),
// //         children: [ // layers تم استبدالها بـ children مباشرة
// //           TileLayer(
// //             urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
// //             subdomains: ['a', 'b', 'c'],
// //           ),
// //           MarkerLayer(
// //             markers: [
// //               Marker(
// //                 point: LatLng(31.9686, 99.9018),
// //                 width: 40,
// //                 height: 40,
// //                 child: Icon(Icons.location_on, color: Colors.red, size: 40), // تم تغيير builder إلى child
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }


//     class MapPage extends StatelessWidget {
//       @override
//       Widget build(BuildContext context) {
//         return Scaffold(
//           appBar: AppBar(title: Text('خريطة تفاعلية لسوريا',style: TextStyle(color: Colors.blue,fontFamily: 'Pacifico'),)), // يمكنك تغيير العنوان أيضًا
//           body: FlutterMap(
//             options: MapOptions(
//               initialCenter: LatLng(33.5138, 36.2765), // إحداثيات سوريا (دمشق كمثال)
//               initialZoom: 7, // يمكنك تعديل مستوى التكبير حسب الحاجة لعرض سوريا بشكل جيد
//             ),
//             children: [
//               TileLayer(
//                 urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//                 subdomains: ['a', 'b', 'c'],
//                 // يمكنك إضافة User-Agent header إذا كنت تواجه مشاكل في تحميل المربعات
//                 // userAgentPackageName: 'com.example.app', // استبدل باسم حزمتك
//               ),
//               MarkerLayer(
//                 markers: [
//                   Marker(
//                     point: LatLng(33.5138, 36.2765), // يمكنك وضع علامة على دمشق أو أي موقع آخر
//                     width: 40,
//                     height: 40,
//                     child: Icon(Icons.location_on, color: Colors.red, size: 40),
//                   ),
//                   // يمكنك إضافة المزيد من العلامات لمواقع أخرى في سوريا
//                 ],
//               ),
//             ],
//           ),
//         );
//       }
//     }
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Property {
  final String name;
  final double lat;
  final double lng;

  Property({required this.name, required this.lat, required this.lng});
}

class MapPage extends StatelessWidget {
  // هنا تضع عقاراتك
  final List<Property> properties = [
    Property(
      name: 'النخبة - ريف دمشق السيدة زينب',
      lat: 33.4440,
      lng: 36.3189,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('خريطة تفاعلية لسوريا',
              style: TextStyle(color: Colors.blue, fontFamily: 'Pacifico'))),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(33.5138, 36.2765),
          initialZoom: 8,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: properties.map((prop) {
              return Marker(
                point: LatLng(prop.lat, prop.lng),
                width: 40,
                height: 40,
                child: Icon(Icons.location_on,
                    size: 40, color: Colors.red),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

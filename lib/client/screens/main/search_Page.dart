// import 'package:flutter/material.dart';
// import 'package:property_system/client/components/rectangle.dart';
// import 'package:property_system/client/components/widget_search.dart';
// import 'package:property_system/client/screens/search/filter/filters_page.dart';
// import 'package:property_system/client/screens/search/map/map_page.dart';
// import 'package:property_system/client/screens/search/resault/property/property_detailes_page.dart';

// class SearchPage extends StatelessWidget {
//   const SearchPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: ListView(
//           children: [
//             const Padding(
//               padding: EdgeInsets.only(top: 6),
//               child: Text(
//                 'Search property',
//                 style: TextStyle(
//                   color: const Color.fromARGB(255, 53, 145, 133),
//                   fontFamily: 'Pacifico',
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 12),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(
//                         prefixIcon: const Icon(Icons.search),
//                         hintText: "Search location",
//                         filled: true,
//                         fillColor: Colors.white,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) {
//                         return const FiltersPage();
//                       }));
//                     },
//                     child: Container(
//                       height: 60,
//                       width: 60,
//                       decoration: BoxDecoration(
//                         color: Colors.blue.shade100,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: const Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.filter_list),
//                           SizedBox(height: 4),
//                           Text(
//                             'Filter',
//                             style: TextStyle(fontSize: 10),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 10),
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) {
//                   return MapPage();
//                 }));
//               },
//               child: Row(
//                 children: [
//                   const SizedBox(width: 10),
//                   Container(
//                     height: 60,
//                     width: 240,
//                     child: Row(
//                       children: [
//                         SizedBox(
//                           width: 24,
//                         ),
//                         SizedBox(
//                           width: 25,
//                         ),
//                         Text(
//                           'جميع المكاتب',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontFamily: 'Pacifico',
//                               fontSize: 18),
//                         ),
//                       ],
//                     ),
//                     decoration: BoxDecoration(
//                         color: const Color.fromARGB(255, 33, 135, 104),
//                         borderRadius: BorderRadius.circular(16)),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(16.0),
//                     child: GestureDetector(
//                       onTap: () {
                        
//                       },
//                       child: Text(
//                         'النتائج',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontFamily: 'Pacifico',
//                           color: Colors.lightBlue,
//                           fontSize: 18,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 10),
//             SizedBox(
//               height: 100, // ارتفاع ثابت للسكرول الأفقي
//               child: ListView(
//                 scrollDirection: Axis.horizontal,
//                 children: const [
//                   Rectangle(name: "Home", icon: Icons.home),
//                   SizedBox(width: 10),
//                   Rectangle(name: "Store", icon: Icons.store),
//                   SizedBox(width: 10),
//                   Rectangle(name: "apartment", icon: Icons.apartment),
//                   SizedBox(width: 10),
//                   Rectangle(name: "villa", icon: Icons.villa),
//                   SizedBox(width: 10),
//                   Rectangle(name: "garage", icon: Icons.garage),
//                   SizedBox(width: 10),
//                   Rectangle(
//                       name: "office", icon: Icons.money_off_csred_outlined),
//                   SizedBox(width: 10),
//                   Rectangle(name: "restaurant", icon: Icons.restaurant),
//                   SizedBox(width: 10),
//                   Rectangle(name: "mall", icon: Icons.local_mall),
//                   SizedBox(width: 10),
//                   Rectangle(name: "cafe", icon: Icons.local_cafe),
//                   SizedBox(width: 10),
//                   Rectangle(name: "hotel", icon: Icons.hotel),
//                   SizedBox(width: 10),
//                   Rectangle(name: "warehouse", icon: Icons.warehouse),
//                 ],
//               ),
//             ),
//             const WidgetSearch(
//               returned: PropertyDetailesPage(),

//               title: 'Deppartment',
//               location: 'Hamidia , Damascus',
//               price: '20000\$',
//               imageUrl: 'assets/images/pic3.jpg',
//               area: 30, //
//             ),
//             const WidgetSearch(
//               returned: PropertyDetailesPage(),
//               title: 'Deppartment',
//               location: 'Hamidia , Damascus',
//               price: '20000\$',
//               imageUrl: 'assets/images/pic3.jpg',
//               area: 30, //
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:property_system/client/components/rectangle.dart';
import 'package:property_system/client/components/widget_search.dart';
import 'package:property_system/client/screens/search/filter/filters_page.dart';
import 'package:property_system/client/screens/search/map/map_page.dart';
import 'package:property_system/client/screens/search/resault/property/property_detailes_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool showOffices = false;
  bool showResults = false;

  void _showOffices() {
    setState(() {
      showOffices = true;
      showResults = false;
    });
  }

  void _showResults() {
    setState(() {
      showOffices = false;
      showResults = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 6),
              child: Text(
                'Search property',
                style: TextStyle(
                  color: Color.fromARGB(255, 53, 145, 133),
                  fontFamily: 'Pacifico',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: "Search location",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const FiltersPage();
                      }));
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.filter_list),
                          SizedBox(height: 4),
                          Text(
                            'Filter',
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              // onTap: () {
              //   Navigator.push(context, MaterialPageRoute(builder: (context) {
              //     return MapPage();
              //   }));
              // },
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: _showOffices,
                    child: Container(
                      height: 60,
                      width: 240,
                      child: const Center(
                        child: Text(
                          'جميع المكاتب',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Pacifico',
                            fontSize: 18,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 33, 135, 104),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      onTap: _showResults,
                      child: const Text(
                        'النتائج',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pacifico',
                          color: Colors.lightBlue,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            /// 👇 هنا نعرض سكرول المكاتب إذا كان showOffices = true
            if (showOffices)
              SizedBox(
                height: 100,
               
              ),

            /// 👇 وهنا نعرض النتائج إذا كان showResults = true
            if (showResults) ...[
                ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    Rectangle(name: "Home", icon: Icons.home),
                    SizedBox(width: 10),
                    Rectangle(name: "Store", icon: Icons.store),
                    SizedBox(width: 10),
                    Rectangle(name: "apartment", icon: Icons.apartment),
                    SizedBox(width: 10),
                    Rectangle(name: "villa", icon: Icons.villa),
                    SizedBox(width: 10),
                    Rectangle(name: "garage", icon: Icons.garage),
                    SizedBox(width: 10),
                    Rectangle(
                        name: "office",
                        icon: Icons.money_off_csred_outlined),
                    SizedBox(width: 10),
                    Rectangle(name: "restaurant", icon: Icons.restaurant),
                    SizedBox(width: 10),
                    Rectangle(name: "mall", icon: Icons.local_mall),
                    SizedBox(width: 10),
                    Rectangle(name: "cafe", icon: Icons.local_cafe),
                    SizedBox(width: 10),
                    Rectangle(name: "hotel", icon: Icons.hotel),
                    SizedBox(width: 10),
                    Rectangle(name: "warehouse", icon: Icons.warehouse),
                  ],
                ),
              const WidgetSearch(
                returned: PropertyDetailesPage(),
                title: 'Deppartment',
                location: 'Hamidia , Damascus',
                price: '20000\$',
                imageUrl: 'assets/images/pic3.jpg',
                area: 30,
              ),
              const WidgetSearch(
                returned: PropertyDetailesPage(),
                title: 'Deppartment',
                location: 'Hamidia , Damascus',
                price: '20000\$',
                imageUrl: 'assets/images/pic3.jpg',
                area: 30,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

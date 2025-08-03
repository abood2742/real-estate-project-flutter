import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:property_system/client_user/components/rectangle.dart';
import 'package:property_system/client_user/components/widget_search.dart';
import 'package:property_system/client_user/screens/filters_page.dart';
import 'package:property_system/client_user/screens/map_page.dart';
import 'package:property_system/client_user/screens/property_detailes_page.dart';


class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

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
                  color: const Color.fromARGB(255, 53, 145, 133),
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
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MapPage();
                }));
              },
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Container(
                    height: 60,
                    width: 240,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 24,
                        ),
                        Icon(
                          Icons.map,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Text(
                          'Map',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Pacifico',
                              fontSize: 18),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 45, 99, 209),
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  // Expanded(
                  //   child: TextField(
                  //     style: const TextStyle(color: Colors.white),
                  //     decoration: InputDecoration(
                  //       prefixIcon: const Icon(
                  //         Icons.map,
                  //         color: Colors.white,
                  //       ),
                  //       hintText: "Search location",
                  //       hintStyle: const TextStyle(color: Colors.white),
                  //       filled: true,
                  //       fillColor: const Color.fromARGB(255, 147, 165, 197),
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(12),
                  //         borderSide: BorderSide.none,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'النتائج',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Pacifico',
                        color: Colors.lightBlue,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 100, // ارتفاع ثابت للسكرول الأفقي
              child: ListView(
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
                      name: "office", icon: Icons.money_off_csred_outlined),
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
            ),
            const WidgetSearch(
              returned: PropertyDetailesPage(),

              title: 'Deppartment',
              location: 'Hamidia , Damascus',
              price: '20000\$',
              imageUrl: 'assets/images/pic3.jpg',
              area: 30, //
            ),
            const WidgetSearch(
              returned: PropertyDetailesPage(),
              title: 'Deppartment',
              location: 'Hamidia , Damascus',
              price: '20000\$',
              imageUrl: 'assets/images/pic3.jpg',
              area: 30, //
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:property_system/client/components/widget_search.dart';
import 'package:property_system/client/components/office_cards/widget_search_office.dart';
import 'package:property_system/client/models/office_card_model.dart';
import 'package:property_system/client/screens/search/filter/filters_page.dart';
import 'package:property_system/client/screens/search/resault/office/office_page_in_search_list_page.dart';
import 'package:property_system/client/screens/search/resault/property/property_detailes_page.dart';
import 'package:property_system/client/services/search_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool showOffices = false;
  bool showProperties = false;
  bool isLoadingOffices = false;

  List<OfficeCardModel>? officeCardModels;

  void _showOffices() async {
    setState(() {
      isLoadingOffices = true;
      showProperties = false;
    });

    officeCardModels = await SearchService().getAllOffices();

    setState(() {
      showOffices = true;
      isLoadingOffices = false;
    });
  }

  void _showProperties() async {
    setState(() {
      showOffices = false;
      showProperties = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
          Row(
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FiltersPage()));
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
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 30),
              GestureDetector(
                onTap: _showProperties,
                child: Container(
                  height: 60,
                  width: 195,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 33, 135, 104),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'عقارات',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Pacifico',
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.home, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 30),
              GestureDetector(
                onTap: _showOffices,
                child: Container(
                  height: 60,
                  width: 195,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 33, 135, 104),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'مكاتب',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Pacifico',
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.business, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          /// عرض حالة التحميل أو المكاتب أو العقارات
          if (isLoadingOffices)
            const Center(child: CircularProgressIndicator())
          else if (showOffices && officeCardModels != null)
            ..._buildOfficeWidgets()
          else if (showProperties) ...[
            const WidgetSearch(
              returned: PropertyDetailesPage(),
              title: 'Deppartment',
              location: 'Hamidia , Damascus',
              price: '20000\$',
              imageUrl: 'assets/images/office2.jpg',
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
    );
  }

  List<Widget> _buildOfficeWidgets() {
    return officeCardModels!.map((office) {
      return OfficeWidget(
        name: office.name,
        phone: office.officePhone,
        imageUrl: office.officePhoto.url,
        ratingsCount: office.ratingsCount,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => OfficePageInSearchListPage(officeId: office.id),
              ));
        },
      );
    }).toList();
  }
}

// class _SearchPageState extends State<SearchPage> {
//   bool showOffices = false;
//   bool showProperties = false;
//   bool isLoadingOffices = false;

//   List<OfficeModel>? officeModels;

//   void _showOffices() async {
//     setState(() {
//       isLoadingOffices = true; // بدء التحميل
//       showProperties = false;
//     });

//     officeModels = await SearchService().getAllOffices();

//     setState(() {
//       showOffices = true;
//       isLoadingOffices = false; // انتهى التحميل
//     });
//   }

//   void _showProperties() async {
//     setState(() {
//       showOffices = false;
//       showProperties = true;
//     });
//   }

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
//                   color: Color.fromARGB(255, 53, 145, 133),
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
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   const SizedBox(width: 30),
//                   GestureDetector(
//                     onTap: _showProperties,
//                     child: Container(
//                       height: 60,
//                       width: 195,
//                       decoration: BoxDecoration(
//                         color: const Color.fromARGB(255, 33, 135, 104),
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: const Center(
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Text(
//                               'عقارات',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontFamily: 'Pacifico',
//                                 fontSize: 18,
//                               ),
//                             ),
//                             SizedBox(width: 8),
//                             Icon(Icons.home, color: Colors.white),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 30),
//                   GestureDetector(
//                     onTap: _showOffices,
//                     child: Container(
//                       height: 60,
//                       width: 195,
//                       decoration: BoxDecoration(
//                         color: const Color.fromARGB(255, 33, 135, 104),
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: const Center(
//                         child: Row(
//                           mainAxisSize: MainAxisSize
//                               .min, // مهم لجعل الـ Row بحجمه الطبيعي فقط
//                           children: [
//                             Text(
//                               'مكاتب',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontFamily: 'Pacifico',
//                                 fontSize: 18,
//                               ),
//                             ),
//                             SizedBox(width: 8),
//                             Icon(Icons.business, color: Colors.white),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 10),

//             /// 👇 هنا نعرض سكرول المكاتب إذا كان showOffices = true
//             if (isLoadingOffices)
//               const Center(
//                 child: CircularProgressIndicator(),
//               )
//             else if (showOffices && officeModels != null)
//               ..._buildOfficeWidgets(),

//             /// 👇 وهنا نعرض النتائج إذا كان showResults = true
//             if (showProperties) ...[
//               // ListView(
//               //   scrollDirection: Axis.horizontal,
//               //   children: const [
//               //     Rectangle(name: "Home", icon: Icons.home),
//               //     SizedBox(width: 10),
//               //     Rectangle(name: "Store", icon: Icons.store),
//               //     SizedBox(width: 10),
//               //     Rectangle(name: "apartment", icon: Icons.apartment),
//               //     SizedBox(width: 10),
//               //     Rectangle(name: "villa", icon: Icons.villa),
//               //     SizedBox(width: 10),
//               //     Rectangle(name: "garage", icon: Icons.garage),
//               //     SizedBox(width: 10),
//               //     Rectangle(
//               //         name: "office", icon: Icons.money_off_csred_outlined),
//               //     SizedBox(width: 10),
//               //     Rectangle(name: "restaurant", icon: Icons.restaurant),
//               //     SizedBox(width: 10),
//               //     Rectangle(name: "mall", icon: Icons.local_mall),
//               //     SizedBox(width: 10),
//               //     Rectangle(name: "cafe", icon: Icons.local_cafe),
//               //     SizedBox(width: 10),
//               //     Rectangle(name: "hotel", icon: Icons.hotel),
//               //     SizedBox(width: 10),
//               //     Rectangle(name: "warehouse", icon: Icons.warehouse),
//               //   ],
//               // ),

//               const WidgetSearch(
//                 returned: PropertyDetailesPage(),
//                 title: 'Deppartment',
//                 location: 'Hamidia , Damascus',
//                 price: '20000\$',
//                 imageUrl: 'assets/images/office2.jpg',
//                 area: 30,
//               ),
//               const WidgetSearch(
//                 returned: PropertyDetailesPage(),
//                 title: 'Deppartment',
//                 location: 'Hamidia , Damascus',
//                 price: '20000\$',
//                 imageUrl: 'assets/images/pic3.jpg',
//                 area: 30,
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }

//   List<Widget> _buildOfficeWidgets() {
//     print(officeModels![0].name); // الطباعة هنا فقط
//     return [
//       SizedBox(
//         height: 300,
//         child: ListView.builder(
//             padding: EdgeInsets.zero, // إزالة أي Padding افتراضي
//           itemCount: officeModels!.length,
//           itemBuilder: (context, index) {
//             final office = officeModels![index];
//             return OfficeWidget(
//               name: office.name,
//               phone: office.officePhone,
//               imageUrl: office.officePhoto.url,
//               ratingsCount: office.ratingsCount,
//             );
//           },
//         ),
//       ),
//     ];
//   }
// }

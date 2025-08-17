import 'package:flutter/material.dart';
import 'package:property_system/client/components/property_card.dart';
import 'package:property_system/client/components/widget_search.dart';
import 'package:property_system/client/components/office_cards/widget_search_office.dart';
import 'package:property_system/client/models/office_card_model.dart';
import 'package:property_system/client/models/property_model.dart';
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
  bool isLoadingProperties = false;

  List<OfficeCardModel>? officeCardModels;
  List<PropertyModel>? propertyModels;

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
      isLoadingProperties = true;
      showOffices = false;
    });

    propertyModels = await SearchService().getAllProperties();

    setState(() {
      showProperties = true;
      isLoadingProperties = false;
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
                onTap: () {
                  _showOffices();
                },
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
          else if (showOffices && officeCardModels != null) ...[
            ..._buildOfficeWidgets()
          ] else if (showProperties) ...[
            ..._buildPropertyWidgets()
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
        rating: office.ratings,
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

  List<Widget> _buildPropertyWidgets() {
    return propertyModels!.map((property) {
      return PropertyCard(
        // onTap: () {
        //   Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (_) => OfficePageInSearchListPage(officeId: office.id),
        //       ));
        // },
        title: property.propertyType.name,
        location: property.location.city,
        price: property.price,
        area: property.space.toString(),
        imageUrl: (property.photos != null && property.photos.isNotEmpty)
            ? property.photos[0].url
            : null, // أو رابط صورة افتراضية
      );
    }).toList();
  }
}

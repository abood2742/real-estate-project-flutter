// properties_dont_pushed_yet_page.dart
import 'package:flutter/material.dart';
import 'package:property_system/client/components/property_cards/property_card.dart';
import 'package:property_system/client/models/property_model.dart';
import 'package:property_system/client/screens/search/resault/property/Property_Details_Page.dart';
import 'package:property_system/office/services/office_properties.dart';

class PendingPropertiesPage extends StatefulWidget {
  const PendingPropertiesPage({super.key});

  @override
  State<PendingPropertiesPage> createState() =>
      _PendingPropertiesPageState();
}

class _PendingPropertiesPageState
    extends State<PendingPropertiesPage> {
  List<PropertyModel> sellProperties = [];
  List<PropertyModel> rentProperties = [];
  bool isLoading = true;
  int selectedPage = 1; // 1: للبيع, 2: للإيجار

  @override
  void initState() {
    super.initState();
    loadNotPushedProperties();
  }

  Future<void> loadNotPushedProperties() async {
    // استبدل officeId بالمعرف الصحيح
    final properties = await OfficeProperties()
        .getPendingPropertiesForOffice();

    setState(() {
      sellProperties = properties!
          .where((p) => p.typeOperation == 'selling')
          .toList();
      rentProperties =
          properties.where((p) => p.typeOperation == 'renting').toList();
      isLoading = false;
    });
  }

  Widget buildList(List<PropertyModel> list) {
    if (isLoading) return const Center(child: CircularProgressIndicator());

    if (list.isEmpty) {
      return const Center(child: Text('لا توجد عقارات'));
    }

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final property = list[index];
        return PropertyCard(
          title: property.propertyType.name,
          location: property.location.city,
          price: property.price,
          area: property.space.toString(),
          imageUrl: property.photos.isNotEmpty ? property.photos[0].url : null,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PropertyDetailsPage(propertyModel: property),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // أزرار التاب الفرعية
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () => setState(() => selectedPage = 1),
                child: Text(
                  'عقارات للبيع',
                  style: TextStyle(
                      fontWeight: selectedPage == 1
                          ? FontWeight.bold
                          : FontWeight.normal,
                      fontFamily: 'Pacifico'),
                ),
              ),
            ),
            Container(width: 1, height: 40, color: const Color(0xff1da786)),
            Expanded(
              child: TextButton(
                onPressed: () => setState(() => selectedPage = 2),
                child: Text(
                  'عقارات للإيجار',
                  style: TextStyle(
                      fontWeight: selectedPage == 2
                          ? FontWeight.bold
                          : FontWeight.normal,
                      fontFamily: 'Pacifico'),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: selectedPage == 1
              ? buildList(sellProperties)
              : buildList(rentProperties),
        ),
      ],
    );
  }
}

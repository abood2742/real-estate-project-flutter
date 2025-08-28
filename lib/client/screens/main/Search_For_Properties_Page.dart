import 'package:flutter/material.dart';
import 'package:property_system/client/components/property_cards/property_card.dart';
import 'package:property_system/client/models/property_model.dart';
import 'package:property_system/client/screens/search/filter/filters_page.dart';
import 'package:property_system/client/screens/search/resault/property/Property_Details_Page.dart';
import 'package:property_system/client/services/notification_service_done.dart';
import 'package:property_system/client/services/search_service.dart';
import 'package:property_system/l10n/app_localizations.dart';

class SearchPage extends StatefulWidget {
  final Map<String, dynamic>? filterData;

  const SearchPage({super.key, this.filterData});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isLoadingProperties = false;
  List<PropertyModel>? propertyModels;

  @override
  void initState() {
    super.initState();
    _loadProperties();
  }

  Future<void> _loadProperties() async {
    setState(() => isLoadingProperties = true);

    propertyModels = await SearchService().getAllProperties();

    await NotificationService()
        .notifyUser(title: 'Welcome', message: "Welcome to property page");
    setState(() => isLoadingProperties = false);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _loadProperties,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                localizations.translate('search_property'),
                style: const TextStyle(
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
                      hintText: localizations.translate('search_location'),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    // TODO: اربط البحث بالباك لاحقًا إذا لزم
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () async {
                    // افتح صفحة الفلاتر وانتظر نتيجة الفلاتر
                    final Map<String, dynamic>? filterData =
                        await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const PropertyFilterPage()),
                    );

                    if (filterData != null) {
                      // جلب العقارات باستخدام الفلاتر
                      setState(() => isLoadingProperties = true);
                      propertyModels = await SearchService()
                          .getFilteredProperties(filterData);
                      setState(() => isLoadingProperties = false);
                    }
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.filter_list),
                        const SizedBox(height: 4),
                        Text(
                          localizations.translate('filter'),
                          style: const TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (isLoadingProperties)
              const Center(
                  child: Padding(
                padding: EdgeInsets.only(top: 24),
                child: CircularProgressIndicator(),
              ))
            else if ((propertyModels ?? []).isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Center(
                  child:
                      Text(localizations.translate('no_properties_available')),
                ),
              )
            else
              ..._buildPropertyWidgets(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPropertyWidgets() {
    return propertyModels!.map((property) {
      return PropertyCard(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PropertyDetailsPage(propertyModel: property),
            ),
          );
        },
        title: property.propertyType.name,
        location: property.location.city,
        price: property.price,
        area: property.space.toString(),
        imageUrl: property.photos.isNotEmpty ? property.photos[0].url : null,
      );
    }).toList();
  }
}

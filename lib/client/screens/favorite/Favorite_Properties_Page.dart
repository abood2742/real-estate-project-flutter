import 'package:flutter/material.dart';
import 'package:property_system/client/components/property_cards/property_card.dart';
import 'package:property_system/client/models/property_model.dart';
import 'package:property_system/client/screens/search/resault/property/property_detailes_page.dart';
import 'package:property_system/client/services/favorite_service.dart';

class FavoritePropertiesPage extends StatefulWidget {
  const FavoritePropertiesPage({super.key});

  @override
  State<FavoritePropertiesPage> createState() => _FavoritePropertiesPageState();
}

class _FavoritePropertiesPageState extends State<FavoritePropertiesPage> {
  List<PropertyModel>? favoriteProperties;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getFavoriteProperties();
  }

  Future<void> getFavoriteProperties() async {
    favoriteProperties = await FavoriteService().getFavoriteProperties();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : (favoriteProperties == null || favoriteProperties!.isEmpty)
              ? const Center(child: Text("لا يوجد عقارات محفوظة"))
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: favoriteProperties!.length,
                  itemBuilder: (context, index) {
                    final property = favoriteProperties![index];
                    return _buildPropertyWidgets(property);
                  },
                ),
    );
  }

  Widget _buildPropertyWidgets(PropertyModel property) {
    return PropertyCard(
      imageUrl: property.photos[0].url,
      title: property.propertyType.name,
      location: property.location.city,
      price: property.price,
      area: property.space.toString(),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              // i think this page name has to be changed
              builder: (_) => PropertyDetailesPage(
                propertyModel: property,
              ),
            )).then((removed) {
          if (removed == true) {
            getFavoriteProperties();
          }
        });
      },
      onRemove: () async {
        final success = await FavoriteService()
            .removePropertyFromFavorite(propertyId: property.id);

        if (success) {
          // تحديث مباشر في الواجهة
          setState(() {
            favoriteProperties!.removeWhere((p) => p.id == property.id);
          });

          // جلب جديد من السيرفر في الخلفية بدون مسح البيانات
          final updatedList = await FavoriteService().getFavoriteProperties();
          setState(() {
            favoriteProperties = updatedList;
          });
        }
      },
    );
  }
}

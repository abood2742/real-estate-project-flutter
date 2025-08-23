import 'package:flutter/material.dart';
import 'package:property_system/client/components/property_cards/property_card.dart';
import 'package:property_system/client/models/property_model.dart';
import 'package:property_system/client/screens/search/resault/property/property_detailes_page.dart';import 'package:property_system/office/services/add_reservation_for_for_sell_service.dart';

class ReservationSell extends StatefulWidget {
  const ReservationSell({super.key});

  @override
  State<ReservationSell> createState() => _ReservationSellPageState();
}

class _ReservationSellPageState extends State<ReservationSell> {
  List<PropertyModel>? reservedProperties;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getReservedProperties();
  }

  Future<void> getReservedProperties() async {
    reservedProperties = await AddReservationForForSellService().getReservedProperties();

    setState(() {
      isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : (reservedProperties == null || reservedProperties!.isEmpty)
              ? const Center(child: Text("لا يوجد عقارات محجوزة للبيع"))
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: reservedProperties!.length,
                  itemBuilder: (context, index) {
                    final property = reservedProperties![index];
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
              builder: (_) => PropertyDetailesPage(
                propertyModel: property,
              ),
            )).then((removed) {
          if (removed == true) {
            getReservedProperties();
          }
        });
      },
      onRemove: () async {
        final success = await AddReservationForForSellService()
            .removePropertyFromReservation(propertyId: property.id);

        if (success) {
          setState(() {
            reservedProperties!.removeWhere((p) => p.id == property.id);
          });

          final updatedList =
              await AddReservationForForSellService().getReservedProperties();
          setState(() {
            reservedProperties = updatedList;
          });
        }
      },
    );
  }
}

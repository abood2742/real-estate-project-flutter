import 'package:flutter/material.dart';
import 'package:property_system/client/components/property_cards/property_card.dart';
import 'package:property_system/client/models/property_model.dart';
import 'package:property_system/client/services/get_and_delet_reservation_of_client_service.dart';

class ClientReservedPropertyForSellPage1 extends StatefulWidget{
  @override
  State<ClientReservedPropertyForSellPage1> createState() => _ClientReservedPropertyForSellPage1State();
}


class _ClientReservedPropertyForSellPage1State
    extends State<ClientReservedPropertyForSellPage1> {
  List<PropertyModel> reservedProperties = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchReservations();
  }

  Future<void> fetchReservations() async {
    final data = await GetAndDeletReservationOfClientService()
        .getClientReservations("1"); // clientId للتجربة

    setState(() {
      reservedProperties = data ?? [];
      isLoading = false;
    });
  }

  Future<void> removeReservation(String reservationId) async {
    final success = await GetAndDeletReservationOfClientService()
        .deleteClientReservation(reservationId);

    if (success) {
      setState(() {
        reservedProperties.removeWhere((p) => p.id == reservationId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (reservedProperties.isEmpty) {
      return const Center(child: Text("لا يوجد عقارات محجوزة"));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: reservedProperties.length,
      itemBuilder: (context, index) {
        final property = reservedProperties[index];

        return PropertyCard(
          imageUrl: property.photos.isNotEmpty ? property.photos[0].url : null,
          title: property.propertyType.name,
          location: property.location.city,
          price: property.price,
          area: property.space.toString(),
          onRemove: () {
            removeReservation(property.id); // 🗑️ نحذف باستخدام id العقار
          },
        );
      },
    );
  }
}

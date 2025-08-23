import 'package:flutter/material.dart';
import 'package:property_system/client/components/property_cards/property_card.dart';
import 'package:property_system/client/models/property_model.dart';
import 'package:property_system/client/screens/main/more/reserved_properties/client_reserved_property_for_sell_page.dart';
import 'package:property_system/client/services/get_and_delet_reservation_of_client_service.dart';

class _ClientReservedPropertyForSellPageState
    extends State<ClientReservedPropertyForSellPage> {
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

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:property_system/client/components/property_cards/property_card.dart';
import 'package:property_system/client/models/property_model.dart';
import 'package:property_system/office/reservation/reserved_property_details.dart';
import 'package:property_system/office/services/office_reservation_service.dart';

class OfficeReservationPage extends StatefulWidget {
  const OfficeReservationPage({super.key});

  @override
  State<OfficeReservationPage> createState() => _OfficeReservationPageState();
}

class _OfficeReservationPageState extends State<OfficeReservationPage> {
  List<PropertyModel> propertyModels = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getReservedPropertiesForOffice();
  }

  Future<void> getReservedPropertiesForOffice() async {
    final data =
        await OfficeReservationService().getReservedPropertiesForOffice();
    setState(() {
      propertyModels = data!;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    // تقسيم العقارات حسب نوع العملية
    final sellReservations = propertyModels
        .where((res) => res.typeOperation == 'selling')
        .toList();
    final rentReservations = propertyModels
        .where((res) => res.typeOperation == 'renting')
        .toList();

    Widget buildList(List<PropertyModel> list) {
      if (isLoading) {
        return const Center(child: CircularProgressIndicator());
      }

      if (list.isEmpty) {
        return Center(
          child: Text(
            'لا توجد عقارات محجوزة',
            style: const TextStyle(fontSize: 16),
          ),
        );
      }

      return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          final res = list[index];
          final property = res;
          return PropertyCard(
            title: property.propertyType.name,
            location:
                property.location.city, // Assuming location object has name
            price: property.price,
            area: property.space.toString(),
            imageUrl:
                property.photos.isNotEmpty ? property.photos[0].url : null,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ReservedPropertyDetailsPage(propertyModel: property,),
                ),
              );
            },
          );
        },
      );
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 79, 142, 147),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'حجز عقار',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Lottie.asset(
                'assets/Reservation.json',
                height: 70,
                width: 70,
                repeat: true,
                animate: true,
              ),
            ],
          ),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: 'للبيع'),
              Tab(text: 'للإيجار'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildList(sellReservations),
            buildList(rentReservations),
          ],
        ),
      ),
    );
  }
}

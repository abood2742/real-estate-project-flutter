import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:property_system/client/components/property_cards/property_card.dart';
import 'package:property_system/client/models/property_model.dart';
import 'package:property_system/client/reservation%20_for_client/client_reserved_property_page.dart';
import 'package:property_system/client/services/client_reservation_service_done.dart';

class ClientReservationPage extends StatefulWidget {
  const ClientReservationPage({super.key});

  @override
  State<ClientReservationPage> createState() => _ClientReservationPageState();
}

class _ClientReservationPageState extends State<ClientReservationPage> {
  List<PropertyModel> propertyModels = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getReservedPropertiesForClient();
  }

  Future<void> getReservedPropertiesForClient() async {
    final data = await ClientReservationService().getClientReservedProperties();
    print("object");
    setState(() {
      propertyModels = data!;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // تقسيم العقارات حسب نوع العملية
    final sellReservations =
        propertyModels.where((res) => res.typeOperation == 'selling').toList();
    final rentReservations =
        propertyModels.where((res) => res.typeOperation == 'renting').toList();

    Widget buildList(List<PropertyModel> list) {
      if (isLoading) {
        return const Center(child: CircularProgressIndicator());
      }

      if (list.isEmpty) {
        return Center(
          child: Text(
            'لم تحجز عقارات بعد',
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
                  builder: (_) => ClientReservedPropertyDetailsPage(
                    propertyModel: property,
                  ),
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
                'العقارات التي حجزتها',
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

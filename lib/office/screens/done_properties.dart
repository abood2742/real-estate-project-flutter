import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:property_system/client/components/property_cards/property_card.dart';
import 'package:property_system/client/models/property_model.dart';
import 'package:property_system/client/screens/search/resault/property/Property_Details_Page.dart';
import 'package:property_system/office/services/office_properties.dart';
import 'package:property_system/l10n/app_localizations.dart';

class OfficeDonePropertiesPage extends StatefulWidget {
  const OfficeDonePropertiesPage({super.key});

  @override
  State<OfficeDonePropertiesPage> createState() => _OfficeDonePropertiesPageState();
}

class _OfficeDonePropertiesPageState extends State<OfficeDonePropertiesPage> {
  List<PropertyModel> propertyModels = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getReservedPropertiesForOffice();
  }

  Future<void> getReservedPropertiesForOffice() async {
    final data =
        await OfficeProperties().getDonePropertiesForOffice();
    setState(() {
      propertyModels = data!;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    // تقسيم العقارات حسب نوع العملية
    final soldProperties = propertyModels
        .where((res) => res.typeOperation == 'selling')
        .toList();
    final rentedProperties = propertyModels
        .where((res) => res.typeOperation == 'renting')
        .toList();

    Widget buildList(List<PropertyModel> list) {
      if (isLoading) {
        return const Center(child: CircularProgressIndicator());
      }

      if (list.isEmpty) {
        return Center(
          child: Text(
            localizations.translate('no_completed_properties'),
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
                  builder: (_) => PropertyDetailsPage(propertyModel: property,),
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
          backgroundColor: const Color.fromARGB(255, 68, 137, 255),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                localizations.translate('completed_properties'),
                style: const TextStyle(fontSize: 20, color: Colors.white),
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
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: localizations.translate('sold')),
              Tab(text: localizations.translate('rented')),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildList(soldProperties),
            buildList(rentedProperties),
          ],
        ),
      ),
    );
  }
}

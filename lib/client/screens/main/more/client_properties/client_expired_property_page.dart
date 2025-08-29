import 'package:flutter/material.dart';
import 'package:property_system/client/components/expired_components.dart';
import 'package:property_system/client/models/client_done_Properties.dart';
import 'package:property_system/client/screens/search/resault/property/Property_Details_Page.dart';
import 'package:property_system/client/services/client_done_properties.dart';
import 'package:property_system/l10n/app_localizations.dart';

class ClientExpiredPropertyPage extends StatefulWidget {
  const ClientExpiredPropertyPage({super.key});

  @override
  State<ClientExpiredPropertyPage> createState() =>
      _ClientExpiredPropertyPageState();
}

class _ClientExpiredPropertyPageState extends State<ClientExpiredPropertyPage> {
  List<ClientDoneProperties> properties = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getAllUserProperties();
  }

  Future<void> getAllUserProperties() async {
    final fetchedProperties =
        await ClientDonePropertiesService().getAllUserProperties();
    setState(() {
      properties = fetchedProperties ?? [];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    // تقسيم العقارات حسب نوع العملية
    final buyProperties = properties
        .where((p) => p.propertyModel.typeOperation.toLowerCase() == 'selling')
        .toList();
    final rentProperties = properties
        .where((p) => p.propertyModel.typeOperation.toLowerCase() == 'renting')
        .toList();

    Widget buildGrid(List<ClientDoneProperties> list) {
      if (isLoading) {
        return const Center(child: CircularProgressIndicator());
      }

      if (list.isEmpty) {
        return Center(
          child: Text(
            localizations.translate('no_properties_found'),
            style: const TextStyle(fontSize: 16),
          ),
        );
      }

      final screenWidth = MediaQuery.of(context).size.width;

      // ضبط عدد الأعمدة حسب حجم الشاشة
      int crossAxisCount = 2;
      if (screenWidth > 1200) {
        crossAxisCount = 4;
      } else if (screenWidth > 800) {
        crossAxisCount = 3;
      }

      // ضبط نسبة الطول/العرض للبطاقات
      double childAspectRatio = 0.7;
      if (screenWidth < 400) {
        childAspectRatio = 0.65;
      } else if (screenWidth > 1200) {
        childAspectRatio = 0.75;
      }

      return GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: childAspectRatio,
        ),
        itemCount: list.length,
        itemBuilder: (context, index) {
          final property = list[index];
          return ExpiredComponents(
            property: property,
            onTap: () {
              Navigator.push(
            context,
            MaterialPageRoute(
              // i think this page name has to be changed
              builder: (_) => PropertyDetailsPage(
                propertyModel: property.propertyModel,
              ),
            ));
            },
          );
        },
      );
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF3D60C6),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                localizations.translate('your_expired_properties'),
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontFamily: 'Pacifico',
                ),
              ),
            ],
          ),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: localizations.translate('properties_for_sale')),
              Tab(text: localizations.translate('properties_for_rent')),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildGrid(buyProperties),
            buildGrid(rentProperties),
          ],
        ),
      ),
    );
  }
}

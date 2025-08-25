import 'package:flutter/material.dart';
import 'package:property_system/client/components/office_cards/office_card.dart';
import 'package:property_system/client/models/office_details_model.dart';
import 'package:property_system/client/screens/search/resault/office/Office_Details_Page.dart';
import 'package:property_system/client/services/favorite_service.dart';

class FavoriteOfficesPage extends StatefulWidget {
  const FavoriteOfficesPage({super.key});

  @override
  State<FavoriteOfficesPage> createState() => _FavoriteOfficesPageState();
}

class _FavoriteOfficesPageState extends State<FavoriteOfficesPage> {
  List<OfficeDetailsModel>? favoriteOffices;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getFavoriteOffices();
  }

  Future<void> getFavoriteOffices() async {
    favoriteOffices = await FavoriteService().getFavoriteOffices();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : (favoriteOffices == null || favoriteOffices!.isEmpty)
              ? const Center(child: Text("لا يوجد مكاتب محفوظة",style: TextStyle(color: Colors.blue,fontFamily: 'Pacifico'),))
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: favoriteOffices!.length,
                  itemBuilder: (context, index) {
                    final office = favoriteOffices![index];
                    return _buildOfficeWidgets(office);
                  },
                ),
    );
  }

  Widget _buildOfficeWidgets(OfficeDetailsModel office) {
    return OfficeCard(
      name: office.name,
      phone: office.officePhone,
      imageUrl: office.officePhoto != null ? office.officePhoto!.url : 'null',
      rating: office.ratings ?? 0,
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              // i think this page name has to be changed
              builder: (_) => OfficeDetailsPage(officeId: office.id),
            )).then((removed) {
          if (removed == true) {
            getFavoriteOffices();
          }
        });
      },
      onRemove: () async {
        final success = await FavoriteService()
            .removeOfficeFromFavorite(officeId: office.id);

        if (success) {
          // تحديث مباشر في الواجهة
          setState(() {
            favoriteOffices!.removeWhere((o) => o.id == office.id);
          });

          // جلب جديد من السيرفر في الخلفية بدون مسح البيانات
          final updatedList = await FavoriteService().getFavoriteOffices();
          setState(() {
            favoriteOffices = updatedList;
          });
        }
      },
    );
  }
}

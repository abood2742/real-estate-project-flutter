import 'package:flutter/material.dart';
import 'package:property_system/client/components/custom_buttons/build_stars.dart';
import 'package:property_system/client/models/office_details_model.dart';
import 'package:property_system/client/services/favorite_office_service.dart';
import 'package:property_system/client/services/search_service.dart';
import 'package:property_system/utils/Office_Page_State_enum.dart';

// the name of this page i think need to be changed
// look at SavedOfficesPage page to understand
class OfficePageInSearchListPage extends StatefulWidget {
  final String officeId;
  const OfficePageInSearchListPage({super.key, required this.officeId});

  @override
  State<OfficePageInSearchListPage> createState() =>
      _OfficePageInSearchListPageState();
}

class _OfficePageInSearchListPageState
    extends State<OfficePageInSearchListPage> {
  OfficePageState pageState = OfficePageState.loading;
  OfficeDetailsModel? officeDetailsModel;

  @override
  void initState() {
    super.initState();
    getOneOffice();
  }

  Future<void> getOneOffice() async {
    try {
      officeDetailsModel =
          await SearchService().getOneOffice(officeId: widget.officeId);

      if (officeDetailsModel != null) {
        setState(() {
          pageState = OfficePageState.success;
        });
      } else {
        setState(() {
          pageState = OfficePageState.error;
        });
      }
    } catch (e) {
      setState(() {
        pageState = OfficePageState.error;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'معلومات المكتب',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          if (pageState == OfficePageState.success)
            IconButton(
              icon: Icon(
                officeDetailsModel!.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: officeDetailsModel!.isFavorite
                    ? const Color(0xFF1565C0)
                    : Colors.grey,
              ),
              onPressed: () async {
                final newStatus = !officeDetailsModel!.isFavorite;
                setState(() {
                  officeDetailsModel!.isFavorite = newStatus;
                });

                if (newStatus) {
                  await FavoriteOfficeService()
                      .addOfficeToFavorite(officeId: officeDetailsModel!.id);
                } else {
                  await FavoriteOfficeService().removeOfficeFromFavorite(
                      officeId: officeDetailsModel!.id);
                }
              },
            )
        ],
      ),
      body: Builder(
        builder: (_) {
          switch (pageState) {
            case OfficePageState.loading:
              return const Center(child: CircularProgressIndicator());

            case OfficePageState.error:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, color: Colors.red, size: 48),
                    const SizedBox(height: 8),
                    const Text('حدث خطأ أثناء تحميل البيانات'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: getOneOffice,
                      child: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              );

            case OfficePageState.success:
              return _buildOfficeDetails();
          }
        },
      ),
    );
  }

  Widget _buildOfficeDetails() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              officeDetailsModel!.officePhoto.url,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            officeDetailsModel!.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF304266),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          RatingStarsWidget(rating: officeDetailsModel!.rating),
          const SizedBox(height: 16),
          _buildInfoCard(
            icon: Icons.web,
            title: 'البريد الإلكتروني',
            subtitle: officeDetailsModel!.officeEmail,
          ),
          _buildInfoCard(
            icon: Icons.phone,
            title: 'رقم الهاتف',
            subtitle: officeDetailsModel!.officePhone,
          ),
          _buildInfoCard(
            icon: Icons.description,
            title: 'رقم الرخصة',
            subtitle: officeDetailsModel!.licenseNumber,
          ),
          _buildInfoCard(
            icon: Icons.badge,
            title: 'الرقم الوطني',
            subtitle: officeDetailsModel!.personalIdentityNumber,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => Dialog(
                  child: Image.network(officeDetailsModel!.licensePhoto.url),
                ),
              );
            },
            icon: const Icon(Icons.image),
            label: const Text('عرض صورة الترخيص'),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
      {required IconData icon,
      required String title,
      required String subtitle}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
      ),
    );
  }
}

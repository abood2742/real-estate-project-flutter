import 'package:flutter/material.dart';
import 'package:property_system/client/components/custom_buttons/build_stars.dart';
import 'package:property_system/client/models/office_details_model.dart';
import 'package:property_system/client/screens/search/comments/Add_Comment_And_Rating_Page.dart';
import 'package:property_system/client/screens/search/comments/Comments_Page.dart';
import 'package:property_system/client/services/favorite_office_service.dart';
import 'package:property_system/client/services/search_service.dart';
import 'package:property_system/utils/Office_Page_State_enum.dart';

class OfficePageInSearchListPage extends StatefulWidget {
  final String officeId;
  const OfficePageInSearchListPage({super.key, required this.officeId});

  @override
  State<OfficePageInSearchListPage> createState() =>
      _OfficePageInSearchListPageState();
}

class _OfficePageInSearchListPageState
    extends State<OfficePageInSearchListPage> {
  PagesState pageState = PagesState.loading;
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
        setState(() => pageState = PagesState.success);
      } else {
        setState(() => pageState = PagesState.error);
      }
    } catch (e) {
      setState(() => pageState = PagesState.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('معلومات المكتب'),
        actions: [
          if (pageState == PagesState.success)
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
                setState(() => officeDetailsModel!.isFavorite = newStatus);
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
            case PagesState.loading:
              return const Center(child: CircularProgressIndicator());
            case PagesState.error:
              return _buildError();
            case PagesState.success:
              return _buildOfficeDetails();
          }
        },
      ),
    );
  }

  Widget _buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, color: Colors.red, size: 48),
          const SizedBox(height: 8),
          const Text('حدث خطأ أثناء تحميل البيانات'),
          const SizedBox(height: 16),
          ElevatedButton(
              onPressed: getOneOffice, child: const Text('إعادة المحاولة')),
        ],
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
          RatingStarsWidget(rating: officeDetailsModel!.ratings),
          const SizedBox(height: 16),
          _buildInfoCard(
              Icons.web, 'البريد الإلكتروني', officeDetailsModel!.officeEmail),
          _buildInfoCard(
              Icons.phone, 'رقم الهاتف', officeDetailsModel!.officePhone),
          _buildInfoCard(Icons.description, 'رقم الرخصة',
              officeDetailsModel!.licenseNumber),
          _buildInfoCard(Icons.badge, 'الرقم الوطني',
              officeDetailsModel!.personalIdentityNumber),
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
          const SizedBox(height: 20),
          // الزر الجديد - إضافة تقييم
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddCommentAndRatingPage(officeId: widget.officeId,),
                ),
              );
            },
            icon: const Icon(Icons.rate_review),
            label: const Text('إضافة تعليق وتقييم'),
          ),
          const SizedBox(height: 10),
          // الزر الجديد - عرض كل التعليقات
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CommentsPage(officeId: officeDetailsModel!.id,),
                ),
              );
            },
            icon: const Icon(Icons.comment),
            label: const Text('عرض كل التعليقات'),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String subtitle) {
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

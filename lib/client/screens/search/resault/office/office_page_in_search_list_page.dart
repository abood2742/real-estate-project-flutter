import 'package:flutter/material.dart';
import 'package:property_system/client/components/custom_buttons/build_stars.dart';
import 'package:property_system/client/models/office_details_model.dart';
import 'package:property_system/client/services/search_service.dart';

class OfficePageInSearchListPage extends StatefulWidget {
  final String officeId;
  const OfficePageInSearchListPage({super.key, required this.officeId});

  @override
  State<OfficePageInSearchListPage> createState() =>
      _OfficePageInSearchListPageState();
}

class _OfficePageInSearchListPageState
    extends State<OfficePageInSearchListPage> {
  bool isFavorite = false;
  OfficeDetailsModel? officeDetailsModel;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getOneOffice();
  }

  Future<void> getOneOffice() async {
    officeDetailsModel =
        await SearchService().getOneOffice(officeId: widget.officeId);
    setState(() {
      isLoading = false;
    });
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'معلومات المكتب',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.star : Icons.star_border,
              color: isFavorite ? Colors.blue : Colors.grey,
            ),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
          )
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // صورة المكتب
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

                  // اسم المكتب والتقييم
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

                  RatingStarsWidget(rating: officeDetailsModel!.ratingsCount),

                  const SizedBox(height: 16),

                  // معلومات المكتب
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
                      // عرض صورة الترخيص
                      showDialog(
                        context: context,
                        builder: (_) => Dialog(
                          child: Image.network(
                              officeDetailsModel!.licensePhoto.url),
                        ),
                      );
                    },
                    icon: const Icon(Icons.image),
                    label: const Text('عرض صورة الترخيص'),
                  ),
                ],
              ),
            ),
    );
  }
}


// return Scaffold(
//       appBar: AppBar(
//         elevation: sqrt1_2,
//         title: const Text(
//           'معلومات المكتب ',
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'Pacifico',
//             color: Color.fromARGB(255, 48, 66, 102),
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(
//               isFavorite ? Icons.star : Icons.star_border,
//               color: isFavorite ? Colors.blue : Colors.grey,
//             ),
//             onPressed: () {
//               setState(() {
//                 isFavorite = !isFavorite;
//               });
//             },
//           ),
//         ],
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           CardInfoComponents(
//             name: 'اسم المكتب',
//             nameName: 'مكتب التقى العقاري',
//           ),
//           SizedBox(height: 20),
//           CardInfoComponents(
//             name: 'الموقع',
//             nameName: 'دمشق، دمر، شارع فلسطين',
//           ),
//           SizedBox(height: 20),
//           CardInfoComponents(
//             name: 'رقم الهاتف',
//             nameName: '+963 11 1234567',
//           ),
//           SizedBox(height: 20),
//           CardInfoComponents(
//             name: 'البريد الإلكتروني',
//             nameName: 'info@altaqaa-realestate.com',
//           ),
//           SizedBox(height: 20),
//           CardInfoComponents(
//             name: 'ساعات العمل',
//             nameName: 'الأحد - الخميس 9 صباحًا - 6 مساءً',
//           ),
//           SizedBox(height: 20),
//           CardInfoComponents(
//             name: 'تاريخ التأسيس',
//             nameName: '2005',
//           ),
//           SizedBox(height: 20),
//           CardInfoComponents(
//             name: 'نوع الخدمات',
//             nameName: 'بيع وتأجير العقارات السكنية والتجارية',
//           ),
//           SizedBox(height: 20),
//           CardInfoComponents(
//             name: 'عدد الموظفين',
//             nameName: '12 موظف',
//           ),
//           SizedBox(height: 20),
//           CardInfoComponents(
//             name: 'الموقع الإلكتروني',
//             nameName: 'www.altaqaa-realestate.com',
//           ),
//           SizedBox(height: 20),
//           CardInfoComponents(
//             name: 'وسائل التواصل الاجتماعي',
//             nameName: 'فيسبوك، انستجرام، تويتر',
//           ),
//           SizedBox(height: 20),
//           CardInfoComponents(
//             name: 'رئيس المكتب',
//             nameName: 'محمد علي',
//           ),
//           SizedBox(height: 20),
//           CardInfoComponents(
//             name: 'رخصة المكتب',
//             nameName: '123456789',
//           ),
//           SizedBox(height: 20),
//           CardInfoComponents(
//             name: 'ملاحظات',
//             nameName: 'يوجد مواقف سيارات خاصة للعملاء',
//           ),
//         ],
//       ),
//     );
//   }
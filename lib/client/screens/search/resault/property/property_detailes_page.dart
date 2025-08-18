import 'package:flutter/material.dart';
import 'package:property_system/client/models/property_model.dart';
import 'package:property_system/client/screens/search/resault/office/Office_Detailes_Page.dart';
import 'package:property_system/client/screens/search/reservation/Property_reservation.dart';
import 'package:property_system/client/screens/search/map/map_page.dart';
import 'package:property_system/client/screens/search/comments/Add_Comment_And_Rating_Page.dart';
import 'package:property_system/client/screens/report/report_post_page.dart';
import 'package:property_system/client/services/favorite_service.dart';
// import 'package:property_system/client/screens/office/office_profile_page.dart'; // <-- صفحة المكتب

class PropertyDetailesPage extends StatefulWidget {
  final PropertyModel propertyModel;
  const PropertyDetailesPage({super.key, required this.propertyModel});

  @override
  State<PropertyDetailesPage> createState() => _PropertyDetailesPageState();
}

class _PropertyDetailesPageState extends State<PropertyDetailesPage> {

  @override
  void initState() {
    super.initState();
    chechIfPropertyIsFavorite();
  }

  Future<void> chechIfPropertyIsFavorite() async {
    try {
      
      widget.propertyModel.isFavorite = await FavoriteService()
          .chechIfPropertyIsFavorite(propertyId: widget.propertyModel.id);
      // if (officeDetailsModel != null) {
      //   setState(() => pageState = PagesState.success);
      // } else {
      //   setState(() => pageState = PagesState.error);
      // }
    } catch (e) {
      //setState(() => pageState = PagesState.error);
      print('Exception in property page: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final property = widget.propertyModel;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'تفاصيل العقار',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Pacifico',
              color: Color.fromARGB(255, 48, 66, 102),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                widget.propertyModel.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: widget.propertyModel.isFavorite ? Colors.blue : Colors.grey,
              ),
              onPressed: () async{
                  final newStatus = !widget.propertyModel.isFavorite;
                  setState(() => widget.propertyModel.isFavorite = newStatus);
                  if (newStatus) {
                    await FavoriteService().addPropertyToFavorite(
                        propertyId: widget.propertyModel.id);
                  } else {
                    await FavoriteService().removePropertyFromFavorite(
                        propertyId: widget.propertyModel.id);
                  }
              },
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            /// صورة العقار الرئيسية
            PropertyImagesGallery(
              mainImage: property.photos.isNotEmpty
                  ? property.photos.first.url
                  : 'assets/images/pic3.jpg',
              extraImages: property.photos.length > 1
                  ? property.photos.skip(1).map((e) => e.url).toList()
                  : [],
            ),

            const SizedBox(height: 12),

            /// السعر والموقع
            Row(
              children: [
                Text(
                  '${property.price} \$',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                const Icon(Icons.location_pin, color: Colors.blue),
                const SizedBox(width: 4),
                Expanded(
                  flex: 0,
                  child: Text(
                    property.location.city,
                    style: const TextStyle(fontFamily: 'Pacifico'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            /// زر عرض على الخريطة
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                icon: const Icon(Icons.map, color: Colors.white),
                label: const Text(
                  'عرض على الخريطة',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontFamily: 'Pacifico'),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => MapPage()),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            /// وصف العقار
            const Text(
              'الوصف',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
                fontFamily: 'Pacifico',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              property.description,
              textAlign: TextAlign.right,
              style: const TextStyle(height: 1.6),
            ),
            const SizedBox(height: 24),

            /// 🔹 داخل body بعد الوصف مباشرة
            const Text(
              'معلومات العقار',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
                fontFamily: 'Pacifico',
              ),
            ),
            const SizedBox(height: 8),

            Card(
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.numbers),
                    title: const Text('رقم العقار'),
                    subtitle: Text(property.propertyNumber),
                  ),
                  ListTile(
                    leading: const Icon(Icons.category),
                    title: const Text('نوع العقار'),
                    subtitle: Text(property.propertyType.name),
                  ),
                  ListTile(
                    leading: const Icon(Icons.swap_horiz),
                    title: const Text('نوع العملية'),
                    subtitle: Text(property.typeOperation),
                  ),
                  ListTile(
                    leading: const Icon(Icons.straighten),
                    title: const Text('المساحة'),
                    subtitle: Text('${property.space} م²'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.date_range),
                    title: const Text('تاريخ النشر'),
                    subtitle: Text(
                      '${property.publishDate.toLocal()}'.split(' ')[0],
                    ),
                  ),
                ],
              ),
            ),

            /// 🔹 تفاصيل الترخيص
            const SizedBox(height: 16),
            const Text(
              'تفاصيل الترخيص',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
                fontFamily: 'Pacifico',
              ),
            ),
            const SizedBox(height: 8),

            Card(
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.badge),
                    title: const Text('رقم الترخيص'),
                    subtitle: Text(property.licenseDetails.licenseNumber),
                  ),
                  ListTile(
                    leading: const Icon(Icons.business),
                    title: const Text('اسم المكتب'),
                    subtitle: Text(property.office.officeName),
                  ),
                  ListTile(
                    leading: const Icon(Icons.date_range),
                    title: const Text('تاريخ الترخيص'),
                    subtitle: Text(
                      '${property.licenseDetails.date.toLocal()}'.split(' ')[0],
                    ),
                  ),
                ],
              ),
            ),

            /// 🔹 الخصائص Attributes (ديناميكي)
            const SizedBox(height: 16),
            const Text(
              'خصائص العقار',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
                fontFamily: 'Pacifico',
              ),
            ),
            const SizedBox(height: 8),

            if (property.propertyAttributes.isNotEmpty)
              Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: Column(
                  children: property.propertyAttributes.map((attr) {
                    return ListTile(
                      leading: const Icon(Icons.check_circle_outline),
                      title: Text(attr.attribute.name),
                      subtitle: Text(attr.value),
                    );
                  }).toList(),
                ),
              )
            else
              const Text('لا توجد خصائص مسجلة'),

            const SizedBox(height: 12),
          ],
        ),

        /// ✅ الأزرار بأسفل الشاشة
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const PropertyReservation()));
                  },
                  icon: const Icon(Icons.book_online),
                  label: const Text('حجز العقار'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                const AddCommentAndRatingPage(officeId: '')));
                  },
                  icon: const Icon(Icons.star_rate, color: Colors.white),
                  label: const Text(
                    'تقييم',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ReportPostPage()));
                },
                icon: const Icon(Icons.report, color: Colors.red),
              ),
            ],
          ),
        ),

        // ✅ زر بروفايل المكتب باستخدام OfficeOfProperty
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => OfficeDetailesPage(
                  officeId: property.office.officeId,
                ),
              ),
            );
          },
          icon: property.office.officePhoto != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    property.office.officePhoto!.url,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                )
              : const Icon(Icons.business),
          label: Text(property.office.officeName),
        ),
      ),
    );
  }
}

/// ✅ Scroll أفقي للصور (الصورة الأساسية + باقي الصور)
class PropertyImagesGallery extends StatelessWidget {
  final String mainImage;
  final List<String> extraImages;

  const PropertyImagesGallery({
    super.key,
    required this.mainImage,
    required this.extraImages,
  });

  @override
  Widget build(BuildContext context) {
    final allImages = [mainImage, ...extraImages]; // دمج الأساسي مع الإضافي

    return SizedBox(
      height: 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: allImages.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => FullImageView(imageUrl: allImages[index])),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                allImages[index],
                width: 300, // الصورة أكبر شوي
                height: 220,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}

/// ✅ عرض الصورة بالحجم الكامل
class FullImageView extends StatelessWidget {
  final String imageUrl;
  const FullImageView({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: InteractiveViewer(
            child: Image.network(imageUrl),
          ),
        ),
      ),
    );
  }
}

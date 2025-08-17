import 'package:flutter/material.dart';
import 'package:property_system/client/models/property_model.dart';
import 'package:property_system/client/screens/search/reservation/Property_reservation.dart';
import 'package:property_system/client/screens/search/map/map_page.dart';
import 'package:property_system/client/screens/search/comments/Add_Comment_And_Rating_Page.dart';
import 'package:property_system/client/screens/report/report_post_page.dart';
// import 'package:property_system/client/screens/office/office_profile_page.dart'; // <-- صفحة المكتب

class PropertyDetailesPage extends StatefulWidget {
  final PropertyModel propertyModel;
  const PropertyDetailesPage({super.key, required this.propertyModel});

  @override
  State<PropertyDetailesPage> createState() => _PropertyDetailesPageState();
}

class _PropertyDetailesPageState extends State<PropertyDetailesPage> {
  bool isFavorite = false;

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
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.blue : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
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
                      fontSize: 14, color: Colors.white, fontFamily: 'Pacifico'),
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

            
            const SizedBox(height: 12),
            const SizedBox(height: 24),
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

        /// ✅ زر بروفايل المكتب
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // TODO: هنا تستدعي صفحة المكتب
            // Navigator.push(context, MaterialPageRoute(builder: (_) => OfficeProfilePage(officeId: property.licenseDetails.license.id)));
          },
          icon: const Icon(Icons.business),
          label: Text(property.licenseDetails.license.name),
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

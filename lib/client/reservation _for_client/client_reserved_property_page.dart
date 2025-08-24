import 'package:flutter/material.dart';
import 'package:property_system/client/models/property_model.dart';
import 'package:property_system/client/screens/search/map/map_page.dart';
import 'package:property_system/client/screens/search/resault/office/Office_Detailes_Page.dart';

class ClientReservedPropertyDetailsPage extends StatefulWidget {
  final PropertyModel propertyModel;
  const ClientReservedPropertyDetailsPage({super.key, required this.propertyModel});

  @override
  State<ClientReservedPropertyDetailsPage> createState() => _ClientReservedPropertyDetailsPageState();
}

class _ClientReservedPropertyDetailsPageState extends State<ClientReservedPropertyDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final property = widget.propertyModel;
    final reservation = property.reservationModel; // قد يكون null

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
        ),
        body: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            PropertyImagesGallery(
              mainImage: property.photos.isNotEmpty ? property.photos.first.url : 'assets/images/pic3.jpg',
              extraImages: property.photos.length > 1 ? property.photos.skip(1).map((e) => e.url).toList() : [],
            ),
            const SizedBox(height: 12),

            // السعر والموقع
            Row(
              children: [
                Text('${property.price} \$', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Spacer(),
                const Icon(Icons.location_pin, color: Colors.blue),
                const SizedBox(width: 4),
                Text(property.location.city, style: const TextStyle(fontFamily: 'Pacifico')),
              ],
            ),
            const SizedBox(height: 16),

            // زر عرض على الخريطة
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                icon: const Icon(Icons.map, color: Colors.white),
                label: const Text('عرض على الخريطة',
                    style: TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'Pacifico')),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => MapPage()));
                },
              ),
            ),
            const SizedBox(height: 16),

            // وصف العقار
            const Text('الوصف',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent, fontFamily: 'Pacifico')),
            const SizedBox(height: 8),
            Text(property.description, textAlign: TextAlign.right, style: const TextStyle(height: 1.6)),
            const SizedBox(height: 24),

            // معلومات العقار
            const Text('معلومات العقار',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent, fontFamily: 'Pacifico')),
            const SizedBox(height: 8),
            Card(
              child: Column(
                children: [
                  ListTile(leading: const Icon(Icons.numbers), title: const Text('رقم العقار'), subtitle: Text(property.propertyNumber)),
                  ListTile(leading: const Icon(Icons.category), title: const Text('نوع العقار'), subtitle: Text(property.propertyType.name)),
                  ListTile(leading: const Icon(Icons.swap_horiz), title: const Text('نوع العملية'), subtitle: Text(property.typeOperation)),
                  ListTile(leading: const Icon(Icons.straighten), title: const Text('المساحة'), subtitle: Text('${property.space} م²')),
                  ListTile(
                    leading: const Icon(Icons.date_range),
                    title: const Text('تاريخ النشر'),
                    subtitle: Text('${property.publishDate.toLocal()}'.split(' ')[0]),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            const Text('تفاصيل الحجز',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent, fontFamily: 'Pacifico')),
            const SizedBox(height: 8),

            // تفاصيل الحجز مع null-safety
            if (reservation != null)
              Card(
                child: Column(
                  children: [
                    ListTile(
                        leading: const Icon(Icons.date_range),
                        title: const Text('تاريخ الحجز'),
                        subtitle: Text(reservation.reservation_date)),
                    ListTile(
                        leading: const Icon(Icons.attach_money),
                        title: const Text('المبلغ المدفوع'),
                        subtitle: Text('${reservation.amount_paid } \$')),
                    ListTile(
                        leading: const Icon(Icons.verified),
                        title: const Text('حالة الحجز'),
                        subtitle: Text(reservation.reservation_status ? 'مؤكد' : 'قيد الانتظار')),
                    ListTile(
                        leading: const Icon(Icons.timer_off),
                        title: const Text('تاريخ الانتهاء'),
                        subtitle: Text(reservation.expires_at)),
                  ],
                ),
              )
            else
              const Text('لا يوجد حجز مسجل لهذا العقار'),

            const SizedBox(height: 16),
            const Text('خصائص العقار',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent, fontFamily: 'Pacifico')),
            const SizedBox(height: 8),
            if (property.propertyAttributes.isNotEmpty)
              Card(
                child: Column(
                  children: property.propertyAttributes
                      .map((attr) => ListTile(
                            leading: const Icon(Icons.check_circle_outline),
                            title: Text(attr.attribute.name),
                            subtitle: Text(attr.value.toString()),
                          ))
                      .toList(),
                ),
              )
            else
              const Text('لا توجد خصائص مسجلة'),

            const SizedBox(height: 12),
          ],
        ),

        // زر ينقل لصفحة المكتب الذي نشر العقار
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => OfficeDetailesPage(officeId: property.office.officeId),
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
                    errorBuilder: (_, __, ___) => const Icon(Icons.business),
                  ),
                )
              : const Icon(Icons.business),
          label: Text(property.office.officeName),
        ),

        // شريط أزرار أسفل الشاشة
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    // استدعاء API لإلغاء الحجز
                  },
                  icon: const Icon(Icons.cancel, color: Colors.white),
                  label: const Text('إلغاء الحجز', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Scroll أفقي للصور
class PropertyImagesGallery extends StatelessWidget {
  final String mainImage;
  final List<String> extraImages;
  const PropertyImagesGallery({super.key, required this.mainImage, required this.extraImages});

  @override
  Widget build(BuildContext context) {
    final allImages = [mainImage, ...extraImages];
    return SizedBox(
      height: 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: allImages.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => FullImageView(imageUrl: allImages[index])));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                allImages[index],
                width: 300,
                height: 220,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Image.asset('assets/images/pic3.jpg', fit: BoxFit.cover),
              ),
            ),
          );
        },
      ),
    );
  }
}

class FullImageView extends StatelessWidget {
  final String imageUrl;
  const FullImageView({super.key, required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(child: InteractiveViewer(child: Image.network(imageUrl))),
      ),
    );
  }
}

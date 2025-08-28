import 'package:flutter/material.dart';
import 'package:property_system/client/models/property_model.dart';
import 'package:property_system/client/screens/search/map/map_page.dart';
import 'package:property_system/client/screens/search/resault/office/Office_Details_Page.dart';
import 'package:property_system/client/services/client_reservation_service_done.dart';
import 'package:property_system/client/components/Cancel_Custom_Button.dart';

class ClientReservedPropertyDetailsPage extends StatefulWidget {
  final PropertyModel propertyModel;
  const ClientReservedPropertyDetailsPage(
      {super.key, required this.propertyModel});

  @override
  State<ClientReservedPropertyDetailsPage> createState() =>
      _ClientReservedPropertyDetailsPageState();
}

class _ClientReservedPropertyDetailsPageState
    extends State<ClientReservedPropertyDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final property = widget.propertyModel;
    final reservation = property.reservationModel; // قد يكون null

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.green,
          elevation: 2,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'تفاصيل العقار',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Pacifico',
              color: Color.fromARGB(255, 29, 188, 132),
            ),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            PropertyImagesGallery(
              mainImage: property.photos.isNotEmpty
                  ? property.photos.first.url
                  : 'assets/images/pic3.jpg',
              extraImages: property.photos.length > 1
                  ? property.photos.skip(1).map((e) => e.url).toList()
                  : [],
            ),
            const SizedBox(height: 12),

            // السعر والموقع
            Row(
              children: [
                Text('${property.price} \$',
                    style: const TextStyle(
                        fontFamily: 'Pacifico',
                        color: Color.fromARGB(255, 5, 20, 118),
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                const Spacer(),
                const Icon(Icons.location_pin, color: Colors.grey),
                const SizedBox(width: 4),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(property.location.city,
                      style: const TextStyle(
                          fontFamily: 'Pacifico', color: Colors.lightBlue)),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // زر عرض على الخريطة
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
                label: const Text('عرض على الخريطة',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontFamily: 'Pacifico')),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => MapPage()));
                },
              ),
            ),
            const SizedBox(height: 24),

            // وصف العقار
            const Text('الوصف',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 29, 188, 132),
                    fontFamily: 'Pacifico')),
            const SizedBox(height: 8),
            Text(property.description,
                textAlign: TextAlign.right,
                style: const TextStyle(
                    height: 1.6,
                    color: Colors.lightBlue,
                    fontFamily: 'Pacifico')),
            const SizedBox(height: 40),

            // معلومات العقار
            const Text('معلومات العقار',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 29, 188, 132),
                    fontFamily: 'Pacifico')),
            const SizedBox(height: 8),
            Card(
              color: const Color.fromARGB(255, 189, 228, 255),
              elevation: 1,
              shadowColor: Colors.green,
              child: Column(
                children: [
                  ListTile(
                      leading: const Icon(
                        Icons.numbers,
                        color: Color.fromARGB(255, 16, 147, 105),
                      ),
                      title: const Text(
                        'رقم العقار',
                        style: TextStyle(
                            fontFamily: 'Pacifico', color: Colors.blue),
                      ),
                      subtitle: Text(
                        property.propertyNumber,
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'Pacifico'),
                      )),
                  ListTile(
                      leading: const Icon(
                        Icons.category,
                        color: Color.fromARGB(255, 16, 147, 105),
                      ),
                      title: const Text(
                        'نوع العقار',
                        style: TextStyle(
                            fontFamily: 'Pacifico', color: Colors.blue),
                      ),
                      subtitle: Text(
                        property.propertyType.name,
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'Pacifico'),
                      )),
                  ListTile(
                      leading: const Icon(
                        Icons.swap_horiz,
                        color: Color.fromARGB(255, 16, 147, 105),
                      ),
                      title: const Text(
                        'نوع العملية',
                        style: TextStyle(
                            fontFamily: 'Pacifico', color: Colors.blue),
                      ),
                      subtitle: Text(
                        property.typeOperation,
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'Pacifico'),
                      )),
                  ListTile(
                      leading: const Icon(
                        Icons.space_dashboard,
                        color: Color.fromARGB(255, 16, 147, 105),
                      ),
                      title: const Text(
                        'المساحة',
                        style: TextStyle(
                            fontFamily: 'Pacifico', color: Colors.blue),
                      ),
                      subtitle: Text(
                        '${property.space} م²',
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'Pacifico'),
                      )),
                  ListTile(
                    leading: const Icon(
                      Icons.date_range,
                      color: Color.fromARGB(255, 16, 147, 105),
                    ),
                    title: const Text(
                      'تاريخ النشر',
                      style:
                          TextStyle(fontFamily: 'Pacifico', color: Colors.blue),
                    ),
                    subtitle: Text(
                      '${property.publishDate.toLocal()}'.split(' ')[0],
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'Pacifico'),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            const Text('تفاصيل الحجز',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 29, 188, 132),
                    fontFamily: 'Pacifico')),
            const SizedBox(height: 30),

            // تفاصيل الحجز مع null-safety
            if (reservation != null)
              Card(
                color: const Color.fromARGB(255, 189, 228, 255),
                elevation: 1,
                shadowColor: Colors.green,
                child: Column(
                  children: [
                    ListTile(
                        leading: const Icon(
                          Icons.date_range,
                          color: Color.fromARGB(255, 16, 147, 105),
                        ),
                        title: const Text(
                          'تاريخ الحجز',
                          style: TextStyle(
                              color: Colors.blue, fontFamily: 'Pacifico'),
                        ),
                        subtitle: Text(
                          reservation.reservation_date,
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Pacifico'),
                        )),
                    ListTile(
                        leading: const Icon(
                          Icons.attach_money,
                          color: Color.fromARGB(255, 16, 147, 105),
                        ),
                        title: const Text(
                          'المبلغ المدفوع',
                          style: TextStyle(
                              color: Colors.blue, fontFamily: 'Pacifico'),
                        ),
                        subtitle: Text(
                          '${reservation.amount_paid} \$',
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Pacifico'),
                        )),
                    ListTile(
                        leading: const Icon(
                          Icons.verified,
                          color: Color.fromARGB(255, 16, 147, 105),
                        ),
                        title: const Text(
                          'حالة الحجز',
                          style: TextStyle(
                              color: Colors.blue, fontFamily: 'Pacifico'),
                        ),
                        subtitle: Text(
                          reservation.reservation_status
                              ? 'مؤكد'
                              : 'قيد الانتظار',
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Pacifico'),
                        )),
                    ListTile(
                        leading: const Icon(
                          Icons.timer_off,
                          color: Color.fromARGB(255, 16, 147, 105),
                        ),
                        title: const Text(
                          'تاريخ الانتهاء',
                          style: TextStyle(
                              color: Color.fromARGB(255, 16, 147, 105),
                              fontFamily: 'Pacifico'),
                        ),
                        subtitle: Text(
                          reservation.expires_at,
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Pacifico'),
                        )),
                  ],
                ),
              )
            else
              const Text(
                'لا يوجد حجز مسجل لهذا العقار',
                style: TextStyle(fontFamily: 'Pacifico'),
              ),

            const SizedBox(height: 24),
            const Text('خصائص العقار',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 16, 147, 105),
                    fontFamily: 'Pacifico')),
            const SizedBox(height: 8),
            if (property.propertyAttributes.isNotEmpty)
              Card(
                color: const Color.fromARGB(255, 189, 228, 255),
                elevation: 1,
                shadowColor: Colors.green,
                child: Column(
                  children: property.propertyAttributes
                      .map((attr) => ListTile(
                            leading: const Icon(
                              Icons.check_circle_outline,
                              color: Color.fromARGB(255, 16, 147, 105),
                            ),
                            title: Text(
                              attr.attribute.name,
                              style: TextStyle(
                                color: Colors.blue,
                                fontFamily: 'Pacifico',
                              ),
                            ),
                            subtitle: Text(
                              attr.value.toString(),
                              style: TextStyle(
                                  color: Colors.white, fontFamily: 'Pacifico'),
                            ),
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
          backgroundColor: const Color.fromARGB(255, 4, 70, 125),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    OfficeDetailsPage(officeId: property.office.officeId),
              ),
            );
          },
          icon: property.office.officePhoto != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    property.office.officePhoto!.url,
                    color: Colors.white,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(Icons.business),
                  ),
                )
              : const Icon(
                  Icons.business,
                  color: Colors.white,
                ),
          label: Text(
            property.office.officeName,
            style: TextStyle(color: Colors.white, fontFamily: 'Pacifico'),
          ),
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
              CancelCustomButton(
                onConfirm: () async {
                  await ClientReservationService()
                      .cancelReservedPropertyFromClient(
                    reservationId: widget.propertyModel.reservationModel!.id,
                  );
                },
                snackBarMessage: 'تم حذف الحجز بنجاح', // نص مخصص للـ SnackBar
                buttonLabel: 'إلغاء الحجز', // نص الزر
                title: 'هل تريد بالتأكيد حذف هذا الحجز؟', // نص الديالوج
              )
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
  const PropertyImagesGallery(
      {super.key, required this.mainImage, required this.extraImages});

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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          FullImageView(imageUrl: allImages[index])));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                allImages[index],
                width: 300,
                height: 220,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Image.asset('assets/images/pic3.jpg', fit: BoxFit.cover),
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

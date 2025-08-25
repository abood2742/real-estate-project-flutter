import 'package:flutter/material.dart';

class ClientUserOfficeComplaintCase1 extends StatelessWidget {
  final Map<String, dynamic> complaint;

  ClientUserOfficeComplaintCase1(
      {super.key,
      required this.complaint,
      required this.title,
      required this.contained,
      required this.date,
      required this.name,
      required this.phone,
      required this.post});
  String date, contained, title;
  String name, post, phone;
  @override
  Widget build(BuildContext context) {
    final office = complaint["office"] ?? {};
    final List photos = complaint["officeComplaintPhotos"] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "تفاصيل الشكوى",
          style: TextStyle(color: Colors.white, fontFamily: 'Pacifico'),
        ),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 📝 كرت معلومات الشكوى
              SizedBox(
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(" معلومات الشكوى",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: const Color.fromARGB(255, 25, 46, 151))),
                        const SizedBox(height: 12),
                        Text("العنوان: $title,"),
                        Text("المحتوى: $contained,"),
                        Text("التاريخ: $date,"),
                        const SizedBox(height: 12),
                        if (photos.isNotEmpty) ...[
                          Text("📷 صور الشكوى",
                              style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 160,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: photos.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 8),
                              itemBuilder: (context, index) {
                                final photo = photos[index];
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    photo["url"] ?? "",
                                    width: 220,
                                    height: 160,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      color: Colors.grey[300],
                                      width: 220,
                                      height: 160,
                                      child: const Icon(Icons.broken_image),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 🏢 كرت معلومات المكتب
              SizedBox(
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("🏢 معلومات المكتب",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: const Color.fromARGB(255, 18, 54, 162))),
                        const SizedBox(height: 12),
                        Text("الإسم : $name,"),
                        Text("البريد: $post"),
                        Text("الهاتف: $phone,"),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
           // 🔘 استخدام Stack لإضافة زرين عائمين
      floatingActionButton: Stack(
        children: [
          // زر المكتب في الزاوية اليسرى السفلية
          Positioned(
            bottom: 10,
            left: 16, // الزاوية اليسرى
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        OfficeDetailesPage(officeId: office["id"] ?? ""),
                  ),
                );
              },
              icon: const Icon(Icons.business, color: Colors.white),
              label: Text(
                office["name"] ?? "المكتب",
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Pacifico',
                  fontSize: 16,
                ),
              ),
              backgroundColor: const Color.fromARGB(255, 4, 70, 125),
            ),
          ),
        ])
    );
  }
}
// صفحة المكتب (مثال)
class OfficeDetailesPage extends StatelessWidget {
  final String officeId;
  const OfficeDetailesPage({super.key, required this.officeId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "مكتب $officeId",
          style: const TextStyle(color: Colors.white, fontFamily: 'Pacifico'),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Center(child: Text("تفاصيل المكتب برقم: $officeId")),
    );
  }
}
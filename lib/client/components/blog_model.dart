import 'package:flutter/material.dart';
import 'package:property_system/client/screens/main/blog_page.dart';

import 'package:property_system/client/screens/search/resault/property/property_detailes_page.dart';



class BlogModel extends StatelessWidget {
  const BlogModel({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlogPage(
              imageUrls: [
                'https://example.com/img1.jpg',
                // أضف حتى 4 روابط
              ],
              content: 'هذا هو نص المقالة القادم من الـ API...',
              onOpenProperty: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) =>  PropertyDetailesPage()));
              },
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        width: 320, // مهم لوضوح التمرير الأفقي
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Image.asset(
                'assets/images/pic2.jpg',
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            // الموقع
            const Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: const [
                  Icon(Icons.location_on, color: Colors.blueGrey, size: 22),
                  SizedBox(width: 4),
                  Text(
                    'Najjar, Aleppo',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            // تفاصيل
            const Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  _DetailIcon(icon: Icons.bathtub, label: '4 baths'),
                  _DetailIcon(icon: Icons.bed, label: '3 bedrooms'),
                  _DetailIcon(icon: Icons.area_chart_sharp, label: '30 m²'),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // زر التفاصيل
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                child: const Text(
                  'اضغط لمعرفة التفاصيل',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.blue,
                    fontFamily: 'Pacifico',
                  ),
                ),
              ),
            ),
            //   const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class _DetailIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const _DetailIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey[700]),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 13)),
      ],
    );
  }
}

class BlogSection extends StatelessWidget {
  const BlogSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 420,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        reverse: true, // ✅ لعرض العناصر من اليمين إلى اليسار
        itemCount: 6, // 5 عقارات + 1 زر
        itemBuilder: (context, index) {
          if (index < 5) {
            return const BlogModel();
          } else {
            // ✅ زر عرض المزيد
            return Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                width: 320,
                child: ElevatedButton(
                  onPressed: () {
                    // انتقل لصفحة أخرى
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'عرض المزيد',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Pacifico',
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

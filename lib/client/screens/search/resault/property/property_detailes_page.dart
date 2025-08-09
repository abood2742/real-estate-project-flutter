import 'package:flutter/material.dart';
import 'package:property_system/client/screens/search/reservation/Property_reservation.dart';
import 'package:property_system/client/screens/search/map/map_page.dart';
import 'package:property_system/client/screens/search/comments/Add_Comment_And_Rating_Page.dart';
import 'package:property_system/client/screens/report/report_post_page.dart';

class PropertyDetailesPage extends StatefulWidget {
  const PropertyDetailesPage({super.key});

  @override
  State<PropertyDetailesPage> createState() => _PropertyDetailesPageState();
}

class _PropertyDetailesPageState extends State<PropertyDetailesPage> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    const String propertyImage = 'assets/images/pic3.jpg';
    const double rating = 4.5;
    const String location = 'دمشق, باب مصلى';
    const int price = 20000;
    const String description =
        'بيت واسع بتصميم عصري،\nيتميز بإضاءة رائعة ونوافذ بانورامية.\nيضم حديقة خاصة ومساحات داخلية.';

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'تفاصيل للعقار',
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
                isFavorite ? Icons.star : Icons.star_border,
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
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: AspectRatio(
                      aspectRatio: 4 / 3,
                      child: Image.asset(
                        propertyImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        rating.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const Spacer(),
                      const Icon(Icons.location_pin,
                          size: 20, color: Colors.blue),
                      const SizedBox(width: 4),
                      const Expanded(
                        flex: 0,
                        child: Text(
                          location,
                          style:
                              TextStyle(fontSize: 14, fontFamily: 'Pacifico'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.grey.shade300,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ReportPostPage();
                          }));
                        },
                        child: const Text(
                          'إبلاغ',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Pacifico',
                              color: Color.fromARGB(255, 48, 66, 102)),
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        '$price\$',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.price_change,
                          color: Colors.grey.shade800, size: 20),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MapPage()),
                        );
                      },
                      child: const Text(
                        'عرض على الخريطة',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontFamily: 'Pacifico',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const AddCommentAndRatingPage(officeId: '',)));
                    },
                    child: const Text(
                      'التقييم والتعليق',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontFamily: 'Pacifico'),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'وصف',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                        fontFamily: 'Pacifico',
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    description,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Pacifico',
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Row(
                    children: [
                      Text('حساب الناشر'),
                      SizedBox(width: 10),
                      Text('obida5679@gmail.com'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'المزيد من الصور للعقار ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pacifico',
                      color: Color.fromARGB(255, 48, 66, 102),
                    ),
                  ),
                  const SizedBox(height: 20),
                  HorizontalImageList(),
                  const SizedBox(height: 24),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      side: const BorderSide(width: 1, color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const PropertyReservation()));
                    },
                    child: const Text(
                      'حجز العقار',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ✅ ويدجت الصور العرضية مع الضغط
class HorizontalImageList extends StatelessWidget {
  final List<String> imageUrls = const [
    'assets/images/init.png',
    'assets/images/init.png',
    'assets/images/init.png',
    'assets/images/init.png',
    'assets/images/init.png',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: imageUrls.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => FullImageView(imageUrl: imageUrls[index])),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imageUrls[index],
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}

/// ✅ شاشة عرض الصورة بالحجم الكامل
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
            child: Image.asset(imageUrl),
          ),
        ),
      ),
    );
  }
}

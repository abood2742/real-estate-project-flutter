import 'package:flutter/material.dart';

class PropertyCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String location;
  final String price;
  final String area;

  const PropertyCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.price,
    required this.area,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 5,
      child: Row(
        children: [
          // القسم الأيسر: التفاصيل
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title, // مثال: "Apartment"
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Row(
                    children: const [
                      Icon(Icons.location_on, color: Colors.blue),
                      SizedBox(width: 6),
                      Text("Mazzah"),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: const [
                      Icon(Icons.attach_money, color: Colors.blue),
                      SizedBox(width: 6),
                      Text("30,000 \$"),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.space_bar, color: Colors.blue),
                      const SizedBox(width: 6),
                      const Text("100 m²"),
                      SizedBox(
                        width: 16,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: const Text(
                              'remove',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 77, 77, 78),
                                  fontSize: 14),
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: const Color.fromARGB(255, 154, 181, 204)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // القسم الأيمن: صورة العقار
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: Image.asset(
                imageUrl, // مثال: 'assets/images/property1.jpg'
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

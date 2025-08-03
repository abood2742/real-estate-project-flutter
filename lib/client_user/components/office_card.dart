import 'package:flutter/material.dart';

class OfficeCard extends StatelessWidget {
  final String imageUrl;
  final double rating;
  final String location;
  final VoidCallback onShowPressed;

  const OfficeCard({
    super.key,
    required this.imageUrl,
    required this.rating,
    required this.location,
    required this.onShowPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🖼️ صورة المكتب
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Image.asset(
              imageUrl,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // 🔽 التفاصيل السفلية
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                // ⭐ التقييم
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                Text(
                  rating.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Spacer(),

                // 📍 الموقع
                const Icon(Icons.location_on, color: Colors.blue, size: 20),
                const SizedBox(width: 4),
                Text(
                  location,
                  style: const TextStyle(color: Colors.black87),
                ),
                const Spacer(),

                // 🔘 زر Show
                ElevatedButton(
                  onPressed: onShowPressed,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text('Show'),
                ),
                SizedBox(
                  width: 8,
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
          ),
        ],
      ),
    );
  }
}

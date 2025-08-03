import 'package:flutter/material.dart';

class OfferCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String price;
  final VoidCallback onDetailsPressed;

  const OfferCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.onDetailsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(16),
        shadowColor: Colors.grey.withOpacity(0.3),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16), // ← الحواف المنحنية الحقيقية
          child: Container(
            width: 250,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  imagePath,
                  height: 210,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Pacifico',
                              fontSize: 16,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            subtitle,
                            style: const TextStyle(
                              fontFamily: 'Pacifico',
                              fontSize: 14,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$price \$',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: onDetailsPressed,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'التفاصيل',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'Pacifico',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

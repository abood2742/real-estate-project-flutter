import 'package:flutter/material.dart';
import 'package:property_system/client/components/custom_buttons/build_stars.dart';

class OfficeWidget extends StatelessWidget {
  final String name;
  final String phone;
  final String imageUrl;
  final double rating; // لدعم نصف النجوم
  final VoidCallback? onTap;
  final VoidCallback? onRemove;

  const OfficeWidget({
    super.key,
    required this.name,
    required this.phone,
    required this.imageUrl,
    required this.rating,
    this.onTap,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 2,
          shadowColor: const Color.fromARGB(255, 53, 145, 133),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start, // يضمن محاذاة من الأعلى
              children: [
                // الصورة على اليمين
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    imageUrl,
                    height: 130,
                    width: 150,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 100,
                        width: 120,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.broken_image, size: 40),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),

                // الجزء الأيسر: النصوص + النجوم + زر الحذف في الأسفل
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Text(
                            phone,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(Icons.phone, size: 20, color: Colors.grey),
                        ],
                      ),
                      const SizedBox(height: 10),
                      RatingStarsWidget(rating: rating),

                      const SizedBox(height: 10), // مسافة قبل الزر
                      if (onRemove != null)
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: RawMaterialButton(
                            onPressed: onRemove,
                            elevation: 2.0,
                            fillColor: const Color(0xFF1565C0),
                            constraints: const BoxConstraints(minWidth: 0.0),
                            child: const Icon(
                              Icons.delete_outline_sharp,
                              color: Colors.white,
                              size: 15.0,
                            ),
                            padding: const EdgeInsets.all(12.0),
                            shape: const CircleBorder(),
                          ),
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

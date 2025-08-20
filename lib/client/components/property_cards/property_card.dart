import 'package:flutter/material.dart';

class PropertyCard extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final String location;
  final String price;
  final String area;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;

  const PropertyCard({
    super.key,
    required this.title,
    required this.location,
    required this.price,
    required this.area,
    this.imageUrl,
    this.onTap,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAlias, // 👈 مهم عشان الصورة تنقص داخل الكارد
          elevation: 5,
          child: Row(
            children: [
              // القسم الأيسر: التفاصيل
              Expanded(
                flex: 2,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.blue),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              location,
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.grey),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.attach_money, color: Colors.blue),
                          const SizedBox(width: 6),
                          Text(
                            price,
                            style: const TextStyle(
                                fontSize: 15, color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.space_bar, color: Colors.blue),
                          const SizedBox(width: 6),
                          Text(
                            "$area m²",
                            style: const TextStyle(
                                fontSize: 15, color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      if (onRemove != null)
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: RawMaterialButton(
                            onPressed: onRemove,
                            elevation: 2.0,
                            fillColor: const Color(0xFF1565C0),
                            constraints:
                                const BoxConstraints(minWidth: 0.0),
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
              ),

              // القسم الأيمن: صورة العقار
              Expanded(
                flex: 3,
                child: imageUrl != null
                    ? Image.network(
                        imageUrl!,
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 150,
                            width: double.infinity,
                            color: Colors.grey[300],
                            child: const Center(
                              child: Icon(Icons.broken_image, size: 40),
                            ),
                          );
                        },
                      )
                    : Container(
                        height: 150,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.image_not_supported, size: 40),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

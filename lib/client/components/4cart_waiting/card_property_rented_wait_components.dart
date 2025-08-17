import 'package:flutter/material.dart';

class CardPropertyRentedWaitComponents extends StatelessWidget {
  final String imageUrl;
  final String date;
  final String location;
  final VoidCallback? onTap;

  const CardPropertyRentedWaitComponents({
    Key? key,
    required this.imageUrl,
    required this.date,
    required this.location,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Card(
            elevation: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              width: 350,
              height: 300,
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  // صورة العقار + الحواف
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Image.network(
                      imageUrl,
                      height: 180,
                      width: 280,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // معلومات العقار
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(date, textDirection: TextDirection.rtl),
                            const Text(' تم الإيجار',
                                textDirection: TextDirection.rtl),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(location, textDirection: TextDirection.rtl),
                            const SizedBox(width: 6),
                            const Icon(Icons.location_on, size: 16),
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
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Divider(
            height: 2,
            thickness: 2,
            color: const Color.fromARGB(255, 163, 176, 181),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

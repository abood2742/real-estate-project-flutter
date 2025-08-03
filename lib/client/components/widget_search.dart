import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WidgetSearch extends StatelessWidget {
  final String title;
  final String location;
  final String price;
  final String imageUrl;
  final int area;
  final Widget returned;

  const WidgetSearch({
    Key? key,
    required this.title,
    required this.location,
    required this.price,
    required this.imageUrl,
    required this.area,
    required this.returned,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return returned;
          }));
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 2,
          shadowColor: const Color.fromARGB(255, 53, 145, 133),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // صورة العقار
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: Image.asset(
                  imageUrl,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              // التفاصيل
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // العنوان والسعر
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          price,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    // الموقع
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined,
                            size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          location,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // المساحة
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '${area.toStringAsFixed(0)} m²',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 6),
                        const Icon(FontAwesomeIcons.chartArea,
                            size: 14, color: Colors.grey),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

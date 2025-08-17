
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
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            width: 300,
            height: 450,
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
                    height: 380,
                    width:280,
                    fit: BoxFit.cover,
                  ),
                ),
        
                // معلومات العقار
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(date, textDirection: TextDirection.rtl),
                          const Text(' تم الإيجار', textDirection: TextDirection.rtl),
                        ],
                      ),
                      const SizedBox(height: 10),
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
          SizedBox(height: 10,),
        Divider(height: 1,color: const Color.fromARGB(255, 65, 128, 221),),
        SizedBox(height: 10,),
      ],
    );
  }
}

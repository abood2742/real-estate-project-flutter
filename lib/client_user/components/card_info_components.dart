import 'package:flutter/material.dart';

class CardInfoComponents extends StatelessWidget {
  CardInfoComponents({super.key, required this.name, required this.nameName});
  String name, nameName;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0), // تعطي padding داخلي مناسب
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.stretch, // يجعل النصوص تمتد عرضياً
          children: [
            Text(
              name,
              style: const TextStyle(
                color: Color.fromARGB(255, 102, 180, 105),
                fontFamily: 'Pacifico',
                fontSize: 20,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 10),
            Text(
              nameName,
              style: const TextStyle(
                color: Color.fromARGB(255, 70, 128, 210),
                fontFamily: 'Pacifico',
                fontSize: 18,
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}

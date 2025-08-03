import 'package:flutter/material.dart';

class Rectangle extends StatelessWidget {
  const Rectangle({required this.name, required this.icon, Key? key})
      : super(key: key);

  final String name;
  final IconData icon; // تغيير النوع من Icon إلى IconData

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Container(
        width: 75,
        height: 90,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 53, 145, 133),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Column(
          // إزالة const هنا لأنها تحتوي على متغيرات
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                size: 30, color: Colors.white), // إزالة ! لأنها غير ضرورية
            const SizedBox(height: 15),
            Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

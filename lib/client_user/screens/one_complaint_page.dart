import 'package:flutter/material.dart';

class OneComplaintPage extends StatelessWidget {
  const OneComplaintPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              'معلومات الشكوى',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
              ),
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 20),
            const Card(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  'الاسم:',
                  textDirection: TextDirection.rtl,
                ),
                trailing: Text(
                  'أحمد محمود',
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                  textDirection: TextDirection.rtl,
                ),
              ),
            ),
            const Card(
              child: ListTile(
                leading: Icon(Icons.calendar_today),
                title: Text(
                  'تاريخ التقديم: ',
                  textDirection: TextDirection.rtl,
                ),
                trailing: Text(
                  ' 2025/07/29  ',
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                  textDirection: TextDirection.rtl,
                ),
              ),
            ),
            const Card(
              child: ListTile(
                leading: Icon(Icons.calendar_today),
                title: Text(
                  ':  سبب الشكوى ',
                  textDirection: TextDirection.rtl,
                ),
                trailing: Text(
                  'إساءة في المعاملة ',
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                  textDirection: TextDirection.rtl,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'حالة الشكوى',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
              ),
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 10),
            Card(
              color: Colors.orange.shade100,
              child: const ListTile(
                leading: Icon(Icons.info, color: Colors.orange),
                title: Text(
                  'قيد المراجعة',
                  style: TextStyle(fontWeight: FontWeight.w600),
                  textDirection: TextDirection.rtl,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

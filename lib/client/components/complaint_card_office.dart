import 'package:flutter/material.dart';

class ComplaintCardOffice extends StatelessWidget {
  const ComplaintCardOffice(
      {super.key,
      required this.officeName,
      required this.complaintTitle,
      required this.complaintDate});

  final String officeName;
  final String complaintTitle;
  final String complaintDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Card(
            elevation: 2,
            child: Container(
              height: 250,
              width: 450,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: Column(
                children: [
                    SizedBox(
                  height: 100,
                ),
                  // 🏢 اسم المكتب
                  Row(
                    children: [
                      const Icon(Icons.business,
                        color: Colors.grey, size: 22), // ✅ أصغر
                      const SizedBox(width: 8),
                      const Text(
                        'اسم المكتب : ',
                        style: TextStyle(
                          fontFamily: 'Pacifico',
                          color: Color.fromARGB(115, 0, 128, 98),
                          fontWeight: FontWeight.bold,
                          fontSize: 16, // ✅ بدل 18
                        ),
                      ),
                      Expanded(
                        child: Text(
                          officeName,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.lightBlue,
                              fontFamily: 'Pacifico'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 33),

                  // 📝 عنوان الشكوى
                  Row(
                    children: [
                      const Icon(Icons.title, color: Colors.grey, size: 22),
                      const SizedBox(width: 8),
                      const Text(
                        'عنوان الشكوى: ',
                        style: TextStyle(
                          fontFamily: 'Pacifico',
                          color: Color.fromARGB(115, 0, 128, 98),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          complaintTitle,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.lightBlue,
                              fontFamily: 'Pacifico'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 33),

                  // 📅 تاريخ الشكوى
                  Row(
                    children: [
                      const Icon(Icons.date_range,
                         color: Colors.grey, size: 22),
                      const SizedBox(width: 8),
                      const Text(
                        'تاريخ الشكوى: ',
                        style: TextStyle(
                          fontFamily: 'Pacifico',
                          color: Color.fromARGB(115, 0, 128, 98),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          complaintDate,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.lightBlue,
                              fontFamily: 'Pacifico'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

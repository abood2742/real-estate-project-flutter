import 'package:flutter/material.dart';

import 'package:property_system/client_user/screens/client_page_property_in_expired_property_page.dart';

class ExpiredComponents extends StatelessWidget {
  final String nameType;
  final String location;
  final String expiredDate;

  const ExpiredComponents({
    super.key,
    required this.nameType,
    required this.location,
    required this.expiredDate,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ClientPagePropertyInExpiredPropertyPage(
            pushedOffice: 'faisalOffice',
            pushedOfficeAccount: 'faisal@gmail.com',
            propertyArea: 'd',
            propertyLocation: 'd',
            propertyPrice: 'd',
            propertyType: 'd',
          );
        }));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          height: 300,
          width: 250,
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  'assets/images/init.png',
                  fit: BoxFit.cover,
                  height: 120,
                  width: double.infinity,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text(
                    'العقار',
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Pacifico',
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    nameType,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontFamily: 'Pacifico',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text(
                    'الموقع',
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Pacifico',
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    location,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontFamily: 'Pacifico',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text(
                    'تاريخ الانتهاء',
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Pacifico',
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    expiredDate,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontFamily: 'Pacifico',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  // هنا تضيف السلوك المطلوب
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color.fromARGB(255, 154, 181, 204),
                  ),
                  child: const Text(
                    'Remove',
                    style: TextStyle(
                      color: Color.fromARGB(255, 77, 77, 78),
                      fontSize: 11,
                    ),
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

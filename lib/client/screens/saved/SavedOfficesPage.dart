import 'package:flutter/material.dart';
import 'package:property_system/client/components/office_card.dart';



class SavedOfficesPage extends StatelessWidget {
  const SavedOfficesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          OfficeCard(
  imageUrl: 'assets/images/office.jpg',
  rating: 4.5,
  location: 'Bab Toma',
  onShowPressed: () {
    // انتقل إلى صفحة التفاصيل أو أظهر نافذة
    print('عرض المكتب');
  },
),

 OfficeCard(
  imageUrl: 'assets/images/off3.jpg',
  rating: 3.5,
  location: 'babbila',
  onShowPressed: () {
    // انتقل إلى صفحة التفاصيل أو أظهر نافذة
    print('عرض المكتب');
  },
),

 OfficeCard(
  imageUrl: 'assets/images/off1.jpg',
  rating: 2.5,
  location: 'Bab Sharqi',
  onShowPressed: () {
    // انتقل إلى صفحة التفاصيل أو أظهر نافذة
    print('عرض المكتب');
  },
),

        ],
      ),
    );
  }
}
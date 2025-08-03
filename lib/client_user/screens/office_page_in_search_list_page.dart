import 'dart:math';

import 'package:flutter/material.dart';
import 'package:property_system/client_user/components/card_info_components.dart';

class OfficePageInSearchListPage extends StatefulWidget {
  const OfficePageInSearchListPage({super.key});

  @override
  State<OfficePageInSearchListPage> createState() =>
      _OfficePageInSearchListPageState();
}

class _OfficePageInSearchListPageState
    extends State<OfficePageInSearchListPage> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: sqrt1_2,
        title: const Text(
          'معلومات المكتب ',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Pacifico',
            color: Color.fromARGB(255, 48, 66, 102),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.star : Icons.star_border,
              color: isFavorite ? Colors.blue : Colors.grey,
            ),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CardInfoComponents(
            name: 'اسم المكتب',
            nameName: 'مكتب التقى العقاري',
          ),
          SizedBox(height: 20),
          CardInfoComponents(
            name: 'الموقع',
            nameName: 'دمشق، دمر، شارع فلسطين',
          ),
          SizedBox(height: 20),
          CardInfoComponents(
            name: 'رقم الهاتف',
            nameName: '+963 11 1234567',
          ),
          SizedBox(height: 20),
          CardInfoComponents(
            name: 'البريد الإلكتروني',
            nameName: 'info@altaqaa-realestate.com',
          ),
          SizedBox(height: 20),
          CardInfoComponents(
            name: 'ساعات العمل',
            nameName: 'الأحد - الخميس 9 صباحًا - 6 مساءً',
          ),
          SizedBox(height: 20),
          CardInfoComponents(
            name: 'تاريخ التأسيس',
            nameName: '2005',
          ),
          SizedBox(height: 20),
          CardInfoComponents(
            name: 'نوع الخدمات',
            nameName: 'بيع وتأجير العقارات السكنية والتجارية',
          ),
          SizedBox(height: 20),
          CardInfoComponents(
            name: 'عدد الموظفين',
            nameName: '12 موظف',
          ),
          SizedBox(height: 20),
          CardInfoComponents(
            name: 'الموقع الإلكتروني',
            nameName: 'www.altaqaa-realestate.com',
          ),
          SizedBox(height: 20),
          CardInfoComponents(
            name: 'وسائل التواصل الاجتماعي',
            nameName: 'فيسبوك، انستجرام، تويتر',
          ),
          SizedBox(height: 20),
          CardInfoComponents(
            name: 'رئيس المكتب',
            nameName: 'محمد علي',
          ),
          SizedBox(height: 20),
          CardInfoComponents(
            name: 'رخصة المكتب',
            nameName: '123456789',
          ),
          SizedBox(height: 20),
          CardInfoComponents(
            name: 'ملاحظات',
            nameName: 'يوجد مواقف سيارات خاصة للعملاء',
          ),
        ],
      ),
    );
  }
}

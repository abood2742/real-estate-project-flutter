import 'package:flutter/material.dart';
import 'package:property_system/client_user/components/card_info_components.dart';

class PropertyInfoInLimitedProperty extends StatelessWidget {
   PropertyInfoInLimitedProperty({super.key ,required this.pushedOffice ,required this.pushedOfficeAccount});
  String pushedOffice, pushedOfficeAccount;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CardInfoComponents(
            name: 'المكتب الناشر',
            nameName: 'مكتب التقى العقاري',
          ),
          SizedBox(height: 20),
          CardInfoComponents(
            name: 'حساب المكتب الناشر',
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

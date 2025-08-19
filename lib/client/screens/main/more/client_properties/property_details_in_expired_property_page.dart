import 'package:flutter/material.dart';
import 'package:property_system/client/components/card_info_components.dart';
import 'package:property_system/client/screens/main/more/complaint/push_complaint_page.dart';

class ClientPagePropertyInExpiredPropertyPage extends StatelessWidget {
  ClientPagePropertyInExpiredPropertyPage(
      {super.key,
      required this.pushedOffice,
      required this.pushedOfficeAccount,
      required this.propertyArea,
      required this.propertyLocation,
      required this.propertyPrice,
      required this.propertyType});
  String pushedOffice,
      pushedOfficeAccount,
      propertyPrice,
      propertyLocation,
      propertyType,
      propertyArea;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CardInfoComponents(
            name: 'المكتب الناشر',
            nameName: pushedOffice,
          ),
          SizedBox(height: 20),
          CardInfoComponents(
            name: 'حساب المكتب الناشر',
            nameName: pushedOfficeAccount,
          ),
          SizedBox(height: 20),
          CardInfoComponents(
            name: ' سعر العقار',
            nameName: propertyPrice,
          ),
          SizedBox(height: 20),
          CardInfoComponents(
            name: 'مكان العقار',
            nameName: propertyLocation,
          ),
          SizedBox(height: 20),
          CardInfoComponents(
            name: 'نوع العقار',
            nameName: propertyType,
          ),
          SizedBox(height: 20),
          CardInfoComponents(
            name: 'مساحة العقار',
            nameName: propertyArea,
          ),
          SizedBox(height: 50),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PushComplaintPage()),
              );
            },
            child: const Text(
              'عرض على الخريطة',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontFamily: 'Pacifico',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

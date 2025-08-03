import 'package:flutter/material.dart';
import 'package:property_system/client_user/components/expired_components.dart';

class ClientExpiredForRentPage extends StatelessWidget {
  const ClientExpiredForRentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 2, // عنصرين في كل صف
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.75,
        children: [
          ExpiredComponents(
            nameType: 'شقة',
            location: 'حمص العدية',
            expiredDate: '8 / 12 / 2024',
          ),
          ExpiredComponents(
            nameType: 'شقة',
            location: 'حمص العدية',
            expiredDate: '8 / 12 / 2024',
          ),
          ExpiredComponents(
            nameType: 'شقة',
            location: 'حمص العدية',
            expiredDate: '8 / 12 / 2024',
          ),
          ExpiredComponents(
            nameType: 'شقة',
            location: 'حمص العدية',
            expiredDate: '8 / 12 / 2024',
          ),
          ExpiredComponents(
            nameType: 'شقة',
            location: 'حمص العدية',
            expiredDate: '8 / 12 / 2024',
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:property_system/client/components/expired_components.dart';

class ClientExpiredForBuyPage extends StatelessWidget {
  const ClientExpiredForBuyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2, // عنصرين في كل صف
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.75, // تحكم في نسبة العرض للارتفاع
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
      ),
    );
  }
}

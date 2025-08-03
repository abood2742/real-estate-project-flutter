
import 'package:flutter/material.dart';

class ClientReservedPropertyForRentPage extends StatelessWidget {
  const ClientReservedPropertyForRentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'لا توجد عقارات للإيجار حالياً',
        style:
            TextStyle(fontSize: 16, fontFamily: 'Pacifico', color: Colors.grey),
      ),
    );
  }
}

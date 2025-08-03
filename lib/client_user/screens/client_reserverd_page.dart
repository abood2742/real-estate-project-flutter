import 'package:flutter/material.dart';
import 'package:property_system/client_user/screens/client_reserved_property_for_rent_page.dart';
import 'package:property_system/client_user/screens/client_reserved_property_for_sell_page.dart';


class ClientReserverdPage extends StatelessWidget {
  const ClientReserverdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // عدد التبويبات
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: const Text(
            'العقارات المحجوزة',
            style: TextStyle(color: Colors.white, fontFamily: 'Pacifico'),
          ),
          bottom: const TabBar(
            indicatorColor: Color.fromARGB(255, 48, 32, 173),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(
                text: 'عقارات البيع',
              ),
              Tab(text: 'عقارات الإيجار'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ClientReservedPropertyForSellPage(), // بيع
            ClientReservedPropertyForRentPage(), // إيجار
          ],
        ),
      ),
    );
  }
}

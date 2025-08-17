import 'package:flutter/material.dart';
import 'package:property_system/client/components/4cart_waiting/card_property_salled_waite_component.dart';

class SalledPage extends StatelessWidget {
  const SalledPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            CardPropertySalledWaiteComponent(
              imageUrl: 'assets/images/pic2.jpg',
             
             
             date: '12/12/2020', location: 'damascuse',
            ),
            CardPropertySalledWaiteComponent(
              imageUrl: 'assets/images/pic2.jpg',
             date: '12/12/2020',
             location: 'damascuse',
          
            ),
            CardPropertySalledWaiteComponent(
              imageUrl: 'assets/images/pic2.jpg',
            date: '12/12/2020',
            location: 'damascuse',
            
            ),
          ],
        ),
      ),
    );
  }
}

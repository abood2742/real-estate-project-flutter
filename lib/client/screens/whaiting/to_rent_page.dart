import 'package:flutter/material.dart';
import 'package:property_system/client/components/4cart_waiting/card_property_rented_wait_components.dart';
import 'package:property_system/client/components/4cart_waiting/card_property_to_sall_wait_components.dart';
import 'package:property_system/client/components/4cart_waiting/cart_property_to_rent_wait_components.dart';

class ToRentPage extends StatelessWidget {
  const ToRentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
            children: [
              CartPropertyToRentWaitComponents(
                     imageUrl: 'assets/images/pic3.jpg',
               
               
               date: '12/12/2020', location: 'damascuse',
              ),
              CartPropertyToRentWaitComponents(
                       imageUrl: 'assets/images/pic3.jpg',
               date: '12/12/2020',
               location: 'damascuse',
            
              ),
              CartPropertyToRentWaitComponents(
                imageUrl: 'assets/images/pic3.jpg',
              date: '12/12/2020',
              location: 'damascuse',
              
              ),
            ],
          ),
      ),
      
    );
  }
}

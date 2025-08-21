import 'package:flutter/material.dart';
import 'package:property_system/client/components/4cart_waiting/card_property_rented_wait_components.dart';

class RentedPage extends StatelessWidget {
  const RentedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
            children: [
              CardPropertyRentedWaitComponents(
                     imageUrl: 'assets/images/pic3.jpg',
               
               
               date: '12/12/2020', location: 'damascuse',
              ),
              CardPropertyRentedWaitComponents(
                       imageUrl: 'assets/images/pic3.jpg',
               date: '12/12/2020',
               location: 'damascuse',
            
              ),
              CardPropertyRentedWaitComponents(
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

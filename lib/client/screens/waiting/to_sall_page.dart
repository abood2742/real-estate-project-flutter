import 'package:flutter/material.dart';
import 'package:property_system/client/components/4cart_waiting/card_property_to_sall_wait_components.dart';

class ToSallPage extends StatelessWidget {
  const ToSallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
            children: [
              CardPropertyToSallWaitComponents(
                     imageUrl: 'assets/images/pic3.jpg',
               
               
               date: '12/12/2020', location: 'damascuse',
              ),
              CardPropertyToSallWaitComponents(
                       imageUrl: 'assets/images/pic3.jpg',
               date: '12/12/2020',
               location: 'damascuse',
            
              ),
              CardPropertyToSallWaitComponents(
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

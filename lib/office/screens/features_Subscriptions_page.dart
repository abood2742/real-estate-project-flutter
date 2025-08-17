import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FeaturesSubscriptionsPage extends StatelessWidget {
  const FeaturesSubscriptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 18, 33, 88),
      appBar: AppBar(
        centerTitle: true,
        title: Text('ميزات الإشتراك',style:TextStyle(color: Colors.white,fontFamily: 'Pacifico',),),),
      
        body:Column(children: [
          
        ],) ,
    );
  }
}
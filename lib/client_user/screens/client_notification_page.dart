import 'package:flutter/material.dart';

class ClientNotificationPage extends StatelessWidget {
  ClientNotificationPage({super.key});
  bool isOn = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 100, 17, 188),
        title: Text(
          'مركز الاشعارات ',
          style: TextStyle(fontFamily: 'Pacifico', color: Colors.white),
        ),
      ),

    );
  }
}

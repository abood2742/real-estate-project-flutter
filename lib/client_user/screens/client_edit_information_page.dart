import 'dart:math';

import 'package:flutter/material.dart';

class ClientEditInformationPage extends StatelessWidget {
  const ClientEditInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        centerTitle: true,
        title: const Text(
          'عدل بياناتك ',
          style: TextStyle(color: Colors.green, fontFamily: 'Pacifico'),
        ),
      ),
    );
  }
}

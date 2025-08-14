// صفحة انتظار الموافقة
import 'package:flutter/material.dart';

class WaitingApprovalPage extends StatelessWidget {
  final String message;

  const WaitingApprovalPage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('في انتظار الموافقة')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            message,
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class SmallCustomButton extends StatelessWidget {
  SmallCustomButton({this.onTap, required this.text});
  VoidCallback? onTap;
  String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 18, 33, 88),
          borderRadius: BorderRadius.circular(8),
        ),
        width: 100,
        height: 45,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

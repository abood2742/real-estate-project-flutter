import 'package:flutter/material.dart';

class CustomSelectButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const CustomSelectButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected
              ? const Color.fromARGB(255, 21, 129, 217)
              : Colors.white,
          foregroundColor: isSelected ? Colors.white : Colors.black,
          side: BorderSide(
            color: isSelected ? Colors.transparent : Colors.grey.shade400,
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(fontFamily: 'Pacifico'),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class LicenseTypeDropdown extends StatelessWidget {
  final String? selectedValue;
  final List<String> items;
  final String hint;
  final ValueChanged<String?> onChanged;

  const LicenseTypeDropdown({
    super.key,
    required this.selectedValue,
    required this.items,
    required this.hint,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      hint: Text(hint), // يظهر لما ما يكون فيه اختيار
      items: items.map((type) {
        return DropdownMenuItem<String>(
          value: type,
          child: Text(type),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}

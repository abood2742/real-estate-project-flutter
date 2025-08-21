import 'package:flutter/material.dart';

class PropertyTypeSelector extends StatelessWidget {
  final List<String> typesOfPropertyTypes;
final String? selectedType;
  final Function(String) onTypeSelected;

  const PropertyTypeSelector({
    super.key,
    required this.typesOfPropertyTypes,
    required this.selectedType,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'نوع العقار',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Pacifico',
            color: Color.fromARGB(255, 23, 88, 73),
          ),
          textAlign: TextAlign.right,
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Wrap(
            spacing: 10,
            children: typesOfPropertyTypes.map((type) {
              final isSelected = selectedType == type;
              return SizedBox(
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSelected
                        ? const Color.fromARGB(255, 21, 129, 217)
                        : Colors.white,
                    foregroundColor: isSelected ? Colors.white : Colors.black,
                    side: BorderSide(
                      color: isSelected
                          ? Colors.transparent
                          : Colors.grey.shade400,
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    onTypeSelected(type);
                  },
                  child: Text(type,
                      style: const TextStyle(fontFamily: 'Pacifico')),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

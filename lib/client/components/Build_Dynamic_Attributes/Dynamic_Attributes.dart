import 'package:flutter/material.dart';
import 'package:property_system/client/components/Build_Dynamic_Attributes/Custom_Input.dart';
import 'package:property_system/client/models/property_type_model.dart';

class DynamicAttributes extends StatelessWidget {
  final List<AttributesModel> attributes;
  final Map<String, bool> boolAttributes;
  final Map<String, dynamic> valueAttributes;
  final Color primaryColor;
  final Function(String, dynamic) onChanged;

  const DynamicAttributes({
    super.key,
    required this.attributes,
    required this.boolAttributes,
    required this.valueAttributes,
    required this.primaryColor,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (attributes.isEmpty) return const Text("لا يوجد صفات لهذا النوع");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: attributes.map((attr) {
        switch (attr.type) {
          case 'bool':
            return SwitchListTile(
              title: Text(attr.name),
              value: boolAttributes[attr.id] ?? false,
              activeColor: primaryColor,
              onChanged: (val) => onChanged(attr.id, val),
            );
          case 'string':
            return CustomInput(
              label: attr.name,
              controller:
                  TextEditingController(text: valueAttributes[attr.id] ?? ''),
              keyboardType: TextInputType.text,
              onChanged: (val) => onChanged(attr.id, val),
            );
          case 'number':
            double currentValue =
                valueAttributes[attr.id] is double ? valueAttributes[attr.id] : 0.0;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(attr.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                Slider(
                  value: currentValue,
                  min: 0,
                  max: 100,
                  divisions: 100,
                  activeColor: primaryColor,
                  label: currentValue.round().toString(),
                  onChanged: (val) => onChanged(attr.id, val),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "القيمة: ${currentValue.round()}",
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            );
          default:
            return const SizedBox();
        }
      }).toList(),
    );
  }
}

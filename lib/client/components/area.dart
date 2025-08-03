import 'package:flutter/material.dart';

class AreaRangeSelector extends StatefulWidget {
  @override
  _AreaRangeSelectorState createState() => _AreaRangeSelectorState();
}

class _AreaRangeSelectorState extends State<AreaRangeSelector> {
  RangeValues _range = const RangeValues(0, 300);
  final TextEditingController _minController = TextEditingController(text: '0');
  final TextEditingController _maxController =
      TextEditingController(text: '300');

  void _updateSliderFromFields() {
    final double min = double.tryParse(_minController.text) ?? 0;
    final double max = double.tryParse(_maxController.text) ?? 300;

    if (min <= max) {
      setState(() {
        _range = RangeValues(min, max);
      });
    }
  }

  void _updateFieldsFromSlider(RangeValues values) {
    _minController.text = values.start.round().toString();
    _maxController.text = values.end.round().toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Spacer(),
            Expanded(
              child: TextField(
                controller: _minController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'أقل م²'),
                textAlign: TextAlign.center,
                onChanged: (_) => _updateSliderFromFields(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: _maxController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'أعلى م²'),
                textAlign: TextAlign.center,
                onChanged: (_) => _updateSliderFromFields(),
              ),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: 16),
        RangeSlider(
          values: _range,
          min: 0,
          max: 300,
          divisions: 6,
          labels: RangeLabels(
            '${_range.start.round()}',
            '${_range.end.round()}',
          ),
          onChanged: (RangeValues values) {
            setState(() {
              _range = values;
              _updateFieldsFromSlider(values);
            });
          },
          activeColor: Colors.blue,
          inactiveColor: Colors.grey.shade300,
        ),
      ],
    );
  }
}

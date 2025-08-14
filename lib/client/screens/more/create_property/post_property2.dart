import 'package:flutter/material.dart';
  import 'package:numberpicker/numberpicker.dart'; // تحتاج تضيفه في pubspec.yaml


class PostProperty2 extends StatefulWidget {
  final String propertyTypeId;
  const PostProperty2({super.key, required this.propertyTypeId});

  @override
  State<PostProperty2> createState() => _PostProperty2State();
}

class AttributesModel {
  String id;
  String name;
  String type;

  AttributesModel({
    required this.id,
    required this.name,
    required this.type,
  });

  factory AttributesModel.fromJson(Map<String, dynamic> json) {
    return AttributesModel(
      id: json["attribute"]["id"],
      name: json["attribute"]["name"],
      type: json["attribute"]["type"],
    );
  }
}

class _PostProperty2State extends State<PostProperty2> {
  final Color primaryColor = Colors.indigo.shade700;
  final Color backgroundColor = Colors.grey.shade100;

  // Controllers للحقول الأساسية
  final TextEditingController numberController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // Controllers للموقع
  final TextEditingController latController = TextEditingController();
  final TextEditingController lngController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController districtController = TextEditingController();

  // قائمة الصفات القادمة من الباك
  List<AttributesModel> attributes = [];

  // لتخزين القيم المدخلة للـ bool
  Map<String, bool> boolAttributes = {};

  // لتخزين القيم للـ string / number
  Map<String, dynamic> valueAttributes = {};

  @override
  void initState() {
    super.initState();
    // هنا تستدعي الخدمة لجلب الصفات بناء على propertyTypeId
    fetchAttributes();
  }

  void fetchAttributes() async {
    // مثال dummy data، استبدله باستدعاء API
    List<AttributesModel> fetchedAttributes = [
      AttributesModel(id: '1', name: 'حوض سباحة', type: 'bool'),
      AttributesModel(id: '2', name: 'عدد الطوابق', type: 'number'),
      AttributesModel(id: '3', name: 'ملاحظات', type: 'string'),
    ];

    setState(() {
      attributes = fetchedAttributes;
      for (var attr in attributes) {
        if (attr.type == 'bool') {
          boolAttributes[attr.id] = false;
        } else {
          valueAttributes[attr.id] = '';
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('نشر عقار'),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInput('Property Number', numberController, TextInputType.text),
              _buildInput('Space', areaController, TextInputType.number),
              _buildInput('Price', priceController, TextInputType.number),
              _buildInput('Description', descriptionController, TextInputType.text),

              const SizedBox(height: 16),
              Text('Location:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              _buildInput('Governorate', latController, TextInputType.number),
              _buildInput('Province', lngController, TextInputType.number),
              _buildInput('City', cityController, TextInputType.text),
              _buildInput('Street', districtController, TextInputType.text),

              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  print("Add Photos");
                },
                icon: const Icon(Icons.add_a_photo),
                label: const Text("Add Photos"),
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
              ),

              const SizedBox(height: 16),
              Text('Attributes:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ...attributes.map((attr) {
                switch (attr.type) {
                  case 'bool':
                    return SwitchListTile(
                      title: Text(attr.name),
                      value: boolAttributes[attr.id] ?? false,
                      onChanged: (val) {
                        setState(() {
                          boolAttributes[attr.id] = val;
                        });
                      },
                    );
                  case 'string':
                    return _buildInput(attr.name, TextEditingController(text: valueAttributes[attr.id] ?? ''), TextInputType.text, onChanged: (val) {
                      valueAttributes[attr.id] = val;
                    });
                  case 'number':
                      return _buildNumberPicker(attr.name, attr.id);

                  default:
                    return const SizedBox();
                }
              }).toList(),

              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // هنا تجمع كل البيانات لإرسالها للباك
                    print('رقم العقار: ${numberController.text}');
                    print('المساحة: ${areaController.text}');
                    print('السعر: ${priceController.text}');
                    print('الوصف: ${descriptionController.text}');
                    print('الموقع: lat=${latController.text}, lng=${lngController.text}, city=${cityController.text}, district=${districtController.text}');
                    print('الصفات bool: $boolAttributes');
                    print('الصفات values: $valueAttributes');
                  },
                  child: const Text('نشر العقار'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput(String label, TextEditingController controller, TextInputType inputType, {Function(String)? onChanged}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }


// داخل _PostProperty2State:

// مثال لحقل رقمي
Widget _buildNumberPicker(String label, String attrId) {
  int currentValue = valueAttributes[attrId] != null
      ? int.tryParse(valueAttributes[attrId].toString()) ?? 0
      : 0;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
      NumberPicker(
        value: currentValue,
        minValue: 0,
        maxValue: 100,
        onChanged: (val) {
          setState(() {
            valueAttributes[attrId] = val;
          });
        },
      ),
      const SizedBox(height: 12),
    ],
  );
}

}

import 'dart:io' as io;
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:property_system/client/components/Build_Dynamic_Attributes/Dynamic_Attributes.dart';
import 'package:property_system/client/models/photo_model.dart';
import 'package:property_system/client/models/property_model.dart';
import 'package:property_system/client/models/property_type_model.dart';
import 'package:property_system/client/services/propety_Type_service_done.dart';

enum PropertyTypeOperation { sale, rent }

class EditPropertyPage extends StatefulWidget {
  final PropertyModel property;
  final List<Photo> photos;

  const EditPropertyPage(
      {super.key, required this.property, required this.photos});

  @override
  State<EditPropertyPage> createState() => _EditPropertyPageState();
}

class _EditPropertyPageState extends State<EditPropertyPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? typeOperation;

  List<Photo> photos = [];
  List<Uint8List> newPhotos = [];
  List<String> deletedPhotos = [];

  // لإدارة الخصائص الديناميكية
  List<AttributesModel> attributes = [];
  Map<String, bool> boolAttributes = {};
  Map<String, dynamic> valueAttributes = {};

  final ImagePicker _picker = ImagePicker();
  final Color primaryColor = Colors.blue;

  @override
  void initState() {
    super.initState();
    _loadPropertyData();
  }

  void _loadPropertyData() async {
    final property = widget.property;

    // تعيين القيم الأساسية
    setState(() {
      priceController.text = property.price.toString();
      descriptionController.text = property.description;
      typeOperation = property.typeOperation;
      photos = widget.photos;
    });

    // جلب جميع الخصائص المرتبطة بنوع العقار
    List<AttributesModel> fetchedAttributes = [];
    List<PropertyTypeModel>? propertyType =
        await PropertyTypeService().getPropertyTypes();

    for (int i = 0; i < propertyType!.length; i++) {
      if (propertyType[i].id == property.propertyType.id) {
        fetchedAttributes = propertyType[i].attributes;
      }
    }

    // إعداد الخرائط للقيم
    Map<String, bool> newBoolAttributes = {};
    Map<String, dynamic> newValueAttributes = {};

    for (var attr in fetchedAttributes) {
      // ابحث عن القيمة الموجودة في العقار
      PropertyAttribute? existingAttr;
      for (var pAttr in property.propertyAttributes) {
        if (pAttr.attribute.id == attr.id) {
          existingAttr = pAttr;
          break;
        }
      }
      if (attr.type == 'boolean') {
        newBoolAttributes[attr.id] = existingAttr != null
            ? existingAttr.value.toLowerCase() == 'true'
            : false;
      } else if (attr.type == 'number') {
        newValueAttributes[attr.id] = existingAttr != null
            ? double.tryParse(existingAttr.value) ?? 0.0
            : 0.0;
      }
    }

    setState(() {
      attributes = fetchedAttributes;
      boolAttributes = newBoolAttributes;
      valueAttributes = newValueAttributes;
    });
  }

  Future<void> _updateProperty() async {
    if (_formKey.currentState!.validate()) {
      // TODO: إرسال البيانات إلى API
      // body = {name, price, description, typeOperation, newPhotos, deletedPhotos, attributes}
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("تم تحديث بيانات العقار ✅")),
      );
    }
  }

  Future<void> _addPhoto() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (kIsWeb) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          newPhotos.add(bytes);
        });
      } else {
        final file = io.File(pickedFile.path);
        setState(() {
          newPhotos.add(file.readAsBytesSync());
        });
      }
    }
  }

  void _removePhoto(int index) {
    setState(() {
      deletedPhotos.add(photos[index].id);
      photos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تعديل العقار"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _updateProperty,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // نوع العملية

            // السعر
            TextFormField(
              controller: priceController,
              decoration: const InputDecoration(labelText: "السعر"),
              keyboardType: TextInputType.number,
              validator: (v) => v!.isEmpty ? "مطلوب" : null,
            ),
            const SizedBox(height: 16),

            // الوصف
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: "الوصف"),
              maxLines: 4,
              validator: (v) => v!.isEmpty ? "مطلوب" : null,
            ),
            const SizedBox(height: 20),
            Text(
              "اختر نوع العملية",
              style: TextStyle(
                fontSize: 18, // حجم الخط
                //fontWeight: FontWeight.bold, // يجعل النص عريض
              ),
            ),

            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: typeOperation == "selling"
                          ? Colors.blue
                          : Colors.grey[300],
                    ),
                    onPressed: () {
                      setState(() => typeOperation = "selling");
                    },
                    child: const Text("بيع",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: typeOperation == "renting"
                          ? Colors.blue
                          : Colors.grey[300],
                    ),
                    onPressed: () {
                      setState(() => typeOperation = "renting");
                    },
                    child: const Text("إيجار",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // الصور
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("الصور", style: TextStyle(fontSize: 18)),
                IconButton(
                  onPressed: _addPhoto,
                  icon: const Icon(Icons.add_a_photo),
                ),
              ],
            ),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(photos.length, (index) {
                return Stack(
                  children: [
                    Image.network(
                      photos[index].url,
                      width: 120,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: GestureDetector(
                        onTap: () => _removePhoto(index),
                        child: const CircleAvatar(
                          backgroundColor: Colors.red,
                          child:
                              Icon(Icons.close, color: Colors.white, size: 18),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
            const SizedBox(height: 20),

            // الخصائص الديناميكية
            const Text("الخصائص", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            DynamicAttributes(
              attributes: attributes,
              boolAttributes: boolAttributes,
              valueAttributes: valueAttributes,
              primaryColor: primaryColor,
              onChanged: (id, val) {
                setState(() {
                  if (val is bool) {
                    boolAttributes[id] = val;
                  } else {
                    valueAttributes[id] = val;
                  }
                });
              },
            ),
            const SizedBox(height: 30),

            // زر تعديل أسفل الصفحة
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  _updateProperty();
                  Navigator.pop(
                    context,
                  );
                },
                child: const Text(
                  "تعديل العقار",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

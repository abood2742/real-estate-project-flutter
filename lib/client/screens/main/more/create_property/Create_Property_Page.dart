// import 'dart:io' as io;
// import 'dart:typed_data';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:property_system/client/models/property_type_model.dart';
// import 'package:property_system/client/services/property_service.dart';
// import 'package:property_system/client/services/propety_Type_service.dart';

// class CreateProperty extends StatefulWidget {
//   const CreateProperty({
//     super.key,
//   });

//   @override
//   State<CreateProperty> createState() => _CreatePropertyState();
// }

// class _CreatePropertyState extends State<CreateProperty> {
//   final Color primaryColor = Colors.indigo.shade700;
//   final Color backgroundColor = Colors.grey.shade100;

//   PropertyTypeModel? selectedPropertyType;
//   List<PropertyTypeModel>? propertyTypes = [];
//   List<AttributesModel> attributes = [];

//   Map<String, bool> boolAttributes = {};
//   Map<String, dynamic> valueAttributes = {};

//   final TextEditingController propertyNumberController =
//       TextEditingController();
//   final TextEditingController spaceController = TextEditingController();
//   final TextEditingController priceController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   final TextEditingController licenseTypeController = TextEditingController();
//   final TextEditingController licenseNumberController = TextEditingController();
//   final TextEditingController governorateController = TextEditingController();
//   final TextEditingController provinceController = TextEditingController();
//   final TextEditingController cityController = TextEditingController();
//   final TextEditingController streetController = TextEditingController();
//   String typeOperation = 'selling';

//   List<Uint8List> _propertyImagesBytes = []; // للويب
//   List<io.File> _propertyImagesFiles = []; // للهاتف
//   final ImagePicker _picker = ImagePicker();

//   @override
//   void initState() {
//     super.initState();
//     fetchPropertyTypesInfo();
//   }

//   void fetchPropertyTypesInfo() async {
//     List<PropertyTypeModel>? fetchedPropertyTypesInfo =
//         await PropertyTypeService().getPropertyTypes();

//     setState(() {
//       propertyTypes = fetchedPropertyTypesInfo;

//       if (propertyTypes!.isNotEmpty) {
//         selectedPropertyType = propertyTypes!.first;
//         fetchAttributesForType(selectedPropertyType!.id);
//       }
//     });
//   }

//   void fetchAttributesForType(String typeId) async {
//     List<AttributesModel> fetched = [];

//     for (var pt in propertyTypes!) {
//       if (pt.id == typeId) {
//         fetched = pt.attributes;
//       }
//     }

//     setState(() {
//       attributes = fetched;
//       boolAttributes.clear();
//       valueAttributes.clear();
//       for (var attr in attributes) {
//         if (attr.type == 'bool') {
//           boolAttributes[attr.id] = false;
//         } else {
//           valueAttributes[attr.id] = '';
//         }
//       }
//     });
//   }

//   void _setTypeOperation(bool type) {
//     if (type) {
//       typeOperation = 'selling';
//     } else {
//       typeOperation = 'renting';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       appBar: AppBar(
//         title: const Text('📝 نشر عقار'),
//         centerTitle: true,
//         backgroundColor: primaryColor,
//       ),
//       body: Directionality(
//         textDirection: TextDirection.rtl,
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildSectionTitle("اختر نوع العقار"),
//               const SizedBox(height: 10),
//               Wrap(
//                 children: propertyTypes!.map((pt) {
//                   final isSelected = selectedPropertyType?.id == pt.id;
//                   return ChoiceChip(
//                     label: Text(pt.name),
//                     selected: isSelected,
//                     selectedColor: Colors.green.shade300,
//                     backgroundColor: Colors.grey.shade200,
//                     labelStyle: TextStyle(
//                       color: isSelected ? Colors.white : Colors.black,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     onSelected: (_) {
//                       setState(() {
//                         selectedPropertyType = pt;
//                       });
//                       fetchAttributesForType(pt.id);
//                     },
//                   );
//                 }).toList(),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   const SizedBox(width: 30),
//                   GestureDetector(
//                     onTap: () {
//                       _setTypeOperation(true);
//                     },
//                     child: Container(
//                       height: 60,
//                       width: 195,
//                       decoration: BoxDecoration(
//                         color: const Color.fromARGB(255, 33, 135, 104),
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: const Center(
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Text(
//                               'sell',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontFamily: 'Pacifico',
//                                 fontSize: 18,
//                               ),
//                             ),
//                             SizedBox(width: 8),
//                             Icon(Icons.home, color: Colors.white),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 30),
//                   GestureDetector(
//                     onTap: () {
//                       _setTypeOperation(false);
//                     },
//                     child: Container(
//                       height: 60,
//                       width: 195,
//                       decoration: BoxDecoration(
//                         color: const Color.fromARGB(255, 33, 135, 104),
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: const Center(
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Text(
//                               'rent',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontFamily: 'Pacifico',
//                                 fontSize: 18,
//                               ),
//                             ),
//                             SizedBox(width: 8),
//                             Icon(Icons.business, color: Colors.white),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               _buildSectionTitle("البيانات الأساسية"),
//               const SizedBox(height: 10),
//               _buildCard(
//                 children: [
//                   _buildInput("رقم العقار", propertyNumberController,
//                       TextInputType.text),
//                   _buildInput("المساحة", spaceController, TextInputType.number),
//                   _buildInput("السعر", priceController, TextInputType.number),
//                   _buildInput(
//                       "الوصف", descriptionController, TextInputType.text),
//                   _buildInput(
//                       "نوع الرخصة", licenseTypeController, TextInputType.text),
//                   _buildInput("رقم الرخصة", licenseNumberController,
//                       TextInputType.text),
//                   _buildInput(
//                       "المحافظة", governorateController, TextInputType.text),
//                   _buildInput(
//                       "المديرية", provinceController, TextInputType.text),
//                   _buildInput("المدينة", cityController, TextInputType.text),
//                   _buildInput("الشارع", streetController, TextInputType.text),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               _buildSectionTitle("الصفات الإضافية"),
//               const SizedBox(height: 10),
//               _buildCard(children: [_buildDynamicAttributes()]),
//               const SizedBox(height: 30),
//               // داخل build، عرض الصور المرفوعة
//               _buildSectionTitle("صور العقار"),
//               const SizedBox(height: 10),
//               Card(
//                 elevation: 3,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12)),
//                 child: Padding(
//                   padding: const EdgeInsets.all(12),
//                   child: Column(
//                     children: [
//                       FloatingActionButton(
//                         heroTag: 'propertyPhotosBtn',
//                         mini: true,
//                         onPressed: _uploadPropertyPhotos,
//                         backgroundColor: primaryColor,
//                         child: const Icon(Icons.add),
//                       ),
//                       const SizedBox(height: 16),
//                       _propertyImagesBytes.isNotEmpty
//                           ? Wrap(
//                               spacing: 8,
//                               runSpacing: 8,
//                               children: _propertyImagesBytes
//                                   .map((b) => Image.memory(b,
//                                       height: 100,
//                                       width: 100,
//                                       fit: BoxFit.cover))
//                                   .toList(),
//                             )
//                           : _propertyImagesFiles.isNotEmpty
//                               ? Wrap(
//                                   spacing: 8,
//                                   runSpacing: 8,
//                                   children: _propertyImagesFiles
//                                       .map((f) => Image.file(f,
//                                           height: 100,
//                                           width: 100,
//                                           fit: BoxFit.cover))
//                                       .toList(),
//                                 )
//                               : const Text('لم يتم اختيار صور'),
//                     ],
//                   ),
//                 ),
//               ),
//               Center(
//                 child: ElevatedButton.icon(
//                   onPressed: () async {
//                     bool success = await createProperty();

//                     if (!mounted) return;

//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text(success
//                             ? "✅ تم نشر العقار بنجاح"
//                             : "❌ فشل نشر العقار"),
//                         backgroundColor: success ? Colors.green : Colors.red,
//                       ),
//                     );
//                   },
//                   // onPressed: () {
//                   //   createProperty();
//                   //   print('bool Attributes = ${boolAttributes}\n');
//                   //   print('\nvalue Attributes = ${valueAttributes}');
//                   // },
//                   icon: const Icon(Icons.send),
//                   label: const Text('نشر العقار'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: primaryColor,
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 40, vertical: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // 🟢 Section Title
//   Widget _buildSectionTitle(String title) {
//     return Text(
//       title,
//       style: TextStyle(
//         fontWeight: FontWeight.bold,
//         fontSize: 18,
//         color: primaryColor,
//       ),
//     );
//   }

//   // 🟢 Card Wrapper
//   Widget _buildCard({required List<Widget> children}) {
//     return Card(
//       elevation: 3,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(children: children),
//       ),
//     );
//   }

//   // 🟢 Input Field
//   Widget _buildInput(
//       String label, TextEditingController controller, TextInputType inputType,
//       {Function(String)? onChanged}) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: TextField(
//         controller: controller,
//         keyboardType: inputType,
//         onChanged: onChanged,
//         decoration: InputDecoration(
//           labelText: label,
//           filled: true,
//           fillColor: Colors.grey.shade50,
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//         ),
//       ),
//     );
//   }

//   // 🟢 Dynamic Attributes
//   Widget _buildDynamicAttributes() {
//     if (selectedPropertyType == null) {
//       return const Text("اختر نوع العقار لعرض الصفات");
//     }
//     if (attributes.isEmpty) {
//       return const Text("لا يوجد صفات لهذا النوع");
//     }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: attributes.map((attr) {
//         switch (attr.type) {
//           case 'bool':
//             return SwitchListTile(
//               title: Text(attr.name),
//               value: boolAttributes[attr.id] ?? false,
//               activeColor: primaryColor,
//               onChanged: (val) {
//                 setState(() {
//                   boolAttributes[attr.id] = val;
//                 });
//               },
//             );
//           case 'string':
//             return _buildInput(
//               attr.name,
//               TextEditingController(text: valueAttributes[attr.id] ?? ''),
//               TextInputType.text,
//               onChanged: (val) {
//                 valueAttributes[attr.id] = val;
//               },
//             );
//           case 'number':
//             return _buildNumberSlider(attr.name, attr.id);
//           default:
//             return const SizedBox();
//         }
//       }).toList(),
//     );
//   }

//   // 🟢 Slider for numbers
//   Widget _buildNumberSlider(String label, String attrId) {
//     double currentValue =
//         valueAttributes[attrId] is double ? valueAttributes[attrId] : 0.0;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label,
//             style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//         Slider(
//           value: currentValue,
//           min: 0,
//           max: 100,
//           divisions: 100,
//           activeColor: primaryColor,
//           label: currentValue.round().toString(),
//           onChanged: (val) {
//             setState(() {
//               valueAttributes[attrId] = val;
//             });
//           },
//         ),
//         Align(
//           alignment: Alignment.center,
//           child: Text(
//             "القيمة: ${currentValue.round()}",
//             style: const TextStyle(fontWeight: FontWeight.w500),
//           ),
//         ),
//         const SizedBox(height: 12),
//       ],
//     );
//   }

//   Future<void> _uploadPropertyPhotos() async {
//     final List<XFile>? pickedFiles = await _picker.pickMultiImage();

//     if (pickedFiles != null && pickedFiles.isNotEmpty) {
//       if (kIsWeb) {
//         // للويب
//         List<Uint8List> webImages = [];
//         for (var file in pickedFiles) {
//           final bytes = await file.readAsBytes(); // <-- الطريقة الصحيحة
//           webImages.add(bytes);
//         }
//         setState(() {
//           _propertyImagesBytes = webImages;
//           _propertyImagesFiles.clear();
//         });
//       } else {
//         // للهاتف
//         List<io.File> mobileFiles =
//             pickedFiles.map((f) => io.File(f.path)).toList();
//         setState(() {
//           _propertyImagesFiles = mobileFiles;
//           _propertyImagesBytes.clear();
//         });
//       }
//     }
//   }

//   Future<bool> createProperty() async {
//     List<Map<String, dynamic>> allAttributes =
//         toAttributeList(boolAttributes, valueAttributes);

//     // نحدد الصور حسب المنصة
//     List<dynamic> photos = [];
//     if (_propertyImagesFiles.isNotEmpty) {
//       photos = _propertyImagesFiles; // للجوال
//     } else if (_propertyImagesBytes.isNotEmpty) {
//       photos = _propertyImagesBytes; // للويب
//     }

//     bool? status = await PropertyService().createProperty(
//       propertyNumber: propertyNumberController.text,
//       typeOperation: typeOperation,
//       space: double.tryParse(spaceController.text) ?? 0.0,
//       price: double.tryParse(priceController.text) ?? 0.0,
//       description: descriptionController.text,
//       propertyTypeId: selectedPropertyType!.id,
//       governorate: governorateController.text,
//       province: provinceController.text,
//       city: cityController.text,
//       street: streetController.text,
//       licenseType: licenseTypeController.text,
//       licenseNumber: licenseNumberController.text,
//       attributes: allAttributes,
//       propertyPhotos: photos,
//     );

//     return status!;
//   }

//   List<Map<String, dynamic>> toAttributeList(
//     Map<String, dynamic> boolAttributes,
//     Map<String, dynamic> valueAttributes,
//   ) {
//     List<Map<String, dynamic>> result = [];

//     // boolean attributes
//     boolAttributes.forEach((key, value) {
//       if (value == (false)) {
//         return;
//       }
//       result.add({
//         "attributeId": key,
//         "value": value.toString(),
//       });
//     });

//     // value attributes
//     valueAttributes.forEach((key, value) {
//       if (value == (0) || value == ("")) {
//         return;
//       }
//       result.add({
//         "attributeId": key,
//         "value": value.toString(),
//       });
//     });

//     return result;
//   }
// }
import 'dart:io' as io;
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:property_system/client/models/property_type_model.dart';
import 'package:property_system/client/services/property_service.dart';
import 'package:property_system/client/services/propety_Type_service.dart';
import 'package:property_system/l10n/app_localizations.dart';

class CreateProperty extends StatefulWidget {
  const CreateProperty({
    super.key,
  });

  @override
  State<CreateProperty> createState() => _CreatePropertyState();
}

class _CreatePropertyState extends State<CreateProperty> {
  final Color primaryColor = Colors.indigo.shade700;
  final Color backgroundColor = Colors.grey.shade100;

  PropertyTypeModel? selectedPropertyType;
  List<PropertyTypeModel>? propertyTypes = [];
  List<AttributesModel> attributes = [];

  Map<String, bool> boolAttributes = {};
  Map<String, dynamic> valueAttributes = {};

  final TextEditingController propertyNumberController =
      TextEditingController();
  final TextEditingController spaceController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController licenseTypeController = TextEditingController();
  final TextEditingController licenseNumberController = TextEditingController();
  final TextEditingController governorateController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  String typeOperation = 'selling';

  List<Uint8List> _propertyImagesBytes = [];
  List<io.File> _propertyImagesFiles = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    fetchPropertyTypesInfo();
  }

  void fetchPropertyTypesInfo() async {
    List<PropertyTypeModel>? fetchedPropertyTypesInfo =
        await PropertyTypeService().getPropertyTypes();

    setState(() {
      propertyTypes = fetchedPropertyTypesInfo;

      if (propertyTypes!.isNotEmpty) {
        selectedPropertyType = propertyTypes!.first;
        fetchAttributesForType(selectedPropertyType!.id);
      }
    });
  }

  void fetchAttributesForType(String typeId) async {
    List<AttributesModel> fetched = [];

    for (var pt in propertyTypes!) {
      if (pt.id == typeId) {
        fetched = pt.attributes;
      }
    }

    setState(() {
      attributes = fetched;
      boolAttributes.clear();
      valueAttributes.clear();
      for (var attr in attributes) {
        if (attr.type == 'bool') {
          boolAttributes[attr.id] = false;
        } else {
          valueAttributes[attr.id] = '';
        }
      }
    });
  }

  void _setTypeOperation(bool type) {
    if (type) {
      typeOperation = 'selling';
    } else {
      typeOperation = 'renting';
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(localizations.translate('publish_property')),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(localizations.translate('select_property_type')),
            const SizedBox(height: 10),
            Wrap(
              children: propertyTypes!.map((pt) {
                final isSelected = selectedPropertyType?.id == pt.id;
                return ChoiceChip(
                  label: Text(pt.name),
                  selected: isSelected,
                  selectedColor: Colors.green.shade300,
                  backgroundColor: Colors.grey.shade200,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  onSelected: (_) {
                    setState(() {
                      selectedPropertyType = pt;
                    });
                    fetchAttributesForType(pt.id);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 30),
                GestureDetector(
                  onTap: () {
                    _setTypeOperation(true);
                  },
                  child: Container(
                    height: 60,
                    width: 195,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 33, 135, 104),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            localizations.translate('sell'),
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Pacifico',
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.home, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                GestureDetector(
                  onTap: () {
                    _setTypeOperation(false);
                  },
                  child: Container(
                    height: 60,
                    width: 195,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 33, 135, 104),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            localizations.translate('rent'),
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Pacifico',
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.business, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            _buildSectionTitle(localizations.translate('basic_information')),
            const SizedBox(height: 10),
            _buildCard(
              children: [
                _buildInput(localizations.translate('property_number'),
                    propertyNumberController, TextInputType.text),
                _buildInput(localizations.translate('space'), spaceController,
                    TextInputType.number),
                _buildInput(localizations.translate('price'), priceController,
                    TextInputType.number),
                _buildInput(localizations.translate('description'),
                    descriptionController, TextInputType.text),
                _buildInput(localizations.translate('license_type'),
                    licenseTypeController, TextInputType.text),
                _buildInput(localizations.translate('license_number'),
                    licenseNumberController, TextInputType.text),
                _buildInput(localizations.translate('governorate'),
                    governorateController, TextInputType.text),
                _buildInput(localizations.translate('province'),
                    provinceController, TextInputType.text),
                _buildInput(
                    localizations.translate('city'), cityController, TextInputType.text),
                _buildInput(localizations.translate('street'), streetController,
                    TextInputType.text),
              ],
            ),
            const SizedBox(height: 20),
            _buildSectionTitle(localizations.translate('additional_attributes')),
            const SizedBox(height: 10),
            _buildCard(children: [_buildDynamicAttributes()]),
            const SizedBox(height: 30),
            _buildSectionTitle(localizations.translate('property_photos')),
            const SizedBox(height: 10),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    FloatingActionButton(
                      heroTag: 'propertyPhotosBtn',
                      mini: true,
                      onPressed: _uploadPropertyPhotos,
                      backgroundColor: primaryColor,
                      child: const Icon(Icons.add),
                    ),
                    const SizedBox(height: 16),
                    _propertyImagesBytes.isNotEmpty
                        ? Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: _propertyImagesBytes
                                .map((b) => Image.memory(b,
                                    height: 100, width: 100, fit: BoxFit.cover))
                                .toList(),
                          )
                        : _propertyImagesFiles.isNotEmpty
                            ? Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: _propertyImagesFiles
                                    .map((f) => Image.file(f,
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover))
                                    .toList(),
                              )
                            : Text(localizations.translate('no_picture_selected')),
                  ],
                ),
              ),
            ),
            Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  bool success = await createProperty();

                  if (!mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(success
                          ? localizations.translate('property_published_success')
                          : localizations.translate('property_published_failed')),
                      backgroundColor: success ? Colors.green : Colors.red,
                    ),
                  );
                },
                icon: const Icon(Icons.send),
                label: Text(localizations.translate('publish_property')),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: primaryColor,
      ),
    );
  }

  Widget _buildCard({required List<Widget> children}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(children: children),
      ),
    );
  }

  Widget _buildInput(
      String label, TextEditingController controller, TextInputType inputType,
      {Function(String)? onChanged}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey.shade50,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _buildDynamicAttributes() {
    final localizations = AppLocalizations.of(context)!;

    if (selectedPropertyType == null) {
      return Text(localizations.translate('select_property_type_prompt'));
    }
    if (attributes.isEmpty) {
      return Text(localizations.translate('no_attributes_for_type'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: attributes.map((attr) {
        switch (attr.type) {
          case 'bool':
            return SwitchListTile(
              title: Text(attr.name),
              value: boolAttributes[attr.id] ?? false,
              activeColor: primaryColor,
              onChanged: (val) {
                setState(() {
                  boolAttributes[attr.id] = val;
                });
              },
            );
          case 'string':
            return _buildInput(
              attr.name,
              TextEditingController(text: valueAttributes[attr.id] ?? ''),
              TextInputType.text,
              onChanged: (val) {
                valueAttributes[attr.id] = val;
              },
            );
          case 'number':
            return _buildNumberSlider(attr.name, attr.id);
          default:
            return const SizedBox();
        }
      }).toList(),
    );
  }

  Widget _buildNumberSlider(String label, String attrId) {
    final localizations = AppLocalizations.of(context)!;

    double currentValue =
        valueAttributes[attrId] is double ? valueAttributes[attrId] : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Slider(
          value: currentValue,
          min: 0,
          max: 100,
          divisions: 100,
          activeColor: primaryColor,
          label: currentValue.round().toString(),
          onChanged: (val) {
            setState(() {
              valueAttributes[attrId] = val;
            });
          },
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            "${localizations.translate('value_label')}: ${currentValue.round()}",
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Future<void> _uploadPropertyPhotos() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();

    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      if (kIsWeb) {
        List<Uint8List> webImages = [];
        for (var file in pickedFiles) {
          final bytes = await file.readAsBytes();
          webImages.add(bytes);
        }
        setState(() {
          _propertyImagesBytes = webImages;
          _propertyImagesFiles.clear();
        });
      } else {
        List<io.File> mobileFiles =
            pickedFiles.map((f) => io.File(f.path)).toList();
        setState(() {
          _propertyImagesFiles = mobileFiles;
          _propertyImagesBytes.clear();
        });
      }
    }
  }

  Future<bool> createProperty() async {
    List<Map<String, dynamic>> allAttributes =
        toAttributeList(boolAttributes, valueAttributes);

    List<dynamic> photos = [];
    if (_propertyImagesFiles.isNotEmpty) {
      photos = _propertyImagesFiles;
    } else if (_propertyImagesBytes.isNotEmpty) {
      photos = _propertyImagesBytes;
    }

    bool? status = await PropertyService().createProperty(
      propertyNumber: propertyNumberController.text,
      typeOperation: typeOperation,
      space: double.tryParse(spaceController.text) ?? 0.0,
      price: double.tryParse(priceController.text) ?? 0.0,
      description: descriptionController.text,
      propertyTypeId: selectedPropertyType!.id,
      governorate: governorateController.text,
      province: provinceController.text,
      city: cityController.text,
      street: streetController.text,
      licenseType: licenseTypeController.text,
      licenseNumber: licenseNumberController.text,
      attributes: allAttributes,
      propertyPhotos: photos,
    );

    return status!;
  }

  List<Map<String, dynamic>> toAttributeList(
    Map<String, dynamic> boolAttributes,
    Map<String, dynamic> valueAttributes,
  ) {
    List<Map<String, dynamic>> result = [];

    boolAttributes.forEach((key, value) {
      if (value == (false)) {
        return;
      }
      result.add({
        "attributeId": key,
        "value": value.toString(),
      });
    });

    valueAttributes.forEach((key, value) {
      if (value == (0) || value == ("")) {
        return;
      }
      result.add({
        "attributeId": key,
        "value": value.toString(),
      });
    });

    return result;
  }
}
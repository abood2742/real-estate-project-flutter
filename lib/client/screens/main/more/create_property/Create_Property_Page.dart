import 'dart:io' as io;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:property_system/client/components/Build_Dynamic_Attributes/Custom_Card.dart';
import 'package:property_system/client/components/Build_Dynamic_Attributes/Custom_DropDown_List.dart';
import 'package:property_system/client/components/Build_Dynamic_Attributes/Custom_Input.dart';
import 'package:property_system/client/components/Build_Dynamic_Attributes/Custom_Select_Button.dart';
import 'package:property_system/client/components/Build_Dynamic_Attributes/Dynamic_Attributes.dart';
import 'package:property_system/client/components/Build_Dynamic_Attributes/Types_Of_Property_Types.dart';
import 'package:property_system/client/models/property_type_model.dart';
import 'package:property_system/client/services/property_service.dart';
import 'package:property_system/client/services/propety_Type_service.dart';

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

  List<String> typesOfPropertyTypes = [
    "residential",
    "commercial",
    "industrial",
    "agricultural"
  ];
  String selectedTypeOfPropertyTypes = 'residential'; // القيمة الافتراضية

  List<PropertyTypeModel>? propertyTypes = [];
  PropertyTypeModel? selectedPropertyType;

  final Map<String, IconData> propertyTypeIcons = {
    "Apartment": Icons.apartment,
    "Hotel": Icons.hotel,
    "Villa": Icons.villa,
    "Resturant": Icons.restaurant,
  };

  String typeOperation = 'selling';

  final TextEditingController propertyNumberController =
      TextEditingController();
  final TextEditingController spaceController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

final List<String> licenseTypes = [
  "Residential Permit", // سكني
  "Commercial Permit",  // تجاري
  "Agricultural Permit",// زراعي
  "Industrial Permit",  // صناعي
];
  String? selectedLicenseType;

  final TextEditingController licenseNumberController = TextEditingController();
  final TextEditingController governorateController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController streetController = TextEditingController();

  List<AttributesModel> attributes = [];
  Map<String, bool> boolAttributes = {};
  Map<String, dynamic> valueAttributes = {};

  List<Uint8List> _propertyImagesBytes = []; // للويب
  List<io.File> _propertyImagesFiles = []; // للهاتف
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    fetchPropertyTypesInfo();
    // ✅ اجعل أول نوع مفعل افتراضياً
    selectedTypeOfPropertyTypes = typesOfPropertyTypes.first;
  }

  void fetchPropertyTypesInfo() async {
    List<PropertyTypeModel>? fetchedPropertyTypesInfo =
        await PropertyTypeService().getPropertyTypes();

    setState(() {
      propertyTypes = fetchedPropertyTypesInfo;

      if (propertyTypes!.isNotEmpty) {
        // ✅ اجعل أول نوع فرعي (propertyType) مختار
        final filteredProps = propertyTypes!
            .where((p) => p.type == selectedTypeOfPropertyTypes)
            .toList();

        if (filteredProps.isNotEmpty) {
          selectedPropertyType = filteredProps.first;
          fetchAttributesForType(selectedPropertyType!.id);
        }
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
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('📝 نشر عقار'),
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
              _buildSectionTitle("اختر نوع العقار"),
              const SizedBox(height: 10),

              // ------------------ نوع العقار ------------------
              PropertyTypeSelector(
                typesOfPropertyTypes: typesOfPropertyTypes,
                selectedType: selectedTypeOfPropertyTypes,
                onTypeSelected: (type) {
                  setState(() {
                    selectedTypeOfPropertyTypes = type;

                    final filteredProps =
                        propertyTypes?.where((p) => p.type == type).toList() ??
                            [];

                    if (filteredProps.isNotEmpty) {
                      // ✅ اجعل أول نوع فرعي مفعل افتراضياً
                      selectedPropertyType = filteredProps.first;
                      fetchAttributesForType(selectedPropertyType!.id);
                    }
                  });
                },
              ),
              // ------------------ العقارات التابعة للنوع ------------------
              if (propertyTypes != null &&
                  propertyTypes!
                      .any((p) => p.type == selectedTypeOfPropertyTypes)) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: propertyTypes!
                          .where((p) => p.type == selectedTypeOfPropertyTypes)
                          .length,
                      itemBuilder: (context, index) {
                        final props = propertyTypes!
                            .where((p) => p.type == selectedTypeOfPropertyTypes)
                            .toList();
                        return _buildSelectablePropertyType(props[index].name);
                      },
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomSelectButton(
                    label: 'بيع',
                    isSelected: typeOperation == 'selling',
                    onPressed: () {
                      setState(() {
                        _setTypeOperation(true);
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  CustomSelectButton(
                    label: 'تأجير',
                    isSelected: typeOperation == 'renting',
                    onPressed: () {
                      setState(() {
                        _setTypeOperation(false);
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 15),
              _buildSectionTitle("البيانات الأساسية"),
              const SizedBox(height: 10),
              CustomCard(
                children: [
                  CustomInput(
                      label: "رقم العقار",
                      controller: propertyNumberController,
                      keyboardType: TextInputType.text),
                  CustomInput(
                      label: "المساحة",
                      controller: spaceController,
                      keyboardType: TextInputType.number),
                  CustomInput(
                      label: "السعر",
                      controller: priceController,
                      keyboardType: TextInputType.number),
                  CustomInput(
                      label: "الوصف",
                      controller: descriptionController,
                      keyboardType: TextInputType.text),
                  LicenseTypeDropdown(
                    selectedValue: selectedLicenseType,
                    onChanged: (value) {
                      setState(() {
                        selectedLicenseType = value;
                      });
                    },
                    items: licenseTypes,
                    hint: 'اختر نوع الرخصة',
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomInput(
                      label: "رقم الرخصة",
                      controller: licenseNumberController,
                      keyboardType: TextInputType.text),
                  CustomInput(
                      label: "المحافظة",
                      controller: governorateController,
                      keyboardType: TextInputType.text),
                  CustomInput(
                      label: "المديرية",
                      controller: provinceController,
                      keyboardType: TextInputType.text),
                  CustomInput(
                      label: "المدينة",
                      controller: cityController,
                      keyboardType: TextInputType.text),
                  CustomInput(
                      label: "الشارع",
                      controller: streetController,
                      keyboardType: TextInputType.text),
                ],
              ),
              const SizedBox(height: 20),
              _buildSectionTitle("الصفات الإضافية"),
              const SizedBox(height: 10),
              CustomCard(
                children: [
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
                  )
                ],
              ),

              const SizedBox(height: 30),
              // داخل build، عرض الصور المرفوعة
              _buildSectionTitle("صور العقار"),
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
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover))
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
                              : const Text('لم يتم اختيار صور'),
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
                            ? "✅ تم نشر العقار بنجاح"
                            : "❌ فشل نشر العقار"),
                        backgroundColor: success ? Colors.green : Colors.red,
                      ),
                    );
                  },
                  icon: const Icon(Icons.send),
                  label: const Text('نشر العقار'),
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
      ),
    );
  }

  Widget _buildSelectablePropertyType(String name) {
    final isSelected =
        selectedPropertyType != null && selectedPropertyType!.name == name;

    return Container(
      margin: const EdgeInsets.all(6),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected
              ? const Color.fromARGB(255, 21, 129, 217)
              : Colors.grey[300],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          minimumSize: const Size(100, 100),
          padding: EdgeInsets.zero,
        ),
        onPressed: () {
          setState(() {
            if (!isSelected) {
              final selectedProp =
                  propertyTypes!.firstWhere((p) => p.name == name);
              selectedPropertyType = selectedProp;
              fetchAttributesForType(selectedProp.id);
            }
            // ❌ منع إلغاء الاختيار
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              propertyTypeIcons[name] ?? Icons.home,
              color: isSelected ? Colors.white : Colors.black,
              size: 30,
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontFamily: 'Pacifico',
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  // 🟢 Section Title
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

  Future<void> _uploadPropertyPhotos() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();

    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      if (kIsWeb) {
        // للويب
        List<Uint8List> webImages = [];
        for (var file in pickedFiles) {
          final bytes = await file.readAsBytes(); // <-- الطريقة الصحيحة
          webImages.add(bytes);
        }
        setState(() {
          _propertyImagesBytes = webImages;
          _propertyImagesFiles.clear();
        });
      } else {
        // للهاتف
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

    // نحدد الصور حسب المنصة
    List<dynamic> photos = [];
    if (_propertyImagesFiles.isNotEmpty) {
      photos = _propertyImagesFiles; // للجوال
    } else if (_propertyImagesBytes.isNotEmpty) {
      photos = _propertyImagesBytes; // للويب
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
      licenseType: selectedLicenseType!,
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

    // boolean attributes
    boolAttributes.forEach((key, value) {
      if (value == (false)) {
        return;
      }
      result.add({
        "attributeId": key,
        "value": value.toString(),
      });
    });

    // value attributes
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


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
import 'package:property_system/client/models/LicenseType_model.dart';
import 'package:property_system/client/models/property_type_model.dart';
import 'package:property_system/client/services/License_service_done.dart';
import 'package:property_system/client/services/property_service_done.dart';
import 'package:property_system/client/services/propety_Type_service_done.dart';
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

  List<String> typesOfPropertyTypes = [
    "residential",
    "commercial",
    "industrial",
    "agricultural"
  ];
  String selectedTypeOfPropertyTypes = 'residential';

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
  final TextEditingController ownerController = TextEditingController();
  final TextEditingController spaceController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  List<LicensetypeModel> licenseTypes = [];
  String? selectedLicenseType;

  final TextEditingController licenseNumberController = TextEditingController();
  final TextEditingController governorateController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController streetController = TextEditingController();

  List<AttributesModel> attributes = [];
  Map<String, bool> boolAttributes = {};
  Map<String, dynamic> valueAttributes = {};

  List<Uint8List> _propertyImagesBytes = [];
  List<io.File> _propertyImagesFiles = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    fetchPropertyTypesInfo();
    selectedTypeOfPropertyTypes = typesOfPropertyTypes.first;
  }

  void fetchPropertyTypesInfo() async {
    List<PropertyTypeModel>? fetchedPropertyTypesInfo =
        await PropertyTypeService().getPropertyTypes();

    List<LicensetypeModel>? fetchedLicensceTypesInfo =
        await LicenseService().getAllLicenseTypes();

    setState(() {
      propertyTypes = fetchedPropertyTypesInfo;
      licenseTypes = fetchedLicensceTypesInfo!;

      if (propertyTypes!.isNotEmpty) {
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
        if (attr.type == 'boolean') {
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
        title: Text(localizations.translate('publish_property'),style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Directionality(
        textDirection: localizations.translate('text_direction') == 'rtl'
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle(localizations.translate('select_property_type')),
              const SizedBox(height: 10),
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
                      selectedPropertyType = filteredProps.first;
                      fetchAttributesForType(selectedPropertyType!.id);
                    }
                  });
                },
              ),
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
                    label: localizations.translate('selling'),
                    isSelected: typeOperation == 'selling',
                    onPressed: () {
                      setState(() {
                        _setTypeOperation(true);
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  CustomSelectButton(
                    label: localizations.translate('renting'),
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
              _buildSectionTitle(localizations.translate('basic_information')),
              const SizedBox(height: 10),
              CustomCard(
                children: [
                  CustomInput(
                      label: localizations.translate('property_number'),
                      controller: propertyNumberController,
                      keyboardType: TextInputType.text),
                  CustomInput(
                      label: localizations.translate('owner_name'),
                      controller: ownerController,
                      keyboardType: TextInputType.text),
                  CustomInput(
                      label: localizations.translate('space'),
                      controller: spaceController,
                      keyboardType: TextInputType.number),
                  CustomInput(
                      label: localizations.translate('price'),
                      controller: priceController,
                      keyboardType: TextInputType.number),
                  CustomInput(
                      label: localizations.translate('description'),
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
                    hint: localizations.translate('select_license_type'),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomInput(
                      label: localizations.translate('license_number'),
                      controller: licenseNumberController,
                      keyboardType: TextInputType.text),
                  CustomInput(
                      label: localizations.translate('governorate'),
                      controller: governorateController,
                      keyboardType: TextInputType.text),
                  CustomInput(
                      label: localizations.translate('province'),
                      controller: provinceController,
                      keyboardType: TextInputType.text),
                  CustomInput(
                      label: localizations.translate('city'),
                      controller: cityController,
                      keyboardType: TextInputType.text),
                  CustomInput(
                      label: localizations.translate('street'),
                      controller: streetController,
                      keyboardType: TextInputType.text),
                ],
              ),
              const SizedBox(height: 20),
              _buildSectionTitle(localizations.translate('additional_attributes')),
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
              _buildSectionTitle(localizations.translate('property_images')),
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
                        child: const Icon(Icons.add,color: Colors.white,),
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
                              : Text(localizations.translate('no_images_selected')),
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
                        backgroundColor: success ? Colors.green : const Color.fromARGB(255, 255, 166, 159),
                      ),
                    );
                  },
                  label: Text(localizations.translate('publish_property_button',),style: TextStyle(color: Colors.white,fontFamily: 'Pacifico',fontSize: 16),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 156, 187),
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
              : Colors.white,
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
      owner: ownerController.text,
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

    final Map<String, String> idToName = {
      for (var attr in attributes) attr.id: attr.name,
    };

    boolAttributes.forEach((key, value) {
      if (value == false) return;
      result.add({
        "name": idToName[key] ?? key,
        "value": value.toString(),
      });
    });

    valueAttributes.forEach((key, value) {
      if (value == 0 || value == "") return;
      result.add({
        "name": idToName[key] ?? key,
        "value": value.toString(),
      });
    });

    return result;
  }
}

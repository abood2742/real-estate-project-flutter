// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:property_system/client/components/Build_Dynamic_Attributes/Custom_Select_Button.dart';
// import 'package:property_system/client/components/Build_Dynamic_Attributes/Custom_Card.dart';
// import 'package:property_system/client/components/Build_Dynamic_Attributes/Dynamic_Attributes.dart';
// import 'package:property_system/client/components/Build_Dynamic_Attributes/Types_Of_Property_Types.dart';
// import 'package:property_system/client/models/property_type_model.dart';
// import 'package:property_system/client/services/propety_Type_service_done.dart';

// class PropertyFilterPage extends StatefulWidget {
//   const PropertyFilterPage({super.key});

//   @override
//   State<PropertyFilterPage> createState() => _PropertyFilterPage();
// }

// class _PropertyFilterPage extends State<PropertyFilterPage> {
//   final Color primaryColor = Colors.indigo.shade700;
//   final Color backgroundColor = Colors.grey.shade100;

//   List<String> typesOfPropertyTypes = [
//     "residential",
//     "commercial",
//     "industrial",
//     "agricultural"
//   ];
//   String? selectedTypeOfPropertyTypes; // القيمة الافتراضية

//   List<PropertyTypeModel>? propertyTypes;

//   PropertyTypeModel? selectedPropertyType;

//   final Map<String, IconData> propertyTypeIcons = {
//     "Apartment": Icons.apartment,
//     "Hotel": Icons.hotel,
//     "Villa": Icons.villa,
//     "Resturant": Icons.restaurant,
//   };

//   String? typeOperation;

//   RangeValues priceRange = const RangeValues(0, 3000000000);
//   final TextEditingController minController = TextEditingController();
//   final TextEditingController maxController = TextEditingController();

//   RangeValues spaceRange = const RangeValues(10, 23000000);
//   final TextEditingController minAreaController = TextEditingController();
//   final TextEditingController maxAreaController = TextEditingController();

//   // Location
//   String governorate = "";
//   String province = "";
//   String city = "";
//   String street = "";

//   bool showAdvancedFilters = false;

//   List<AttributesModel> attributes = [];
//   Map<String, bool> boolAttributes = {};
//   Map<String, dynamic> valueAttributes = {};

//   @override
//   void initState() {
//     super.initState();
//     fetchPropertyTypesInfo();
//     minController.text = priceRange.start.toStringAsFixed(0);
//     maxController.text = priceRange.end.toStringAsFixed(0);
//   }

//   void fetchPropertyTypesInfo() async {
//     final fetchedPropertyTypesInfo =
//         await PropertyTypeService().getPropertyTypes();
//     setState(() {
//       propertyTypes = fetchedPropertyTypesInfo;
//     });
//   }

//   void _updateFromTextFields() {
//     final minVal = double.tryParse(minController.text) ?? 0;
//     final maxVal = double.tryParse(maxController.text) ?? 0;

//     // تأكد أن القيم صحيحة: الحد الأدنى أقل من الحد الأقصى
//     double newMin = minVal < maxVal ? minVal : priceRange.start;
//     double newMax = maxVal > minVal ? maxVal : priceRange.end;

//     setState(() {
//       priceRange = RangeValues(newMin, newMax);
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
//     typeOperation = type ? 'selling' : 'renting';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         body: ListView(
//           padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
//           children: [
//             const SizedBox(height: 10),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Container(
//                 height: 50,
//                 alignment: Alignment.centerRight,
//                 child: Lottie.asset(
//                   'assets/filter_amolation.json',
//                   repeat: true,
//                   animate: true,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//               child: Text(
//                 'اختر لتصفية العقارات',
//                 style: TextStyle(fontSize: 18, fontFamily: 'Pacifico'),
//                 textAlign: TextAlign.right,
//               ),
//             ),
//             const SizedBox(height: 30),

//             // ------------------ نوع العقار ------------------
//             PropertyTypeSelector(
//               typesOfPropertyTypes: typesOfPropertyTypes,
//               selectedType: selectedTypeOfPropertyTypes, // بدل ""
//               onTypeSelected: (type) {
//                 setState(() {
//                   if (selectedTypeOfPropertyTypes == type) {
//                     // إلغاء التحديد
//                     selectedTypeOfPropertyTypes = null;
//                     selectedPropertyType = null;
//                     attributes = [];
//                     boolAttributes.clear();
//                     valueAttributes.clear();
//                   } else {
//                     selectedTypeOfPropertyTypes = type;
//                     final filteredProps =
//                         propertyTypes?.where((p) => p.type == type).toList() ??
//                             [];
//                     if (filteredProps.isNotEmpty) {
//                       selectedPropertyType = null; // لا تختار شيء افتراضي
//                       attributes = [];
//                       boolAttributes.clear();
//                       valueAttributes.clear();
//                     }
//                   }
//                 });
//               },
//             ),

//             const SizedBox(height: 10),

//             // ------------------ العقارات التابعة للنوع ------------------
//             if (selectedTypeOfPropertyTypes != null &&
//                 propertyTypes != null &&
//                 propertyTypes!
//                     .any((p) => p.type == selectedTypeOfPropertyTypes)) ...[
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 child: SizedBox(
//                   height: 120,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: propertyTypes!
//                         .where((p) => p.type == selectedTypeOfPropertyTypes)
//                         .length,
//                     itemBuilder: (context, index) {
//                       final props = propertyTypes!
//                           .where((p) => p.type == selectedTypeOfPropertyTypes)
//                           .toList();
//                       return _buildSelectablePropertyType(props[index].name);
//                     },
//                   ),
//                 ),
//               ),
//             ],

//             // ------------------ نوع العملية ------------------
//             const Text(
//               'نوع العملية',
//               style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Color.fromARGB(255, 23, 88, 73),
//                   fontFamily: 'Pacifico'),
//               textAlign: TextAlign.right,
//             ),
//             const SizedBox(height: 10),

//             Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 24),
//                 child: Row(
//                   children: [
//                     CustomSelectButton(
//                       label: 'شراء',
//                       isSelected: typeOperation == 'selling',
//                       onPressed: () {
//                         setState(() {
//                           _setTypeOperation(true);
//                         });
//                       },
//                     ),
//                     const SizedBox(width: 10),
//                     CustomSelectButton(
//                       label: 'استإجار',
//                       isSelected: typeOperation == 'renting',
//                       onPressed: () {
//                         setState(() {
//                           _setTypeOperation(false);
//                         });
//                       },
//                     ),
//                   ],
//                 )),

//             const SizedBox(height: 10),
//             Container(height: 2, color: Colors.grey),

//             // Price Slider
//             const SizedBox(height: 16),
//             const Text("السعر (ليرة سورية)"),
//             RangeSlider(
//               values: priceRange,
//               min: 0,
//               max: 3000000000, // أقصى قيمة مسموحة
//               onChanged: (values) {
//                 setState(() {
//                   priceRange = values;
//                   minController.text = priceRange.start.toStringAsFixed(0);
//                   maxController.text = priceRange.end.toStringAsFixed(0);
//                 });
//               },
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 10),
//               child: Row(
//                 children: [
//                   Expanded(
//                   child: TextField(
//                     controller: minController,
//                     keyboardType: TextInputType.number,
//                     decoration: const InputDecoration(labelText: 'أقل سعر'),
//                     onChanged: (val) => _updateFromTextFields(),
//                   ),
//                 ),
//                   const SizedBox(width: 10),
//                   const Text('إلى', style: TextStyle(fontFamily: 'Pacifico')),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: TextField(
//                       controller: maxController,
//                       keyboardType: TextInputType.number,
//                       decoration: const InputDecoration(labelText: 'أعلى سعر'),
//                       onChanged: (val) => _updateFromTextFields(),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // Space Slider
//             const SizedBox(height: 16),
//             const Text("المساحة (بالمتر المربع)"),
//             RangeSlider(
//               values: spaceRange,
//               min: 10,
//               max: 23000000,
//               //divisions: 100,
//               labels: RangeLabels(
//                 spaceRange.start.toInt().toString(),
//                 spaceRange.end.toInt().toString(),
//               ),
//               onChanged: (values) => setState(() => spaceRange = values),
//             ),
//             const Padding(
//               padding: EdgeInsets.symmetric(vertical: 10),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(
//                         hintText: "0",
//                         filled: true,
//                         fillColor: Colors.white,
//                         border: OutlineInputBorder(
//                           borderSide:
//                               BorderSide(color: Colors.black, width: 1.5),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   Text('إلى', style: TextStyle(fontFamily: 'Pacifico')),
//                   SizedBox(width: 10),
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(
//                         hintText: " أكبر مساحة",
//                         filled: true,
//                         fillColor: Colors.white,
//                         border: OutlineInputBorder(
//                           borderSide:
//                               BorderSide(color: Colors.black, width: 1.5),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // Location Fields
//             const SizedBox(height: 16),
//             const Text("الموقع"),
//             TextField(
//               decoration: const InputDecoration(labelText: "المحافظة"),
//               onChanged: (val) => governorate = val,
//             ),
//             TextField(
//               decoration: const InputDecoration(labelText: "المديرية"),
//               onChanged: (val) => province = val,
//             ),
//             TextField(
//               decoration: const InputDecoration(labelText: "المدينة"),
//               onChanged: (val) => city = val,
//             ),
//             TextField(
//               decoration: const InputDecoration(labelText: "الشارع"),
//               onChanged: (val) => street = val,
//             ),

//             // ------------------ زر الفلاتر المتقدمة ------------------
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.white,
//                   foregroundColor: const Color.fromARGB(255, 23, 88, 73),
//                   side: const BorderSide(
//                       color: Color.fromARGB(255, 23, 88, 73), width: 1.5),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12)),
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     showAdvancedFilters = !showAdvancedFilters;
//                   });
//                 },
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       'الفلاتر المتقدمة',
//                       style: TextStyle(
//                         fontFamily: 'Pacifico',
//                         fontSize: 16,
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Icon(showAdvancedFilters
//                         ? Icons.keyboard_arrow_up
//                         : Icons.keyboard_arrow_down),
//                   ],
//                 ),
//               ),
//             ),

//             // ------------------ عرض الفلاتر المتقدمة ------------------
//             AnimatedCrossFade(
//               firstChild: const SizedBox.shrink(),
//               secondChild: CustomCard(
//                 children: [
//                   DynamicAttributes(
//                     attributes: attributes,
//                     boolAttributes: boolAttributes,
//                     valueAttributes: valueAttributes,
//                     primaryColor: primaryColor,
//                     onChanged: (id, val) {
//                       setState(() {
//                         if (val is bool) {
//                           boolAttributes[id] = val;
//                         } else {
//                           valueAttributes[id] = val;
//                         }
//                       });
//                     },
//                   )
//                 ],
//               ),
//               crossFadeState: showAdvancedFilters
//                   ? CrossFadeState.showSecond
//                   : CrossFadeState.showFirst,
//               duration: const Duration(milliseconds: 300),
//             ),

//             const SizedBox(height: 10),

//             // ------------------ أزرار البحث وإعادة التهيئة ------------------
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color.fromARGB(255, 23, 88, 73),
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       minimumSize: const Size.fromHeight(50), // ارتفاع الزر
//                     ),
//                     onPressed: () async {
//                       final Map<String, dynamic> filteredData =
//                           await getFilteredProperties();

//                       print(filteredData);

//                       // نذهب لصفحة البحث مع تمرير البيانات
//                       Navigator.pop(context, filteredData);
//                     },
//                     child: const Text(
//                       'بحث',
//                       style: TextStyle(
//                         fontFamily: 'Pacifico',
//                         color: Colors.white,
//                         fontSize: 18,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       minimumSize: const Size.fromHeight(50),
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         // إعادة النوع العام
//                         selectedTypeOfPropertyTypes = null;

//                         // إعادة النوع الفرعي
//                         selectedPropertyType = null;

//                         // تفريغ الخصائص
//                         attributes = [];
//                         boolAttributes.clear();
//                         valueAttributes.clear();

//                         // إعادة نوع العملية
//                         typeOperation = null;

//                         // إعادة القيم الرقمية
//                         priceRange = const RangeValues(0, 3000000000);
//                         spaceRange = const RangeValues(300, 23000000);

//                         // إعادة الحقول النصية
//                         governorate = "";
//                         province = "";
//                         city = "";
//                         street = "";

//                         // إخفاء الفلاتر المتقدمة
//                         showAdvancedFilters = false;
//                       });
//                     },
//                     child: const Text(
//                       'إعادة تهيئة',
//                       style: TextStyle(
//                         fontFamily: 'Pacifico',
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSelectablePropertyType(String name) {
//     final isSelected =
//         selectedPropertyType != null && selectedPropertyType!.name == name;

//     return Container(
//       margin: const EdgeInsets.all(6),
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: isSelected
//               ? const Color.fromARGB(255, 21, 129, 217)
//               : Colors.grey[300],
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           minimumSize: const Size(100, 100),
//           padding: EdgeInsets.zero,
//         ),
//         onPressed: () {
//           setState(() {
//             if (selectedPropertyType != null &&
//                 selectedPropertyType!.name == name) {
//               // إذا كان مختار -> ألغِ التحديد
//               selectedPropertyType = null;
//               attributes = [];
//               boolAttributes.clear();
//               valueAttributes.clear();
//             } else {
//               final selectedProp =
//                   propertyTypes!.firstWhere((p) => p.name == name);
//               fetchAttributesForType(selectedProp.id);
//               selectedPropertyType = selectedProp;
//             }
//           });
//         },
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               propertyTypeIcons[name] ?? Icons.home,
//               color: isSelected ? Colors.white : Colors.black,
//               size: 30,
//             ),
//             const SizedBox(height: 8),
//             Text(
//               name,
//               style: TextStyle(
//                 color: isSelected ? Colors.white : Colors.black,
//                 fontFamily: 'Pacifico',
//                 fontSize: 14,
//               ),
//               textAlign: TextAlign.center,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<Map<String, dynamic>> getFilteredProperties() async {
//     final Map<String, dynamic> filterData = {};

//     // النوع الفرعي والعام
//     if (selectedPropertyType != null) {
//       filterData["type"] = selectedPropertyType!.name;
//     }
//     if (selectedTypeOfPropertyTypes != null) {
//       filterData["typeOfPropertyType"] = selectedTypeOfPropertyTypes;
//     }

//     // نوع العملية
//     if (typeOperation != null) {
//       filterData["purpose"] = {typeOperation!: true};
//     }

//     // السعر والمساحة فقط إذا تغيرت عن الافتراضي
//     if (priceRange.start > 0 || priceRange.end < 3000000000) {
//       filterData["price"] = [
//         priceRange.start.toInt(),
//         priceRange.end.toInt(),
//       ];
//     }

//     if (spaceRange.start > 10 || spaceRange.end < 23000000) {
//       filterData["space"] = [
//         spaceRange.start.toInt(),
//         spaceRange.end.toInt(),
//       ];
//     }

//     // الفلاتر المتقدمة (attributes)
//     final attributeFilters = attributes
//         .map((attr) {
//           final val = attr.type == 'boolean'
//               ? boolAttributes[attr.id] == true
//                   ? "true"
//                   : null
//               : (valueAttributes[attr.id]?.toString().isNotEmpty ?? false)
//                   ? valueAttributes[attr.id].toString()
//                   : null;

//           if (val != null) {
//             return {"attribute": attr.name, "value": val};
//           }
//           return null;
//         })
//         .where((e) => e != null)
//         .toList();

//     if (attributeFilters.isNotEmpty) {
//       filterData["attributeFilters"] = attributeFilters;
//     }

//     // الموقع
//     final location = <String, String>{};
//     if (governorate.isNotEmpty) location["governorate"] = governorate;
//     if (province.isNotEmpty) location["province"] = province;
//     if (city.isNotEmpty) location["city"] = city;
//     if (street.isNotEmpty) location["street"] = street;

//     if (location.isNotEmpty) filterData["location"] = location;

//     return filterData;
//   }
// }
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:property_system/client/components/Build_Dynamic_Attributes/Custom_Select_Button.dart';
import 'package:property_system/client/components/Build_Dynamic_Attributes/Custom_Card.dart';
import 'package:property_system/client/components/Build_Dynamic_Attributes/Dynamic_Attributes.dart';
import 'package:property_system/client/components/Build_Dynamic_Attributes/Types_Of_Property_Types.dart';
import 'package:property_system/client/models/property_type_model.dart';
import 'package:property_system/client/services/propety_Type_service_done.dart';
import 'package:property_system/l10n/app_localizations.dart';

class PropertyFilterPage extends StatefulWidget {
  const PropertyFilterPage({super.key});

  @override
  State<PropertyFilterPage> createState() => _PropertyFilterPage();
}

class _PropertyFilterPage extends State<PropertyFilterPage> {
  final Color primaryColor = Colors.indigo.shade700;
  final Color backgroundColor = Colors.grey.shade100;

  List<String> typesOfPropertyTypes = [
    "residential",
    "commercial",
    "industrial",
    "agricultural"
  ];
  String? selectedTypeOfPropertyTypes; // القيمة الافتراضية

  List<PropertyTypeModel>? propertyTypes;

  PropertyTypeModel? selectedPropertyType;

  final Map<String, IconData> propertyTypeIcons = {
    "Apartment": Icons.apartment,
    "Hotel": Icons.hotel,
    "Villa": Icons.villa,
    "Resturant": Icons.restaurant,
  };

  String? typeOperation;

  RangeValues priceRange = const RangeValues(0, 3000000000);
  final TextEditingController minController = TextEditingController();
  final TextEditingController maxController = TextEditingController();

  RangeValues spaceRange = const RangeValues(10, 23000000);
  final TextEditingController minAreaController = TextEditingController();
  final TextEditingController maxAreaController = TextEditingController();

  // Location
  String governorate = "";
  String province = "";
  String city = "";
  String street = "";

  bool showAdvancedFilters = false;

  List<AttributesModel> attributes = [];
  Map<String, bool> boolAttributes = {};
  Map<String, dynamic> valueAttributes = {};

  @override
  void initState() {
    super.initState();
    fetchPropertyTypesInfo();
    minController.text = priceRange.start.toStringAsFixed(0);
    maxController.text = priceRange.end.toStringAsFixed(0);
  }

  void fetchPropertyTypesInfo() async {
    final fetchedPropertyTypesInfo =
        await PropertyTypeService().getPropertyTypes();
    setState(() {
      propertyTypes = fetchedPropertyTypesInfo;
    });
  }

  void _updateFromTextFields() {
    final minVal = double.tryParse(minController.text) ?? 0;
    final maxVal = double.tryParse(maxController.text) ?? 0;

    // تأكد أن القيم صحيحة: الحد الأدنى أقل من الحد الأقصى
    double newMin = minVal < maxVal ? minVal : priceRange.start;
    double newMax = maxVal > minVal ? maxVal : priceRange.end;

    setState(() {
      priceRange = RangeValues(newMin, newMax);
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
    typeOperation = type ? 'selling' : 'renting';
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Directionality(
      textDirection: localizations.translate('text_direction') == 'rtl'
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 50,
                alignment: Alignment.centerRight,
                child: Lottie.asset(
                  'assets/filter_amolation.json',
                  repeat: true,
                  animate: true,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                localizations.translate('filter_properties'),
                style: const TextStyle(fontSize: 18, fontFamily: 'Pacifico',color: Colors.blue),
                textAlign: TextAlign.right,
              ),
            ),
            const SizedBox(height: 30),

            // ------------------ نوع العقار ------------------
            PropertyTypeSelector(
              typesOfPropertyTypes: typesOfPropertyTypes,
              selectedType: selectedTypeOfPropertyTypes,
              onTypeSelected: (type) {
                setState(() {
                  if (selectedTypeOfPropertyTypes == type) {
                    selectedTypeOfPropertyTypes = null;
                    selectedPropertyType = null;
                    attributes = [];
                    boolAttributes.clear();
                    valueAttributes.clear();
                  } else {
                    selectedTypeOfPropertyTypes = type;
                    final filteredProps =
                        propertyTypes?.where((p) => p.type == type).toList() ??
                            [];
                    if (filteredProps.isNotEmpty) {
                      selectedPropertyType = null;
                      attributes = [];
                      boolAttributes.clear();
                      valueAttributes.clear();
                    }
                  }
                });
              },
            ),

            const SizedBox(height: 10),

            // ------------------ العقارات التابعة للنوع ------------------
            if (selectedTypeOfPropertyTypes != null &&
                propertyTypes != null &&
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

            // ------------------ نوع العملية ------------------
            Text(
              localizations.translate('operation_type'),
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 23, 88, 73),
                  fontFamily: 'Pacifico'),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 10),

            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
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
                )),

            const SizedBox(height: 10),
            Container(height: 2, color: Colors.grey),

            // Price Slider
            const SizedBox(height: 16),
            Text(localizations.translate('price_syp')),
            RangeSlider(
              values: priceRange,
              min: 0,
              max: 3000000000,
              onChanged: (values) {
                setState(() {
                  priceRange = values;
                  minController.text = priceRange.start.toStringAsFixed(0);
                  maxController.text = priceRange.end.toStringAsFixed(0);
                });
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: minController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: localizations.translate('min_price')),
                      onChanged: (val) => _updateFromTextFields(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(localizations.translate('to'), style: TextStyle(fontFamily: 'Pacifico')),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: maxController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: localizations.translate('max_price')),
                      onChanged: (val) => _updateFromTextFields(),
                    ),
                  ),
                ],
              ),
            ),

            // Space Slider
            const SizedBox(height: 16),
            Text(localizations.translate('space_m2')),
            RangeSlider(
              values: spaceRange,
              min: 10,
              max: 23000000,
              labels: RangeLabels(
                spaceRange.start.toInt().toString(),
                spaceRange.end.toInt().toString(),
              ),
              onChanged: (values) => setState(() => spaceRange = values),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "0",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1.5),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text('إلى', style: TextStyle(fontFamily: 'Pacifico')),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "أكبر مساحة",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1.5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Location Fields
            const SizedBox(height: 16),
            Text(localizations.translate('location')),
            TextField(
              decoration: InputDecoration(labelText: localizations.translate('governorate')),
              onChanged: (val) => governorate = val,
            ),
            TextField(
              decoration: InputDecoration(labelText: localizations.translate('province')),
              onChanged: (val) => province = val,
            ),
            TextField(
              decoration: InputDecoration(labelText: localizations.translate('city')),
              onChanged: (val) => city = val,
            ),
            TextField(
              decoration: InputDecoration(labelText: localizations.translate('street')),
              onChanged: (val) => street = val,
            ),

            // ------------------ زر الفلاتر المتقدمة ------------------
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color.fromARGB(255, 23, 88, 73),
                  side: const BorderSide(color: Color.fromARGB(255, 23, 88, 73), width: 1.5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  setState(() {
                    showAdvancedFilters = !showAdvancedFilters;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      localizations.translate('advanced_filters'),
                      style: const TextStyle(fontFamily: 'Pacifico', fontSize: 16),
                    ),
                    const SizedBox(width: 8),
                    Icon(showAdvancedFilters ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
                  ],
                ),
              ),
            ),

            // ------------------ عرض الفلاتر المتقدمة ------------------
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: CustomCard(
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
              crossFadeState: showAdvancedFilters
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),

            const SizedBox(height: 10),

            // ------------------ أزرار البحث وإعادة التهيئة ------------------
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 23, 88, 73),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: () async {
                      final Map<String, dynamic> filteredData =
                          await getFilteredProperties();
                      print(filteredData);
                      Navigator.pop(context, filteredData);
                    },
                    child: Text(
                      localizations.translate('search'),
                      style: const TextStyle(
                        fontFamily: 'Pacifico',
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedTypeOfPropertyTypes = null;
                        selectedPropertyType = null;
                        attributes = [];
                        boolAttributes.clear();
                        valueAttributes.clear();
                        typeOperation = null;
                        priceRange = const RangeValues(0, 3000000000);
                        spaceRange = const RangeValues(10, 23000000);
                        governorate = "";
                        province = "";
                        city = "";
                        street = "";
                        showAdvancedFilters = false;
                      });
                    },
                    child: Text(
                      localizations.translate('reset'),
                      style: const TextStyle(
                        fontFamily: 'Pacifico',
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
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
            if (selectedPropertyType != null &&
                selectedPropertyType!.name == name) {
              selectedPropertyType = null;
              attributes = [];
              boolAttributes.clear();
              valueAttributes.clear();
            } else {
              final selectedProp =
                  propertyTypes!.firstWhere((p) => p.name == name);
              fetchAttributesForType(selectedProp.id);
              selectedPropertyType = selectedProp;
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

  Future<Map<String, dynamic>> getFilteredProperties() async {
    final Map<String, dynamic> filterData = {};

    if (selectedPropertyType != null) {
      filterData["type"] = selectedPropertyType!.name;
    }
    if (selectedTypeOfPropertyTypes != null) {
      filterData["typeOfPropertyType"] = selectedTypeOfPropertyTypes;
    }

    if (typeOperation != null) {
      filterData["purpose"] = {typeOperation!: true};
    }

    if (priceRange.start > 0 || priceRange.end < 3000000000) {
      filterData["price"] = [
        priceRange.start.toInt(),
        priceRange.end.toInt(),
      ];
    }

    if (spaceRange.start > 10 || spaceRange.end < 23000000) {
      filterData["space"] = [
        spaceRange.start.toInt(),
        spaceRange.end.toInt(),
      ];
    }

    final attributeFilters = attributes
        .map((attr) {
          final val = attr.type == 'boolean'
              ? boolAttributes[attr.id] == true
                  ? "true"
                  : null
              : (valueAttributes[attr.id]?.toString().isNotEmpty ?? false)
                  ? valueAttributes[attr.id].toString()
                  : null;

          if (val != null) {
            return {"attribute": attr.name, "value": val};
          }
          return null;
        })
        .where((e) => e != null)
        .toList();

    if (attributeFilters.isNotEmpty) {
      filterData["attributeFilters"] = attributeFilters;
    }

    final location = <String, String>{};
    if (governorate.isNotEmpty) location["governorate"] = governorate;
    if (province.isNotEmpty) location["province"] = province;
    if (city.isNotEmpty) location["city"] = city;
    if (street.isNotEmpty) location["street"] = street;

    if (location.isNotEmpty) filterData["location"] = location;

    return filterData;
  }
}

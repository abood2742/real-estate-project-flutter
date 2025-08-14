import 'package:flutter/material.dart';
import 'package:property_system/client/models/Prooerty_Type_model.dart';
import 'package:property_system/client/screens/more/create_property/post_property2.dart';
import 'package:property_system/client/services/propety_Type_service.dart';

class PropertyTypesPage extends StatefulWidget {
  const PropertyTypesPage({super.key});

  @override
  State<PropertyTypesPage> createState() => _PropertyTypesPageState();
}

class _PropertyTypesPageState extends State<PropertyTypesPage>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  List<PropertyTypeModel>? propertyTypes;

  @override
  void initState() {
    super.initState();
    getPropertyTypes();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('اختر نوع العقار'),
          centerTitle: true,
        ),
        body: propertyTypes == null
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.2,
                ),
                itemCount: propertyTypes!.length,
                itemBuilder: (context, index) {
                  final type = propertyTypes![index];

                  return AnimatedBuilder(
                    animation: _controllers[index],
                    builder: (context, child) {
                      final animationValue = _controllers[index].value;
                      return Transform.translate(
                        offset: Offset(0, 50 * (1 - animationValue)),
                        child: Opacity(
                          opacity: animationValue,
                          child: child,
                        ),
                      );
                    },
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return PostProperty2(propertyTypeId: type.id,);
                        }));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _getIconForType(type.name),
                              size: 40,
                              color: Colors.blue,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              type.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  /// خريطة تحدد الأيقونة لكل نوع
  final Map<String, IconData> _iconsMap = {
    'house': Icons.house,
    'Aprtment': Icons.apartment,
    'Terrain': Icons.terrain,
    'Villa': Icons.villa,
    'agriculture': Icons.agriculture,
    'Hotel': Icons.hotel,
    'Resturant': Icons.restaurant,

  };

  Future<void> getPropertyTypes() async {
    propertyTypes = await PropertyTypeService().getPropertyTypes();

    // نعمل الكونترولرز بعد ما تجينا البيانات
    _controllers = List.generate(
      propertyTypes!.length,
      (index) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400),
      ),
    );

    setState(() {});

    // تشغيل الأنيميشن
    Future.delayed(const Duration(milliseconds: 200), () {
      for (int i = 0; i < _controllers.length; i++) {
        Future.delayed(Duration(milliseconds: i * 100), () {
          if (mounted) _controllers[i].forward();
        });
      }
    });
  }

  @override
  void dispose() {
    if (propertyTypes != null) {
      for (var controller in _controllers) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  IconData _getIconForType(String typeName) {
    return _iconsMap[typeName] ??
        Icons.home; // أيقونة افتراضية إذا ما وُجد النوع
  }
}

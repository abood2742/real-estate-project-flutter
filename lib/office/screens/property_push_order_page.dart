
import 'package:flutter/material.dart';
import 'package:property_system/office/components/list_tile_component.dart';

class PropertyPushOrderPage extends StatelessWidget {
  const PropertyPushOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text(
          "مدوناتي ",
          style: TextStyle(color: Colors.white, fontFamily: 'Pacifico'),
        ),
      ),
      body: Column(
        children: [
          ListTileComponent(leading: '8/12/2024', title: ' شقة ', subtitle: 'ريف دمشق', trailing: 'محمد علي',),
          ListTileComponent(leading: '1/2/2014', title: ' بيت ', subtitle: ' دمشق', trailing: ' قاسم عباس',),
          ListTileComponent(leading: '8/2/2020', title: 'مطعم  ', subtitle: ' حمص', trailing: ' علي',),
        ],
      ),
    );
  }
}

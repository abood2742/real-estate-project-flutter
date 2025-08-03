import 'package:flutter/material.dart';
import 'package:property_system/user_type2/components/list_tile_component.dart';

class MyBlogsPage extends StatelessWidget {
  const MyBlogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          "طلبات رفع العقار",
          style: TextStyle(color: Colors.white, fontFamily: 'Pacifico'),
        ),
      ),
      body: Column(
        children: [
          ListTileComponent(leading: '8/12/2024', title: 'فرصة عقار فريدة', subtitle: 'ريف دمشق', trailing: 'محمد علي',),
          ListTileComponent(leading: '1/2/2014', title: ' عقار رخيص', subtitle: ' دمشق', trailing: ' قاسم عباس',),
          ListTileComponent(leading: '8/2/2020', title: 'فرصة  ', subtitle: ' حمص', trailing: ' علي',),
        ],
      ),
    );
  }
}

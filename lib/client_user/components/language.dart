import 'package:flutter/material.dart';

class Language extends StatelessWidget {
  const Language({super.key});

  void _showLanguageSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'اختر اللغة',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ListTile(
                leading: Text('🇸🇦', style: TextStyle(fontSize: 24)),
                title: Text('العربية', style: TextStyle(fontSize: 18)),
                onTap: () {
                  // هنا تغير اللغة إلى العربية
                  print("تم اختيار العربية");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Text('🇺🇸', style: TextStyle(fontSize: 24)),
                title: Text('English', style: TextStyle(fontSize: 18)),
                onTap: () {
                  // هنا تغير اللغة إلى الإنجليزية
                  print("English selected");
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        icon: Icon(Icons.language),
        label: Text('اللغة'),
        onPressed: () => _showLanguageSheet(context),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          textStyle: TextStyle(fontSize: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}

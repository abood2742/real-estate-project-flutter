import 'package:flutter/material.dart';
import 'package:property_system/client/screens/main/more/create_property/Create_Property_Page.dart';


class PostProperty1 extends StatelessWidget {
  final Color primaryColor = Color(0xFF1976D2); // أزرق أنيق
  final Color backgroundColor = Color(0xFFF4F6F8); // خلفية ناعمة
  final BorderRadius borderRadius = BorderRadius.circular(12);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'نشر عقار',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Pacifico'),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 10),
                _buildSmallInput(label: 'اسم المكتب', icon: Icons.business),
                SizedBox(height: 12),
                _buildSmallInput(label: 'حساب المكتب', icon: Icons.account_box),
                SizedBox(height: 20),
                Text(
                  'أرسل في البداية طلب الى المكتب للحصول على الموافقة و المتابعة',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Pacifico',
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  textAlign: TextAlign.right,
                ),
                SizedBox(height: 12),
                Text(
                  'أرسل هذه المعلومات مبدايا',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Pacifico',
                    color: Colors.grey[800],
                  ),
                  textAlign: TextAlign.right,
                ),
                SizedBox(height: 20),
                _buildFullInput(label: 'اسم العميل', icon: Icons.person),
                SizedBox(height: 12),
                _buildFullInput(
                  label: 'سعر العقار',
                  icon: Icons.attach_money,
                  isNumber: true,
                ),
                SizedBox(height: 12),
                _buildFullInput(label: 'مكان العقار', icon: Icons.location_on),
                SizedBox(height: 12),
                _buildFullInput(label: 'ما هو العقار', icon: Icons.home_work),
                SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CreateProperty();
                      }));
                    },
                    icon: Icon(Icons.send, color: Colors.white),
                    label:  Text(
                      'إرسال الطلب',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: borderRadius,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// حقل صغير للعرض الجزئي
  Widget _buildSmallInput({required String label, required IconData icon}) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: 200,
        child: TextField(
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(icon),
            border: OutlineInputBorder(borderRadius: borderRadius),
          ),
        ),
      ),
    );
  }

  /// حقل ممتد العرض
  Widget _buildFullInput({
    required String label,
    required IconData icon,
    bool isNumber = false,
  }) {
    return TextField(
      textAlign: TextAlign.right,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: borderRadius),
      ),
    );
  }
}

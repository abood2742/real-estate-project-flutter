import 'package:flutter/material.dart';

class PostProperty2 extends StatelessWidget {
  final Color primaryColor = Colors.indigo.shade700;
  final Color backgroundColor = Colors.grey.shade100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo, Colors.blueAccent],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'نشر عقار',
              style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'Pacifico',
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'تمت الموافقة على طلب النشر الذي أرسلته!!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Pacifico',
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 44, 67, 184)),
              ),
              SizedBox(height: 12),
              Text(
                'أدخل المعلومات اللازمة',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Pacifico',
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
              SizedBox(height: 24),

              // خانات إدخال الأرقام
              _buildInput(
                  label: 'عدد غرف النوم',
                  icon: Icons.bed,
                  inputType: TextInputType.number),
              _buildInput(
                  label: 'عدد الحمامات',
                  icon: Icons.shower,
                  inputType: TextInputType.number),
              _buildInput(
                  label: 'مساحة العقار',
                  icon: Icons.square_foot,
                  inputType: TextInputType.number),

              // خانات إدخال النصوص
              _buildInput(
                  label: 'غرض العقار',
                  icon: Icons.flag,
                  inputType: TextInputType.text),
              _buildInput(
                  label: 'نوع العقار',
                  icon: Icons.home_work,
                  inputType: TextInputType.text),

              SizedBox(height: 28),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: primaryColor,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FloatingActionButton(
                      mini: true,
                      backgroundColor: primaryColor,
                      onPressed: () {
                        print("إضافة صور");
                      },
                      child: Icon(Icons.add, color: Colors.white),
                    ),
                    SizedBox(width: 8),
                   const Text(
                      'إرفاق 4 صور ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Pacifico',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    print("تم النشر");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 5,
                  ),
                  child: Text(
                    'نشر',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput({
    required String label,
    required IconData icon,
    required TextInputType inputType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: primaryColor),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: primaryColor, width: 2),
          ),
        ),
      ),
    );
  }
}

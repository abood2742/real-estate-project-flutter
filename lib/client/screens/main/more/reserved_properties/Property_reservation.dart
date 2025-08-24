import 'package:flutter/material.dart';
import 'package:property_system/client/screens/main/more/reserved_properties/clent_reservation_status.dart';


class PropertyReservation extends StatelessWidget {
  const PropertyReservation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'حجز عقار',
          style: TextStyle(
              color: Colors.white, fontFamily: 'Pacifico', fontSize: 20),
        ),
        backgroundColor: const Color.fromARGB(255, 39, 84, 181),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView(
            children: [
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'أدخل معلومات بطاق الدفع الخاصة بك.',
                  style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 18,
                      color: const Color.fromARGB(255, 34, 69, 184)),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              _buildInput(
                  label: 'رقم البطاقة ',
                  icon: Icons.numbers,
                  inputType: TextInputType.text),
              _buildInput(
                  label: 'تاريخ الانتهاء  ',
                  icon: Icons.date_range,
                  inputType: TextInputType.text),
              _buildInput(
                  label: 'رمز الأمان  ',
                  icon: Icons.password,
                  inputType: TextInputType.text),
              _buildInput(
                  label: 'اسم صاحب البطاقة  ',
                  icon: Icons.person,
                  inputType: TextInputType.text),
              _buildInput(
                  label: 'حساب صاحب البطاقة  ',
                  icon: Icons.account_box,
                  inputType: TextInputType.text),
              SizedBox(
                height: 20,
              ),
              const Text(
                ' سيتم خصم قيمة %5 من سعر العقار عربون  ',
                style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 18,
                    color: const Color.fromARGB(255, 89, 103, 114)),
              ),
              const Text(
                ' علما انك تستطيع سحب العربون والغاء الحجز ما لم تتعدى الفترة المتاحة  ',
                style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 18,
                    color: const Color.fromARGB(255, 89, 103, 114)),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ClentReservationStatus();
                  }));
                },
                child: const Text(
                  'تأكيد ',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: 'Pacifico'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
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
        prefixIcon: Icon(icon, color: Colors.green),
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
          borderSide: BorderSide(color: Colors.green, width: 2),
        ),
      ),
    ),
  );
}

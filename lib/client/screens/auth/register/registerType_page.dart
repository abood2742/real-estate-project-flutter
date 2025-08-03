import 'package:flutter/material.dart';
import 'package:property_system/client/screens/main/main_page.dart';
import 'package:property_system/client/screens/auth/register/officeowener.dart';
import 'package:property_system/client/screens/auth/register/register1_page.dart';

class RegistertypePage extends StatelessWidget {
  const RegistertypePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'نوع التسجيل',
          style: TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 24,
            color: Color(0xFF4A3F91),
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFF4A3F91)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            const Text(
              'اختر نوع المستخدم للاستمرار',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 18,
                color: Color(0xFF555),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // مستخدم عادي ➜ استبدال الشاشة الحالية (لا رجوع)
            RegisterOptionCard(
              icon: Icons.person,
              label: 'مستخدم عادي',
              color: const Color(0xFF7B61FF),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) =>  Register1Page()),
                );
              },
            ),

            // صاحب مكتب ➜ استبدال الشاشة الحالية (لا رجوع)
            RegisterOptionCard(
              icon: Icons.business_center_outlined,
              label: 'صاحب مكتب',
              color: const Color(0xFF46A3FF),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) =>  OfficeOwner()),
                );
              },
            ),

            // زائر ➜ مسح كامل الـ stack
            RegisterOptionCard(
              icon: Icons.visibility_outlined,
              label: 'زائر',
              color: const Color(0xFF34C8A8),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const MainPage()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/* ———————————— كلاس البطاقة ———————————— */

class RegisterOptionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const RegisterOptionCard({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Material(
        color: Colors.white,
        elevation: 4,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: color.withOpacity(0.15),
                  child: Icon(icon, color: color),
                ),
                const SizedBox(width: 20),
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
                const Spacer(),
                const Icon(Icons.arrow_forward_ios_rounded,
                    color: Colors.grey, size: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

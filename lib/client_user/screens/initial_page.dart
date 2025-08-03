import 'package:flutter/material.dart';
import 'package:property_system/client_user/screens/auth/registerType_page.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
            child: Container(
              height: 400,
              width: 330,
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(24),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  'assets/images/init.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const Text(
            'Property System',
            style: TextStyle(
                fontFamily: 'Pacifico',
                color: const Color.fromARGB(255, 57, 15, 125),
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 50,
          ),
          const Text('The number 1 app for property ',
              style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 20,
                  color: Colors.lightBlue)),
          const Text('in syria and world',
              style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 20,
                  color: Colors.lightBlue)),
          const SizedBox(
            height: 100,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF1565C0), // لون أزرق داكن مخصص
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16), // حواف ناعمة
              ),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return RegistertypePage();
              }));
            },
            child: const Text(
              'Complete',
              style: TextStyle(
                fontFamily: 'Pacifico',
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

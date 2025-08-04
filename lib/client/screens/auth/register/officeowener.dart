import 'package:flutter/material.dart';
import 'package:property_system/client/screens/auth/login/login_page.dart';

class OfficeOwner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // خلفية بيضاء ناعمة
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Office Owner',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  'Enter this information',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              _buildTextField('Office Name', TextInputType.text),
              const SizedBox(height: 16),
              _buildTextField('Password', TextInputType.text, obscureText: true),
              const SizedBox(height: 16),
              _buildTextField('Number License', TextInputType.number),
              const SizedBox(height: 16),
              _buildTextField('Personal Identity Number', TextInputType.number),
              const SizedBox(height: 16),
              // _buildTextField('Office Location', TextInputType.text),
              // const SizedBox(height: 20),

              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FloatingActionButton(
                      mini: true,
                      onPressed: () {
                        print('تم الضغط على زر +');
                      },
                      backgroundColor: Colors.blue,
                      child: const Icon(Icons.add),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Lift the license',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueGrey[800],
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    FloatingActionButton(
                      mini: true,
                      onPressed: () {
                        print('تم الضغط على زر +');
                      },
                      backgroundColor: Colors.blue,
                      child: const Icon(Icons.add),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Lift the office photo',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueGrey[800],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              Center(
                child: ElevatedButton(
                  onPressed: () {
                    print('تم الضغط على Sign Up');
                    
                    // وظيفة التسجيل هنا
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.blue,
                    elevation: 4,
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'You already have an account?',
                    style: TextStyle(fontFamily: 'Pacifico'),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return LoginPage();
                      }));
                    },
                    child: const Text(
                      'Sign in',
                      style: TextStyle(
                        fontFamily: 'Pacifico',
                        color: Color.fromARGB(255, 14, 18, 95),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextInputType keyboardType,
      {bool obscureText = false}) {
    return TextField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.blueGrey[700]),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.blueGrey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
      ),
      cursorColor: Colors.blue,
      style: TextStyle(color: Colors.blueGrey[900]),
    );
  }
}

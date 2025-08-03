import 'package:flutter/material.dart';

class BlockPage extends StatelessWidget {
  const BlockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          const Text(
            'عذرا ان هذا الحساب محظور',
            textDirection: TextDirection.rtl,
            style: TextStyle(
              color: const Color.fromARGB(255, 37, 33, 148),
              fontFamily: 'Pacifico',
              fontSize: 24,
            ),
          ),
          const SizedBox(
          height: 100,
          ),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  'سبب الحظر ',
                  style: TextStyle(
                    color: Color.fromARGB(66, 5, 134, 63),
                    fontFamily: 'Pacifico',
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
               height: 20,
              ),
              Text(
                ' تعليق غير أخلاقي  ',
                style: TextStyle(
                  color: Color.fromARGB(255, 42, 46, 42),
                  fontFamily: 'Pacifico',
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const SizedBox(
           height: 100,
          ),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  'تاريخ الحظر ',
                  style: TextStyle(
                    color: Color.fromARGB(66, 5, 134, 63),
                    fontFamily: 'Pacifico',
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
              height: 20,
              ),
              Text(
                ' 8 / 8 / 2020 ',
                style: TextStyle(
                  color: Color.fromARGB(255, 42, 46, 42),
                  fontFamily: 'Pacifico',
                  fontSize: 20,
                ),
              ),
            ],
          ),
         const SizedBox(
           height: 200,
          ),
          GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 31, 37, 145),
                  borderRadius: BorderRadius.circular(16)),
            height : 50,
              width: 300,
              child: const Center(
                child: Text(
                  'تسجيل الدخول بحساب آخر',
                  style: TextStyle(
                      fontFamily: 'Pacifico',
                      color: Colors.white,
                      fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

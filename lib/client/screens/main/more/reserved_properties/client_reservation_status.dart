import 'package:flutter/material.dart';

class ClientReservationStatus extends StatelessWidget {
  const ClientReservationStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ' حالة الحجز ',
          style: TextStyle(
              color: Colors.white, fontFamily: 'Pacifico', fontSize: 20),
        ),
        backgroundColor: const Color.fromARGB(255, 72, 85, 114),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          children: [
            const SizedBox(
              height: 100,
            ),
            const Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                ' متبقي 2 يوم على انتهاء المدة المسموحة للحجز',
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontFamily: 'Pacifico',
                    fontSize: 16),
              ),
            ),
            const Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                ' أو الإلغاء  ',
                style: TextStyle(
                    color: Colors.black, fontFamily: 'Pacifico', fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 90),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.white,
                ),
                label: const Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: const Text(
                    "إلغاء",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 41, 47, 100),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

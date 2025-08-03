import 'package:flutter/material.dart';
import 'package:property_system/common/screens/client_change_password_page.dart';
import 'package:property_system/client/screens/more/profile/client_edit_information_page.dart';
import 'package:property_system/client/screens/more/notification/client_notification_page.dart';
import 'package:property_system/client/screens/property_listing_at_an_office_page.dart';
import 'package:property_system/client/screens/create_blog.dart';


class ClientProfile extends StatelessWidget {
  const ClientProfile({super.key});

  static const String fullName = " عبد الرحمن العلي ";
  static const String username = "obida5679Gmail.com";
  static const String phone = "0985129560";
  static const String location = " دمشق السيدة زينب";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 41, 47, 100),
        title: const Row(
          children: [
            const Text(
              "ملفي الشخصي",
              style: TextStyle(color: Colors.white, fontFamily: 'Pacifico'),
            ),
            SizedBox(
              width: 40,
            ),
            Text('🧾'),
          ],
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => Dialog(
                      backgroundColor: Colors.transparent,
                      insetPadding: const EdgeInsets.all(10),
                      child: InteractiveViewer(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/images/client.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.brown.shade300, width: 3),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 4),
                      ),
                    ],
                    image: const DecorationImage(
                      image: AssetImage('assets/images/client.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            _infoCard(title: "الاسم الكامل", value: fullName),
            _infoCard(title: " الحساب", value: username),
            _infoCard(title: "رقم الجوال", value: phone),
            _infoCard(title: "موقع المكتب", value: location),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ClientEditInformationPage();
                    }));
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  label: const Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: const Text(
                      "تعديل البيانات",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 41, 47, 100),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ClientChangePasswordPage();
                    }));
                  },
                  icon: const Icon(Icons.lock),
                  label: const Text("تغيير كلمة المرور"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 41, 47, 100),
                    side: const BorderSide(color: Colors.black),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ClientNotificationPage();
                    }));
                  },
                  icon: const Icon(Icons.upload_file),
                  label: const Text(
                    "طلبات رفع العقار",
                    style:
                        TextStyle(color: Colors.white, fontFamily: 'Pacifico'),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 41, 47, 100),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return PropertyListingAtAnOfficePage();
                    }));
                  },
                  icon: const Icon(Icons.article),
                  label: const Text(
                    "عرض عقار عند مكتب",
                    style:
                        TextStyle(color: Colors.white, fontFamily: 'Pacifico'),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 41, 47, 100),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CreateBlog();
                    }));
                  },
                  icon: const Icon(Icons.home),
                  label: const Text(
                    "العقارات المنتهية",
                    style:
                        TextStyle(color: Colors.white, fontFamily: 'Pacifico'),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 41, 47, 100),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ClientNotificationPage();
                  }));
                },
                icon: const Icon(Icons.notifications),
                label: const Text(
                  " الإشعارات ",
                  style: TextStyle(color: Colors.white, fontFamily: 'Pacifico'),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 41, 47, 100),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            // ElevatedButton.icon(
            //   onPressed: () {
            //     Navigator.push(context, MaterialPageRoute(builder: (context) {
            //       return ReservedPropertyPage();
            //     }));
            //   },
            //   icon: const Icon(Icons.home_work),
            //   label: const Text(
            //     "العقارات المحجوزة",
            //     style: TextStyle(color: Colors.white, fontFamily: 'Pacifico'),
            //   ),
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: const Color.fromARGB(255, 41, 47, 100),
            //     padding:
            //         const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(12),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard({required String title, required String value}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(title,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Pacifico',
                color: Colors.blueAccent)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(value,
              style: const TextStyle(
                color: Colors.black87,
                fontFamily: 'Pacifico',
              )),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}

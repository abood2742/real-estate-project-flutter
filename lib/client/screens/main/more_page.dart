import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:property_system/client/screens/auth/register/Create_Office_Page.dart';
import 'package:property_system/client/screens/auth/register/user_info_enter_page.dart';
import 'package:property_system/client/screens/more/client_properties/client_expired_property_page.dart';
import 'package:property_system/client/screens/more/client_properties/property_details_in_expired_property_page.dart';
import 'package:property_system/client/screens/more/create_property/Create_Property_Page.dart';
import 'package:property_system/client/screens/more/reserved_properties/client_reserverd_page.dart';
import 'package:property_system/client/screens/more/property_offer/post_property1.dart';

import 'package:property_system/client/screens/more/complaint/one_complaint_page.dart';
import 'package:property_system/client/screens/more/complaint/complaient_page.dart';
import 'package:property_system/client/screens/more/complaint/push_complaint_page.dart';
import 'package:property_system/client/screens/more/profile/client_profile.dart';
import 'package:property_system/client/screens/search/map/map_page.dart';
import 'package:property_system/client/screens/whaiting/the_properties_in_whaiting_page.dart';
import 'package:property_system/common/screens/block_page.dart';
import 'package:property_system/office/screens/subscriptions_office_page.dart';

class MorePage extends StatefulWidget {
  MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  bool isOn = true;

  void _showLanguageSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'اختر اللغة',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Text('🇸🇦', style: TextStyle(fontSize: 24)),
                title: const Text('العربية', style: TextStyle(fontSize: 18)),
                onTap: () {
                  // تغيير اللغة إلى العربية
                  print("تم اختيار العربية");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Text('🇺🇸', style: TextStyle(fontSize: 24)),
                title: const Text('English', style: TextStyle(fontSize: 18)),
                onTap: () {
                  // تغيير اللغة إلى الإنجليزية
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
    return Directionality(
      textDirection: TextDirection.rtl, // لدعم اللغة العربية>
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100), // 👈 هنا نتحكم بالارتفاع

          child: AppBar(
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'المزيد',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: 'Pacifico'),
                  ),
                ),
                SizedBox(width: 6),
                SizedBox(
                  height: 40,
                  width: 40,
                  child: Lottie.asset(
                    'assets/more_amolation.json',
                    repeat: true,
                    animate: true,
                    delegates: LottieDelegates(
                      values: [
                        ValueDelegate.color(
                          const ['**'],
                          value: Colors.white, // 👈 اللون الجديد
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: const Color.fromARGB(255, 88, 66, 146),
            centerTitle: false,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              buildMenuButton(
                icon: Icons.person,
                label: 'ملفي الشخصي',
                onTap: () {
                  print("object");
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ClientProfile();
                  }));
                },
              ),
              buildMenuButton(
                icon: Icons.person,
                label: 'ادخال  ',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return UserInfoEnterPage();
                  }));
                },
              ),
              buildMenuButton(
                icon: Icons.language,
                label: 'اللغة',
                onTap: () {
                  _showLanguageSheet(context);
                },
              ),
              buildMenuButton(
                icon: Icons.local_post_office,
                label: 'إنشاء مكتب',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CreateOfficePage();
                  }));
                },
              ),
              buildMenuButton(
                icon: Icons.create,
                label: 'نشر عقار',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CreateProperty();
                  }));
                },
              ),
              buildMenuButton(
                icon: Icons.create,
                label: 'نشر عقار 2',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return PostProperty1();
                  }));
                },
              ),
              buildMenuButton(
                icon: Icons.report_problem,
                label: 'تقديم شكوى',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return PushComplaintPage();
                  }));
                },
              ),
                buildMenuButton(
                icon: Icons.map,
                label: 'الخريطة ',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MapPage();
                  }));
                },
              ),
              buildMenuButton(
                icon: Icons.report_problem,
                label: 'الشكاوى',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ComplaientPage();
                  }));
                },
              ),

               buildMenuButton(
                icon: Icons.subscript,
                label: 'الإشتراكات',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SubscriptionsOfficePage();
                  }));
                },
              ),
              
              buildMenuButton(
                icon: Icons.report_problem,
                label: 'Authontication1',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ClientPagePropertyInExpiredPropertyPage(
                      pushedOffice: '',
                      pushedOfficeAccount: '',
                      propertyArea: '',
                      propertyLocation: '',
                      propertyPrice: '',
                      propertyType: '',
                    );
                  }));
                },
              ),
              buildMenuButton(
                icon: Icons.report_problem,
                label: 'تقديم الشكوى ',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ComplaientPage();
                  }));
                },
              ),
              buildMenuButton(
                icon: Icons.book,
                label: 'العقارات المحجوزة ',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ClientReserverdPage();
                  }));
                },
              ),
              buildMenuButton(
                icon: Icons.report_problem,
                label: 'معلومات الشكوى ',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return OneComplaintPage();
                  }));
                },
              ),
               buildMenuButton(
                icon: Icons.report_problem,
                label: ' العقار في حالة انتظار  ',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ThePropertiesInWhaitingPage();
                  }));
                },
              ),
              buildMenuButton(
                icon: Icons.report_problem,
                label: 'منتهي الصلاحية ',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ClientExpiredPropertyPage();
                  }));
                },
              ),
               buildMenuButton(
                icon: Icons.report_problem,
                label: ' الحساب محظور ',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return BlockPage();
                  }));
                },
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.notifications, color: Colors.blue),
                      const SizedBox(width: 12),
                      const Text(
                        'الإشعارات',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pacifico',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Center(
                          child: Switch(
                            value: isOn,
                            onChanged: (bool newValue) {
                              setState(() {
                                isOn = newValue; // تحديث الحالة
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// دالة لبناء الزر بشكل منسق
  Widget buildMenuButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Pacifico',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

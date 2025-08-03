import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:property_system/client_user/components/expired_components.dart';
import 'package:property_system/client_user/screens/client_expired_property_page.dart';
import 'package:property_system/client_user/screens/client_page_property_in_expired_property_page.dart';
import 'package:property_system/client_user/screens/client_reserverd_page.dart';
import 'package:property_system/client_user/screens/office_page_in_search_list_page.dart';
import 'package:property_system/client_user/screens/one_complaint_page.dart';
import 'package:property_system/client_user/screens/property_comment_rating_page.dart';
import 'package:property_system/client_user/screens/send_complaint_page.dart';
import 'package:property_system/client_user/screens/auth/user_info_enter_page.dart';
import 'package:property_system/common/screens/block_page.dart';
import 'package:property_system/client_user/screens/comments_on_property_page.dart';
import 'package:property_system/client_user/screens/complaient_page.dart';
import 'package:property_system/client_user/screens/complaint_page.dart';
import 'package:property_system/client_user/screens/initial_page.dart';
import 'package:property_system/client_user/screens/client_notification_page.dart';
import 'package:property_system/client_user/screens/client_profile.dart';
import 'package:property_system/client_user/screens/post_property_page.dart';
import 'package:property_system/client_user/screens/auth/register1_page.dart';
import 'package:property_system/client_user/screens/use.dart';
import 'package:property_system/client_user/screens/auth/verification_code.dart';

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
                    'assets/moer_amolation.json',
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ClientProfile();
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
                icon: Icons.language,
                label: 'info',
                onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return UserInfoEnterPage();
                  }));
                },
                
              ),
              buildMenuButton(
                icon: Icons.report_problem,
                label: 'تقديم شكوى',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ComplaintPage();
                  }));
                },
              ),
              buildMenuButton(
                icon: Icons.add_business,
                label: 'نشر عقار',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return PostProperty1();
                  }));
                },
              ),
              buildMenuButton(
                icon: Icons.report_problem,
                label: 'Authontication',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Register1Page();
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
                label: 'test',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ComplaientPage();
                  }));
                },
              ),
              buildMenuButton(
                icon: Icons.report_problem,
                label: 'العقارات المحجوزة ',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ClientReserverdPage();
                  }));
                },
              ),
              buildMenuButton(
                icon: Icons.report_problem,
                label: 'test1',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return OneComplaintPage();
                  }));
                },
              ),
              buildMenuButton(
                icon: Icons.report_problem,
                label: 'expired',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ClientExpiredPropertyPage();
                  }));
                },
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CommentsOnPropertyPage();
                  }));
                },
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

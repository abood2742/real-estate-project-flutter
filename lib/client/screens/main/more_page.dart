import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:property_system/client/models/profile.model.dart';
import 'package:property_system/client/reservation%20_for_client/client_reservation_page.dart';
import 'package:property_system/client/screens/auth/register/Create_Office_Page.dart';
import 'package:property_system/client/screens/auth/register/complete_register_page.dart';
import 'package:property_system/client/screens/main/Blog/My_BLogs_Page.dart';
import 'package:property_system/client/screens/main/Blog/create_blog.dart';
import 'package:property_system/client/screens/main/more/client_properties/client_expired_property_page.dart';
import 'package:property_system/client/screens/main/more/complaint/complaint_page.dart';
import 'package:property_system/client/screens/main/more/create_property/Create_Property_Page.dart';
import 'package:property_system/client/reservation%20_for_client/client_reservation_status.dart';
import 'package:property_system/client/reservation%20_for_client/client_create_reservation_page.dart';
import 'package:property_system/client/screens/main/more/profile/client_profile.dart';
import 'package:property_system/client/screens/main/more/property_offer/post_property1.dart';
import 'package:property_system/client/screens/main/more/complaint/push_complaint_page.dart';
import 'package:property_system/client/screens/search/map/map_page.dart';
import 'package:property_system/client/services/profile_service_done.dart';
import 'package:property_system/client/services/token_service.dart';
import 'package:property_system/common/screens/block_page.dart';
import 'package:property_system/main.dart';
import 'package:property_system/notification/screen/notification_page.dart';
import 'package:property_system/notification/socket_service.dart';
import 'package:property_system/office/reservation/office_reservation_page.dart';
import 'package:property_system/office/screens/complaints/complaint_page.dart';
import 'package:property_system/office/screens/done_properties.dart';
import 'package:property_system/office/screens/subscriptions_office_page.dart';
import 'package:property_system/l10n/app_localizations.dart';
import 'package:property_system/office/screens/waiting/my_Properties_Page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  String? userRole;
  bool isOn = true;

  @override
  void initState() {
    super.initState();
    _loadUserRole();
    _loadNotificationState();
  }

  void _loadUserRole() async {
    final tempUserRole = await AuthService.getUserRole();
    setState(() {
      userRole = tempUserRole;
    });
  }

  void _showLanguageSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        final localizations = AppLocalizations.of(context)!;
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                localizations.translate('choose_language'),
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Pacifico',
                    color: Color.fromARGB(255, 47, 88, 0)),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Text('🇸🇦', style: TextStyle(fontSize: 24)),
                title: Text(
                  localizations.translate('arabic'),
                  style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Pacifico',
                      color: Color.fromARGB(255, 0, 85, 125)),
                ),
                onTap: () {
                  Provider.of<LocalizationProvider>(context, listen: false)
                      .setLocale(const Locale('ar', ''));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Text('🇺🇸', style: TextStyle(fontSize: 24)),
                title: Text(
                  localizations.translate('english'),
                  style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Pacifico',
                      color: Color.fromARGB(255, 0, 85, 125)),
                ),
                onTap: () {
                  Provider.of<LocalizationProvider>(context, listen: false)
                      .setLocale(const Locale('en', ''));
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
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          elevation: 2,
          shadowColor: const Color.fromARGB(255, 68, 219, 73),
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  localizations.translate('more'),
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontFamily: 'Pacifico',
                  ),
                ),
              ),
              const SizedBox(width: 6),
              SizedBox(
                height: 40,
                width: 40,
                child: Lottie.asset(
                  'assets/more_Animation.json',
                  repeat: true,
                  animate: true,
                  delegates: LottieDelegates(
                    values: [
                      ValueDelegate.color(
                        const ['**'],
                        value: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: const Color.fromARGB(255, 36, 150, 188),
          centerTitle: false,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              "منتهية",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Pacifico',
              ),
            ),
            buildMenuButton(
              icon: Icons.language,
              label: 'اللغة',
              onTap: () {
                _showLanguageSheet(context);
              },
            ),
            buildMenuButton(
              icon: Icons.person,
              label: 'ملف شخصي',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ClientProfile();
                }));
              },
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return NotificationPage();
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
                    const Icon(Icons.notifications, color: Colors.green),
                    const SizedBox(width: 24),
                    Text(
                      localizations.translate('notifications'),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 42, 71, 95),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Pacifico',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 44),
                      child: Center(
                          child: Switch(
                        value: isOn,
                        onChanged: (bool newValue) async {
                          final socketService = SocketService();
                          _saveNotificationState(newValue);
                          if (!newValue) {
                            final userId = await enableNotificaions();
                            if (userId != null) {
                              socketService.disconnect();
                            }
                          } else {
                            final userId = await enableNotificaions();
                            if (userId != null) {
                              socketService.connect(userId);
                            }
                          }
                          setState(() {
                            isOn = newValue;
                          });
                        },
                      )),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              "مكتب",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Pacifico',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            buildMenuButton(
              icon: Icons.create,
              label: localizations.translate('publish_property'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const CreateProperty();
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.money,
              label: localizations.translate('subscriptions'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const SubscriptionsOfficePage();
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.report_problem,
              label: localizations.translate("عقارات محجوزة"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return OfficeReservationPage();
                }));
              },
            ),
            buildMenuButton(
              icon: FontAwesomeIcons.blog,
              label: localizations.translate('إنشاء مدونة'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CreateBlogPage();
                }));
              },
            ),
            buildMenuButton(
              icon: FontAwesomeIcons.compressAlt,
              label: 'شكاوى المكتب',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return OfficeComplaintPage();
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.report_problem,
              label: 'الشكاوى في قائمة الإنتظار',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MyPropertiesPage();
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.report_problem,
              label: 'صفحة عقارات المكتب المنتهية',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return OfficeDonePropertiesPage();
                }));
              },
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              "عميل",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Pacifico',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            buildMenuButton(
              icon: Icons.person,
              label: localizations.translate('إدخال معلومات'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const CompleteRegisterPage();
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.local_post_office,
              label: localizations.translate('إنشاء مكتب'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const CreateOfficePage();
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.report_problem,
              label: localizations.translate('صفحة العقارات المنتهية الصلاحية للعميل '),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ClientExpiredPropertyPage();
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.book,
              label: localizations.translate('صفحة انشاء الحجز للعميل '),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ClientCreateReservationPage(
                    propertyId: '',
                  );
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.book,
              label:'حجوزات العميل',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ClientReservationPage();
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.report_problem,
              label: 'تقديم شكوى',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PushComplaintPage(
                    officeId: '',
                    type: false,
                  );
                }));
              },
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              "غير منتهية",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Pacifico',
              ),
            ),
            buildMenuButton(
              icon: Icons.report_problem,
              label: localizations.translate('MyBlogsPage'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MyBlogsPage();
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.report_problem,
              label: localizations.translate('ClentReservationStatus'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ClientReservationStatus();
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.create,
              label: localizations.translate('publish_property_2'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PostProperty1();
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.map,
              label: localizations.translate('map'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MapPage();
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.report_problem,
              label: localizations.translate('account_blocked'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return BlockPage(
                    blockReason: 'كلام غير أخلاقي',
                    blockDate: '8 / 12 / 2024',
                  );
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.person,
              label: 'شكاوى العميل',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ClientComplaintPage();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }

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
            Icon(icon, color: Colors.green),
            const SizedBox(width: 24),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 42, 71, 95),
                fontWeight: FontWeight.bold,
                fontFamily: 'Pacifico',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loadNotificationState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isOn = prefs.getBool('notifications_enabled') ?? true;
    });
  }

  Future<void> _saveNotificationState(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications_enabled', value);
  }

  Future<String?> enableNotificaions() async {
    ProfileModel? user = await ProfileService().getProfile();
    if (user != null) {
      return user.id;
    }
    return null;
  }
}

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:property_system/client/components/complaint_card_office.dart';
import 'package:property_system/client/components/complaint_card_property.dart';
import 'package:property_system/client/models/profile.model.dart';
import 'package:property_system/client/reservation%20_for_client/client_reservation_page.dart';
import 'package:property_system/client/screens/auth/register/Create_Office_Page.dart';
import 'package:property_system/client/screens/auth/register/complete_register_page.dart';
import 'package:property_system/client/screens/main/Blog/My_BLogs_Page.dart';
import 'package:property_system/client/screens/main/Blog/create_blog.dart';
import 'package:property_system/client/screens/main/more/client_properties/client_expired_property_page.dart';
import 'package:property_system/client/screens/main/more/complaint/client_user_property_complainet_case_2.dart';
import 'package:property_system/client/screens/main/more/complaint/cloused_compailent_page.dart';
import 'package:property_system/client/screens/main/more/complaint/existing_compailent_page.dart';
import 'package:property_system/client/screens/main/more/complaint/office_manager_user_office_complainet_case_3.dart';
import 'package:property_system/client/screens/main/more/complaint/office_manager_user_property_complainet_case_4.dart';
import 'package:property_system/client/screens/main/more/create_property/Create_Property_Page.dart';
import 'package:property_system/client/reservation%20_for_client/client_reservation_status.dart';
import 'package:property_system/client/reservation%20_for_client/client_create_reservation_page.dart';
import 'package:property_system/client/screens/main/more/property_offer/post_property1.dart';
import 'package:property_system/client/screens/main/more/complaint/complaient_page.dart';
import 'package:property_system/client/screens/main/more/complaint/push_complaint_page.dart';
import 'package:property_system/client/screens/main/more/profile/client_profile.dart';
import 'package:property_system/client/screens/search/map/map_page.dart';
import 'package:property_system/client/screens/waiting/expired_properties_to_push_page.dart';
import 'package:property_system/client/screens/waiting/properties_dont_pushed_yet_page.dart';
import 'package:property_system/client/screens/waiting/rented_page.dart';
import 'package:property_system/client/screens/waiting/salled_page.dart';
import 'package:property_system/client/screens/waiting/the_properties_in_whaiting_page.dart';
import 'package:property_system/client/screens/waiting/to_rent_page.dart';
import 'package:property_system/client/screens/waiting/to_sall_page.dart';
import 'package:property_system/client/services/profile_service_done.dart';
import 'package:property_system/client/services/token_service.dart';
import 'package:property_system/common/screens/block_page.dart';
import 'package:property_system/notification/screen/notification_page.dart';
import 'package:property_system/notification/socket_service.dart';
import 'package:property_system/office/reservation/office_reservation_page.dart';
import 'package:property_system/office/screens/subscriptions_office_page.dart';
import 'package:property_system/l10n/app_localizations.dart';
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
              /////////////////////////////////////////////////
              ///
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
                  // تغيير اللغة إلى العربية
                  print("تم اختيار العربية");
                  Navigator.pop(context);
                },
              ),
              ///////////////////////////////////////////
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
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          elevation: 2,
          shadowColor: const Color.fromARGB(255, 68, 219, 73),
          title: Row(
            // mainAxisSize: MainAxisSize.min,
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
                  'assets/more_Animation.json', // تصحيح اسم الملف
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
          backgroundColor: const Color.fromARGB(255, 24, 55, 147),
          centerTitle: false,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              "منتهية",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Pacifico',
              ),
            ),
              buildMenuButton(
              icon: Icons.language,
              label: localizations.translate('language'),
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

                          // حفظ الحالة في SharedPreferences
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
              label: localizations.translate('OfficeReservationPage'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return OfficeReservationPage();
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.report_problem,
              label: localizations.translate('CreateBlogPage'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CreateBlogPage();
                }));
              },
            ),

            buildMenuButton(
              icon: Icons.person,
              label: localizations.translate('enter_your_data'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const CompleteRegisterPage();
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.local_post_office,
              label: localizations.translate('create_office'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const CreateOfficePage();
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.report_problem,
              label: localizations.translate('ClientExpiredPropertyPage'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ClientExpiredPropertyPage();
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.book,
              label: localizations.translate('ClientCreateReservationPage'),
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
              label: localizations.translate('ClientReservationPage'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ClientReservationPage();
                }));
              },
            ),
            // ...[
            //   if (userRole == 'officeManager') ...[

            // const SizedBox(
            //   height: 40,
            // ),
            // const Text(
            //   "مكتب",
            //   style: const TextStyle(
            //     fontSize: 16,
            //     fontWeight: FontWeight.bold,
            //     fontFamily: 'Pacifico',
            //   ),
            // ),
            // const SizedBox(
            //   height: 20,
            // ),

            // const SizedBox(
            //   height: 40,
            // ),
            // const Text(
            //   "reservation",
            //   style: const TextStyle(
            //     fontSize: 16,
            //     fontWeight: FontWeight.bold,
            //     fontFamily: 'Pacifico',
            //   ),
            // ),
            // const SizedBox(
            //   height: 20,
            // ),

            // ]
            // ],
            // ...[
            // if (userRole == 'user') ...[
            const SizedBox(
              height: 40,
            ),
            const Text(
              "غير منتهية",
              style: const TextStyle(
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
              icon: Icons.person,
              label: 'شكاوى العميل',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ComplaintPage();
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.person,
              label: '  ClientUserPropertyComplainetCase2',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ClientUserPropertyComplainetCase2(
                    complaint: {},
                    title: '',
                    contained: '',
                    date: '',
                    name: '',
                    phone: '',
                    post: '',
                  );
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.person,
              label: '  OfficeManagerUserOfficeComplainetCase3',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return OfficeManagerUserOfficeComplainetCase3(
                    complaint: {},
                    title: '',
                    contained: '',
                    date: '',
                    name: '',
                    phone: '',
                    phoneClient: '',
                  );
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.person,
              label: '  OfficeManagerUserPropertyComplainetCase4',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return OfficeManagerUserPropertyComplainetCase4(
                    complaint: {},
                    title: '',
                    contained: '',
                    date: '',
                    name: '',
                    phone: '',
                    clientEmail: '',
                  );
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.person,
              label: 'ارسال الشكوى',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PushComplaintPage(
                    officeId: '',
                    type: false,
                  );
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.person,
              label: ' ComplaintCardOffice',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ComplaintCardOffice(
                    officeName: 'التقى',
                    complaintTitle: 'أخلاق',
                    complaintDate: 'صحية ',
                  );
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.person,
              label: ' ComplaintCardProperty',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ComplaintCardProperty(
                    propertyName: 'شقة',
                    complaintTitle: 'تسرب المياه',
                    complaintDate: 'من الماسورة',
                  );
                }));
              },
            ),

            const SizedBox(
              height: 40,
            ),
            const Text(
              "reserved_properties",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Pacifico',
              ),
            ),
            const SizedBox(
              height: 20,
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
            //   ]
            // ],
            const SizedBox(
              height: 40,
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
            const SizedBox(
              height: 40,
            ),
            const Text(
              "complaints",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Pacifico',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            buildMenuButton(
              icon: Icons.report_problem,
              label: localizations.translate('ClousedCompailentPage'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ClousedCompailentPage();
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.report_problem,
              label: localizations.translate('ComplaintPage'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ComplaintPage();
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.report_problem,
              label: localizations.translate('ExistingCompailentPage'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ExistingCompailentPage();
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.report_problem,
              label: localizations.translate('PushComplaintPage'),
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
              "waiting",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Pacifico',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            buildMenuButton(
              icon: Icons.report_problem,
              label: localizations.translate('ExpiredPropertiesToPushPage'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ExpiredPropertiesToPushPage();
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.report_problem,
              label: localizations.translate('PropertiesDontPushedYetPage'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PropertiesDontPushedYetPage();
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.report_problem,
              label: localizations.translate('RentedPage'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return RentedPage();
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.report_problem,
              label: localizations.translate('SalledPage'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SalledPage();
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.report_problem,
              label: localizations.translate('ThePropertiesInWaitingPage'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ThePropertiesInWaitingPage();
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.report_problem,
              label: localizations.translate('ToRentPage'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ToRentPage();
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.report_problem,
              label: localizations.translate('ToSallPage'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ToSallPage();
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
      isOn = prefs.getBool('notifications_enabled') ??
          true; // إذا لم يتم التخزين من قبل ارجعه true
    });
  }

  // دالة لحفظ الحالة عند تغييرها
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

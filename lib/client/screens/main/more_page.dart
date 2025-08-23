import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:property_system/client/models/profile.model.dart';
import 'package:property_system/client/screens/auth/register/Create_Office_Page.dart';
import 'package:property_system/client/screens/auth/register/user_info_enter_page.dart';
import 'package:property_system/client/screens/main/more/client_properties/client_experid_for_rent_page_.dart';
import 'package:property_system/client/screens/main/more/client_properties/client_expired_for_buy_page.dart';
import 'package:property_system/client/screens/main/more/client_properties/client_expired_property_page.dart';
import 'package:property_system/client/screens/main/more/client_properties/property_details_in_expired_property_page.dart';
import 'package:property_system/client/screens/main/more/complaint/cloused_compailent_page.dart';
import 'package:property_system/client/screens/main/more/complaint/existing_compailent_page.dart';
import 'package:property_system/client/screens/main/more/complaint/send_complaint_page.dart';
import 'package:property_system/client/screens/main/more/create_property/Create_Property_Page.dart';
import 'package:property_system/client/screens/main/more/reserved_properties/client_create_reservation_page.dart';
import 'package:property_system/client/screens/main/more/reserved_properties/client_reserved_property_for_rent_page.dart';
import 'package:property_system/client/screens/main/more/reserved_properties/client_reserved_property_for_sell_page.dart';
import 'package:property_system/client/screens/main/more/reserved_properties/client_reserverd_page.dart';
import 'package:property_system/client/screens/main/more/property_offer/post_property1.dart';
import 'package:property_system/client/screens/main/more/complaint/one_complaint_page.dart';
import 'package:property_system/client/screens/main/more/complaint/complaient_page.dart';
import 'package:property_system/client/screens/main/more/complaint/push_complaint_page.dart';
import 'package:property_system/client/screens/main/more/profile/client_profile.dart';
import 'package:property_system/client/screens/search/map/map_page.dart';
import 'package:property_system/client/screens/search/reservation/Property_reservation.dart';
import 'package:property_system/client/screens/search/reservation/clent_reservation_status.dart';
import 'package:property_system/client/screens/waiting/expired_properties_to_push_page.dart';
import 'package:property_system/client/screens/waiting/properties_dont_pushed_yet_page.dart';
import 'package:property_system/client/screens/waiting/rented_page.dart';
import 'package:property_system/client/screens/waiting/salled_page.dart';
import 'package:property_system/client/screens/waiting/the_properties_in_whaiting_page.dart';
import 'package:property_system/client/screens/waiting/to_rent_page.dart';
import 'package:property_system/client/screens/waiting/to_sall_page.dart';
import 'package:property_system/client/services/user_profile.service.dart';
import 'package:property_system/common/screens/block_page.dart';
import 'package:property_system/notification/screen/notification_page.dart';
import 'package:property_system/notification/socket_service.dart';
import 'package:property_system/office/reservation/office_reservation_page.dart';
import 'package:property_system/office/reservation/property_reserved_for_rent_page.dart';
import 'package:property_system/office/reservation/property_reserved_for_sell_page.dart';
import 'package:property_system/office/reservation/rented_page_property_reserved_for_rent_page.dart';
import 'package:property_system/office/reservation/reservation_rent.dart';
import 'package:property_system/office/reservation/reservation_sell.dart';
import 'package:property_system/office/reservation/soled_page_property_reserved_for_sell_page.dart';
import 'package:property_system/office/screens/subscriptions_office_page.dart';
import 'package:property_system/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  bool isOn = true;

  @override
  void initState() {
    super.initState();
    _loadNotificationState();
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
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              /////////////////////////////////////////////////
              ListTile(
                leading: const Text('🇸🇦', style: TextStyle(fontSize: 24)),
                title: Text(
                  localizations.translate('arabic'),
                  style: const TextStyle(fontSize: 18),
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
                  style: const TextStyle(fontSize: 18),
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
          title: Row(
            mainAxisSize: MainAxisSize.min,
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
            buildMenuButton(
              icon: Icons.person,
              label: localizations.translate('profile'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const ClientProfile();
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.person,
              label: localizations.translate('enter_your_data'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const UserInfoEnterPage();
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
                    const Icon(Icons.notifications, color: Colors.blue),
                    const SizedBox(width: 12),
                    Text(
                      localizations.translate('notifications'),
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
            const SizedBox(
              height: 20,
            ),
            buildMenuButton(
              icon: Icons.language,
              label: localizations.translate('language'),
              onTap: () {
                _showLanguageSheet(context);
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
                    blockReason: '',
                    blockDate: '',
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
              label: localizations.translate('OneComplaintPage'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return OneComplaintPage(
                    complaintName: '',
                    submissionDate: '',
                    complaintReason: '',
                    complaintStatus: '',
                  );
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.report_problem,
              label: localizations.translate('PushComplaintPage'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PushComplaintPage();
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.report_problem,
              label: localizations.translate('SendComplaintPage'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SendComplaintPage();
                }));
              },
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              "client_properties",
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
              label: localizations.translate('ClientExpiredPropertyPage'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ClientExpiredPropertyPage();
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.report_problem,
              label: localizations.translate('ClientExpiredForBuyPage'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ClientExpiredForBuyPage();
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.report_problem,
              label: localizations.translate('ClientExpiredForRentPage'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ClientExpiredForRentPage();
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.report_problem,
              label: localizations
                  .translate('ClientPagePropertyInExpiredPropertyPage'),
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
              icon: Icons.report_problem,
              label: localizations.translate('ClientReservedPage'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ClientReservedPage();
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.report_problem,
              label:
                  localizations.translate('ClientReservedPropertyForRentPage'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ClientReservedPropertyForRentPage();
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.report_problem,
              label:
                  localizations.translate('ClientReservedPropertyForSellPage'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ClientReservedPropertyForSellPage();
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
            const SizedBox(
              height: 40,
            ),
            const Text(
              "search/reservation",
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
                  return ClentReservationStatus();
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.report_problem,
              label: localizations.translate('PropertyReservation'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PropertyReservation();
                }));
              },
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              "reservation",
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
              label: localizations.translate('OfficeReservationPage'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return OfficeReservationPage();
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.report_problem,
              label: localizations.translate('PropertyReservedForRentPage'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PropertyReservedForRentPage(
                    email: '',
                  );
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.report_problem,
              label: localizations.translate('PropertyReservedForSellPage'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PropertyReservedForSellPage(
                    email: '',
                  );
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.report_problem,
              label: localizations
                  .translate('RentedPagePropertyReservedForRentPage'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return RentedPagePropertyReservedForRentPage();
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.report_problem,
              label: localizations.translate('ReservationRent'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ReservationRent();
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.report_problem,
              label: localizations.translate('ReservationSell'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ReservationSell();
                }));
              },
            ),
            buildMenuButton(
              icon: Icons.report_problem,
              label: localizations
                  .translate('SoledPagePropertyReservedForSellPage'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SoledPagePropertyReservedForSellPage();
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

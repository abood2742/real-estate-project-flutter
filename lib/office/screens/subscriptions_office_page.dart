
// import 'package:flutter/material.dart';
// import 'package:property_system/client/components/subscripions_card.dart';
// import 'package:property_system/office/screens/continue_subscriptions_page.dart';


// class SubscriptionsOfficePage extends StatefulWidget {
//   const SubscriptionsOfficePage({super.key});

//   @override
//   State<SubscriptionsOfficePage> createState() => _SubscriptionsOfficePaeState();
// }

// class _SubscriptionsOfficePaeState extends State<SubscriptionsOfficePage> {
//   int selectedPlan = 0; // 0=none, 1=Basic, 2=Pro, 3=Premium

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 54, 36, 88),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//            const Text(
//               'خطة الدفع',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//             SizedBox(height: 40),
//             // الحاويات الأفقية
//             SizedBox(
//               height: 320,
//               child: ListView.separated(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: 3,
//                 separatorBuilder: (context, index) => SizedBox(width: 16),
//                 itemBuilder: (context, index) {
//                   switch (index) {
//                     case 0:
//                       return SubscriptionCard(
//                         title: 'أساسي',
//                         price: '\$8',
//                         features: 'ميزات رائعة \nللمستخدمين ',
//                         icon: Icons.star_outline,
//                         isSelected: selectedPlan == 1,
//                         onTap: () => setState(() => selectedPlan = 1), numberOfProperty: '10', numberOfPromotions: '3', period: 'شهر',
//                       );
//                     case 1:
//                       return SubscriptionCard(
//                         title: 'محترف',
//                         price: '\$12',
//                         features: 'المزيد من الميزات\nللمستخدمين',
//                         icon: Icons.star_half,
//                         isSelected: selectedPlan == 2,
//                         onTap: () => setState(() => selectedPlan = 2), numberOfProperty: '20', numberOfPromotions: '7', period: 'شهر',
//                       );
//                     case 2:
//                       return SubscriptionCard(
//                         title: 'مميز',
//                         price: '\$19',
//                         features: 'ميزات كثيرة\nللمستخدمين',
//                         icon: Icons.star,
//                         isSelected: selectedPlan == 3,
//                         onTap: () => setState(() => selectedPlan = 3), numberOfProperty: '30', numberOfPromotions: '11', period: 'شهر',
//                       );
//                     default:
//                       return Container();
//                   }
//                 },
//               ),
//             ),
//             SizedBox(height: 20),
//             Spacer(),
//             Center(
//               child: ElevatedButton(
//                 onPressed: selectedPlan == 0
//                     ? null
//                     : () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) => ContinueSubscriptionsPage(),
//                           ),
//                         );
//                       },
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: Text(
//                   'إستمرار',
//                   style: TextStyle(fontSize: 18),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:property_system/client/components/subscripions_card.dart';
import 'package:property_system/office/screens/subscriptions_next_page.dart';

class SubscriptionsOfficePage extends StatefulWidget {
  const SubscriptionsOfficePage({super.key});

  @override
  State<SubscriptionsOfficePage> createState() => _SubscriptionsOfficePaeState();
}

class _SubscriptionsOfficePaeState extends State<SubscriptionsOfficePage> {
  int selectedPlan = 0; // 0=none, 1=Basic, 2=Pro, 3=Premium

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 54, 36, 88),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'خطة الدفع',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: SizedBox(
                height: 400, // ارتفاع كاف لجميع البطاقات
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  separatorBuilder: (context, index) => SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return SubscriptionCard(
                          title: 'أساسي',
                          price: '\$8',
                          features: 'ميزات رائعة \nللمستخدمين',
                          icon: Icons.star_outline,
                          isSelected: selectedPlan == 1,
                          onTap: () => setState(() => selectedPlan = 1),
                          numberOfProperty: '10',
                          numberOfPromotions: '3',
                          period: 'شهر',
                        );
                      case 1:
                        return SubscriptionCard(
                          title: 'محترف',
                          price: '\$12',
                          features: 'المزيد من الميزات\nللمستخدمين',
                          icon: Icons.star_half,
                          isSelected: selectedPlan == 2,
                          onTap: () => setState(() => selectedPlan = 2),
                          numberOfProperty: '20',
                          numberOfPromotions: '7',
                          period: 'شهر',
                        );
                      case 2:
                        return SubscriptionCard(
                          title: 'مميز',
                          price: '\$19',
                          features: 'ميزات كثيرة\nللمستخدمين',
                          icon: Icons.star,
                          isSelected: selectedPlan == 3,
                          onTap: () => setState(() => selectedPlan = 3),
                          numberOfProperty: '30',
                          numberOfPromotions: '11',
                          period: 'شهر',
                        );
                      default:
                        return Container();
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: selectedPlan == 0
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SubscriptionsNextPage(planName: '', planPrice: null,),
                          ),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'إستمرار',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
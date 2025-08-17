// import 'package:flutter/material.dart';

// class PropertiesDontPushedYetPage extends StatelessWidget {
//   const PropertiesDontPushedYetPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//    return Scaffold(
//       body: Center(child: Text('لا يوجد عقارات ليست منشورة  بعد'),),
//     );
//   }
// }
// import 'package:flutter/material.dart';

// class ExpiredPropertiesToPushPage extends StatelessWidget {
//   const ExpiredPropertiesToPushPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(child: Text('لا يوجد عقارات منشورة بعد'),),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:property_system/client/screens/whaiting/to_rent_page.dart';
import 'package:property_system/client/screens/whaiting/to_sall_page.dart';

class PropertiesDontPushedYetPage extends StatefulWidget {
  @override
  _TwoButtonsPageState createState() => _TwoButtonsPageState();
}

class _TwoButtonsPageState extends State<PropertiesDontPushedYetPage> {
  int selectedPage = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: TextButton(
                  onPressed: () => setState(() => selectedPage = 1),
                  child: Text(
                    ' عقارات للبيع',
                    style: TextStyle(
                      fontWeight: selectedPage == 1
                          ? FontWeight.bold
                          : FontWeight.normal,
                      fontFamily: 'Pacifico',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  width: 1,
                  height: 40,
                  color: const Color.fromARGB(255, 29, 167, 134),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () => setState(() => selectedPage = 2),
                  child: Text(
                    ' عقارات للإيجار',
                    style: TextStyle(
                      fontWeight: selectedPage == 2
                          ? FontWeight.bold
                          : FontWeight.normal,
                      fontFamily: 'Pacifico',
                    ),
                  ),
                ),
              ),
            ],
          ),
          //  const Divider(),
          Expanded(
            child: selectedPage == 1
                ? buildFirstPageContent()
                : buildSecondPageContent(),
          ),
        ],
      ),
    );
  }

  Widget buildFirstPageContent() {
    return ToSallPage();
  }

  Widget buildSecondPageContent() {
    return ToRentPage();
  }
}

// import 'package:flutter/material.dart';
// import 'package:property_system/client/components/office_cards/office_card.dart';
// import 'package:property_system/client/models/office_card_model.dart';
// import 'package:property_system/client/screens/search/resault/office/Office_Detailes_Page.dart';
// import 'package:property_system/client/services/search_service.dart';

// class OfficesSearchPage extends StatefulWidget {
//   const OfficesSearchPage({super.key});

//   @override
//   State<OfficesSearchPage> createState() => _OfficesSearchPageState();
// }

// class _OfficesSearchPageState extends State<OfficesSearchPage> {
//   bool isLoadingOffices = false;
//   List<OfficeCardModel>? officeCardModels;

//   @override
//   void initState() {
//     super.initState();
//     _loadOffices();
//   }

//   Future<void> _loadOffices() async {
//     setState(() => isLoadingOffices = true);
//     officeCardModels = await SearchService().getAllOffices();
//     setState(() => isLoadingOffices = false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("المكاتب")),
//       body: RefreshIndicator(
//         onRefresh: _loadOffices,
//         child: ListView(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     decoration: InputDecoration(
//                       prefixIcon: const Icon(Icons.search),
//                       hintText: "ابحث عن مكتب",
//                       filled: true,
//                       fillColor: Colors.white,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                     // TODO: اربط البحث بالباك لاحقًا إذا لزم
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),

//             if (isLoadingOffices)
//               const Center(child: Padding(
//                 padding: EdgeInsets.only(top: 24),
//                 child: CircularProgressIndicator(),
//               ))
//             else if ((officeCardModels ?? []).isEmpty)
//               const Padding(
//                 padding: EdgeInsets.only(top: 24),
//                 child: Center(child: Text('لا توجد مكاتب حالياً')),
//               )
//             else
//               ..._buildOfficeWidgets(),
//           ],
//         ),
//       ),
//     );
//   }

//   List<Widget> _buildOfficeWidgets() {
//     return officeCardModels!.map((office) {
//       return OfficeCard(
//         name: office.name,
//         phone: office.officePhone,
//         imageUrl: office.officePhoto.url,
//         rating: office.ratings,
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => OfficeDetailesPage(officeId: office.id),
//             ),
//           );
//         },
//       );
//     }).toList();
//   }
// }
import 'package:flutter/material.dart';
import 'package:property_system/client/components/office_cards/office_card.dart';
import 'package:property_system/client/models/office_card_model.dart';
import 'package:property_system/client/screens/search/resault/office/Office_Detailes_Page.dart';
import 'package:property_system/client/services/search_service.dart';
import 'package:property_system/l10n/app_localizations.dart';

class OfficesSearchPage extends StatefulWidget {
  const OfficesSearchPage({super.key});

  @override
  State<OfficesSearchPage> createState() => _OfficesSearchPageState();
}

class _OfficesSearchPageState extends State<OfficesSearchPage> {
  bool isLoadingOffices = false;
  List<OfficeCardModel>? officeCardModels;

  @override
  void initState() {
    super.initState();
    _loadOffices();
  }

  Future<void> _loadOffices() async {
    setState(() => isLoadingOffices = true);
    officeCardModels = await SearchService().getAllOffices();
    setState(() => isLoadingOffices = false);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
    color: Colors.white, // تغيير لون السهم إلى الأبيض
  ),
        title: Text(localizations.translate('offices'),style: TextStyle(color: const Color.fromARGB(255, 27, 140, 89),fontFamily: 'Pacifico'),),
      ),
      body: RefreshIndicator(
        onRefresh: _loadOffices,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search,color: Colors.green,),
                      hintText: localizations.translate('search_office',),hintStyle: TextStyle(color: Colors.blue,fontFamily: "Pacifico",fontSize: 20),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    // TODO: اربط البحث بالباك لاحقًا إذا لزم
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (isLoadingOffices)
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 24),
                  child: CircularProgressIndicator(),
                ),
              )
            else if ((officeCardModels ?? []).isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Center(
                  child: Text(localizations.translate('no_offices_available')),
                ),
              )
            else
              ..._buildOfficeWidgets(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildOfficeWidgets() {
    return officeCardModels!.map((office) {
      return OfficeCard(
        name: office.name,
        phone: office.officePhone,
        imageUrl: office.officePhoto.url,
        rating: office.ratings,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OfficeDetailesPage(officeId: office.id),
            ),
          );
        },
      );
    }).toList();
  }
}
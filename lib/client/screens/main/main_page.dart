// import 'package:flutter/material.dart';
// import 'package:property_system/client/screens/main/more_page.dart';
// import 'package:property_system/client/screens/main/home_page.dart';
// import 'package:property_system/client/screens/main/Search_For_Offices_Page.dart';
// import 'package:property_system/client/screens/favorite/Favorite_page.dart';
// import 'package:property_system/client/screens/main/Search_For_Properties_Page.dart';

// class MainPage extends StatefulWidget {
//   const MainPage({super.key});

//   @override
//   State<MainPage> createState() => _BottomNavExampleState();
// }

// class _BottomNavExampleState extends State<MainPage> {
//   int _selectedIndex = 0;

//   final List<Widget> _screens = [
//     HomePage(),
//     FavoritePage(),
//     SearchPage(),   // البحث للعقارات
//     OfficesSearchPage(),  // ✅ صفحة المكاتب
//     MorePage(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _screens[_selectedIndex],
//       bottomNavigationBar: Container(
//         height: 90,
//         decoration: const BoxDecoration(
//         //  color: Color.fromARGB(255, 76, 68, 138),
//         color: Color.fromARGB(255, 56, 37, 196),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//           child: BottomNavigationBar(
//             currentIndex: _selectedIndex,
//             onTap: (index) {
//               setState(() {
//                 _selectedIndex = index;
//               });
//             },
//             type: BottomNavigationBarType.fixed,
//             backgroundColor: const Color.fromARGB(0, 0, 0, 0),
//             elevation: 2,
//             selectedItemColor: Colors.blue,
//             unselectedItemColor: Colors.white,
//             showSelectedLabels: true,
//             showUnselectedLabels: true,
//             items: [
//               _buildBarItem(Icons.home, 'Home', 0),
//               _buildBarItem(Icons.favorite, 'Favorite', 1),
//               _buildBarItem(Icons.search, 'Search', 2),     // العقارات
//               _buildBarItem(Icons.business, 'Offices', 3), // المكاتب
//               _buildBarItem(Icons.apps, 'More', 4),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   BottomNavigationBarItem _buildBarItem(IconData icon, String label, int index) {
//     final bool isSelected = _selectedIndex == index;
//     return BottomNavigationBarItem(
//       icon: Container(
//         padding: const EdgeInsets.all(8),
//         decoration: isSelected
//             ? const BoxDecoration(
//                 color: Color.fromARGB(255, 159, 149, 149),
//                 shape: BoxShape.circle,
//               )
//             : null,
//         child: Icon(icon, size: 24),
//       ),
//       label: label,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:property_system/client/screens/main/more_page.dart';
import 'package:property_system/client/screens/main/home_page.dart';
import 'package:property_system/client/screens/main/Search_For_Offices_Page.dart';
import 'package:property_system/client/screens/favorite/Favorite_page.dart';
import 'package:property_system/client/screens/main/Search_For_Properties_Page.dart';
import 'package:property_system/l10n/app_localizations.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  int _previousIndex = 0;

  final List<Widget> _screens = [
    HomePage(),
    FavoritePage(),
    SearchPage(),         // البحث للعقارات
    OfficesSearchPage(),  // صفحة المكاتب
    MorePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          final offsetAnimation = Tween<Offset>(
            begin: _selectedIndex > _previousIndex
                ? const Offset(1.0, 0.0)
                : const Offset(-1.0, 0.0),
            end: Offset.zero,
          ).animate(animation);

          return SlideTransition(
            position: offsetAnimation,
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        child: KeyedSubtree(
          key: ValueKey<int>(_selectedIndex),
          child: _screens[_selectedIndex],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _previousIndex = _selectedIndex;
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 76, 68, 138),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          _buildBarItem(Icons.home, 'Home', 0),
          _buildBarItem(Icons.favorite, 'Favorite', 1),
          _buildBarItem(Icons.search, 'Search', 2),
          _buildBarItem(Icons.business, 'Offices', 3),
          _buildBarItem(Icons.apps, 'More', 4),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildBarItem(IconData icon, String label, int index) {
    final bool isSelected = _selectedIndex == index;

    return BottomNavigationBarItem(
      icon: GestureDetector(
        onTap: () {
          setState(() {
            _previousIndex = _selectedIndex;
            _selectedIndex = index;
          });
        },
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 1.0, end: isSelected ? 1.2 : 1.0),
          duration: const Duration(milliseconds: 200),
          builder: (context, scale, child) {
            return Transform.scale(
              scale: scale,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          )
                        ]
                      : [],
                ),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: isSelected
                      ? const Color.fromARGB(255, 159, 149, 149)
                      : Colors.transparent,
                  child: Icon(
                    icon,
                    size: 24,
                    color: isSelected ? Colors.blue : Colors.white,
                  ),
                ),
              ),
            );
          },
        ),
      ),
      label: label,
    );
  }
}
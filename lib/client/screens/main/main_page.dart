import 'package:flutter/material.dart';
import 'package:property_system/client/screens/main/more_page.dart';
import 'package:property_system/client/screens/main/home_page.dart';
import 'package:property_system/client/screens/main/Search_For_Offices_Page.dart';
import 'package:property_system/client/screens/favorite/Favorite_page.dart';
import 'package:property_system/client/screens/main/Search_For_Properties_Page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _BottomNavExampleState();
}

class _BottomNavExampleState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomePage(),
    FavoritePage(),
    SearchPage(),   // البحث للعقارات
    OfficesSearchPage(),  // ✅ صفحة المكاتب
    MorePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        height: 90,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 76, 68, 138),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: const Color.fromARGB(0, 0, 0, 0),
            elevation: 2,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.white,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: [
              _buildBarItem(Icons.home, 'Home', 0),
              _buildBarItem(Icons.favorite, 'Favorite', 1),
              _buildBarItem(Icons.search, 'Search', 2),     // العقارات
              _buildBarItem(Icons.business, 'Offices', 3), // المكاتب
              _buildBarItem(Icons.apps, 'More', 4),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBarItem(IconData icon, String label, int index) {
    final bool isSelected = _selectedIndex == index;
    return BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: isSelected
            ? const BoxDecoration(
                color: Color.fromARGB(255, 159, 149, 149),
                shape: BoxShape.circle,
              )
            : null,
        child: Icon(icon, size: 24),
      ),
      label: label,
    );
  }
}

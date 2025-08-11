import 'package:flutter/material.dart';
import 'package:property_system/client/screens/main/more_page.dart';
import 'package:property_system/client/screens/main/home_page.dart';
import 'package:property_system/client/screens/saved/saved_page.dart';
import 'package:property_system/client/screens/main/search_Page.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _BottomNavExampleState();
}

class _BottomNavExampleState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
  HomePage(),
  SavedPage(),
  SearchPage(),
  MorePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        height: 90,
        decoration: BoxDecoration(
          
          color: const Color.fromARGB(255, 76, 68, 138),
         // borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
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
              _buildBarItem(Icons.bookmark, 'Saved', 1),
              _buildBarItem(Icons.search, 'Search', 2),
              _buildBarItem(Icons.apps, 'More', 3),
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
            ? BoxDecoration(
                color: const Color.fromARGB(255, 159, 149, 149),
                shape: BoxShape.circle,
              )
            : null ,
        child: Icon(icon,size: 24,),
      ),
      label: label,
    );
  }
}

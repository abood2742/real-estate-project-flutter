// 
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:property_system/client/screens/favorite/Favorite_Offices_Page.dart';
import 'package:property_system/client/screens/favorite/Favorite_Properties_Page.dart';
import 'package:property_system/l10n/app_localizations.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 24, 55, 147),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                localizations.translate('favorites'),
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              const SizedBox(width: 6),
              SizedBox(
                height: 40,
                width: 40,
                child: Lottie.asset(
                  'assets/more_Animation.json',
                  repeat: true,
                  animate: true,
                ),
              ),
            ],
          ),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(
                icon: const Icon(Icons.home),
                text: localizations.translate('properties'),
              ),
              Tab(
                icon: const Icon(Icons.business),
                text: localizations.translate('offices'),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            FavoritePropertiesPage(),
            FavoriteOfficesPage(),
          ],
        ),
      ),
    );
  }
}
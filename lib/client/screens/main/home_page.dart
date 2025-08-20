// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:property_system/client/components/blog_model.dart';
import 'package:property_system/client/components/spechial_offer.dart';
import 'package:property_system/l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 120,
              pinned: true,
              flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  final bool isCollapsed = constraints.maxHeight <=
                      kToolbarHeight + MediaQuery.of(context).padding.top;

                  return FlexibleSpaceBar(
                    background: Image.asset(
                      'assets/images/sliver2.png',
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      isCollapsed
                          ? localizations.translate('home_page')
                          : localizations.translate('property_system'),
                      style: const TextStyle(
                        color: Color.fromARGB(255, 88, 57, 182),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'Pacifico',
                      ),
                    ),
                    titlePadding:
                        const EdgeInsetsDirectional.only(start: 14, bottom: 18),
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, right: 16),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    children: [
                      const Spacer(flex: 2),
                      const Icon(Icons.location_on, size: 20, color: Colors.grey),
                      Text(
                        localizations.translate('location'),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pacifico',
                          color: Color.fromARGB(255, 155, 156, 175),
                          fontSize: 18,
                        ),
                      ),
                      const Spacer(flex: 22),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Spacer(flex: 1),
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        localizations.translate('syria_damascus'),
                        style: const TextStyle(
                          color: Colors.blue,
                          fontFamily: 'Pacifico',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(flex: 10),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, right: 16, left: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      localizations.translate('from_our_blog'),
                      style: const TextStyle(
                        color: Colors.blue,
                        fontFamily: 'Pacifico',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // TODO: الانتقال إلى صفحة المدونة
                      },
                      child: Text(
                        localizations.translate('view_all'),
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 400,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const SizedBox(
                      width: 320,
                      child: BlogModel(),
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, right: 16),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    localizations.translate('special_offers'),
                    style: const TextStyle(
                      color: Colors.blue,
                      fontFamily: 'Pacifico',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return OfferCard(
                    imagePath: 'assets/images/pic1.jpg',
                    title: localizations.translate('home_in_homs'),
                    subtitle: localizations.translate('offer_for_two_months'),
                    price: localizations.translate('price_20000'),
                    onDetailsPressed: () {},
                  );
                },
                childCount: 3,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: الانتقال إلى صفحة كل العروض
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      localizations.translate('show_more'),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
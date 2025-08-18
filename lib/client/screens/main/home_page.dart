import 'package:flutter/material.dart';
import 'package:property_system/client/components/blog_model.dart';
import 'package:property_system/client/components/spechial_offer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                      isCollapsed ? 'Home Page' : 'Property System',
                      style: const TextStyle(
                        color: Color(0xFF30274C),
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
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 20, right: 16),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    children: [
                      Spacer(flex: 2),
                      Icon(Icons.location_on, size: 20, color: Colors.grey),
                      Text(
                        'location ',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(flex: 22),
                    ],
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Spacer(flex: 1),
                  Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Syria , Damascus',
                        style: TextStyle(
                          color: Colors.blue,
                          fontFamily: 'Pacifico',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Spacer(flex: 10),
                ],
              ),
            ),

            // ===== من مدونتنا + زر =====
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, right: 16, left: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   const Text(
                      'من مدونتنا ',
                      style: TextStyle(
                        color: Colors.blue,
                        fontFamily: 'Pacifico',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                
                      },
                      child: Text(
                        'عرض الكل',
                        style: TextStyle(
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

            // ===== عروض خاصة =====
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 20, right: 16),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'عروض خاصة ',
                    style: TextStyle(
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
                    title: 'Home in Homs',
                    subtitle: 'The offer for 2 month',
                    price: '20000',
                    onDetailsPressed: () {},
                  );
                },
                childCount: 3,
              ),
            ),

            // ===== زر "عرض المزيد" أسفل العروض =====
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
                    child: const Text(
                      'عرض المزيد',
                      style: TextStyle(
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

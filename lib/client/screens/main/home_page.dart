// import 'package:flutter/material.dart';
// import 'package:property_system/client/components/blog_card.dart';
// import 'package:property_system/client/components/spechial_offer.dart';
// import 'package:property_system/client/models/blog_model.dart';
// import 'package:property_system/client/screens/main/Blog/All_Blogs_Page.dart';
// import 'package:property_system/client/services/Blog_service_done.dart';
// import 'package:property_system/l10n/app_localizations.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List<BlogModel> blogs = [];
//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _loadBlogs();
//   }

//   Future<void> _loadBlogs() async {
//     setState(() => isLoading = true);
//     blogs = await BlogService().getAllBlogs() ?? [];
//     setState(() => isLoading = false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final localizations = AppLocalizations.of(context)!;

//     return Scaffold(
//       body: SafeArea(
//         child: CustomScrollView(
//           slivers: [
//             SliverAppBar(
//               expandedHeight: 120,
//               pinned: true,
//               flexibleSpace: LayoutBuilder(
//                 builder: (context, constraints) {
//                   final isCollapsed = constraints.maxHeight <=
//                       kToolbarHeight + MediaQuery.of(context).padding.top;
//                   return FlexibleSpaceBar(
//                     background: Image.asset('assets/images/sliver2.png', fit: BoxFit.cover),
//                     title: Text(
//                       isCollapsed
//                           ? localizations.translate('home_page')
//                           : localizations.translate('property_system'),
//                       style: const TextStyle(
//                         color: Color.fromARGB(255, 88, 57, 182),
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                         fontFamily: 'Pacifico',
//                       ),
//                     ),
//                     titlePadding: const EdgeInsetsDirectional.only(start: 14, bottom: 18),
//                   );
//                 },
//               ),
//             ),

//             // عنوان المدونات
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       localizations.translate('from_our_blog'),
//                       style: const TextStyle(
//                         color: Colors.blue,
//                         fontFamily: 'Pacifico',
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         // الانتقال لصفحة جميع المدونات
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (_) => AllBlogsPage(blogs: blogs)),
//                         );
//                       },
//                       child: Text(
//                         localizations.translate('view_all'),
//                         style: const TextStyle(
//                           color: Colors.blue,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             // عرض أول 5 مدونات فقط بشكل أفقي مع تقليل ارتفاع البطاقة
//             SliverToBoxAdapter(
//               child: SizedBox(
//                 height: 250, // تصغير طول البطاقة
//                 child: isLoading
//                     ? const Center(child: CircularProgressIndicator())
//                     : blogs.isEmpty
//                         ? const Center(child: Text('لا توجد مدونات حالياً'))
//                         : ListView.builder(
//                             scrollDirection: Axis.horizontal,
//                             itemCount: blogs.length > 5 ? 5 : blogs.length,
//                             itemBuilder: (context, index) {
//                               final blog = blogs[index];
//                               return SizedBox(
//                                 width: 280,
//                                 child: BlogCard(blog: blog),
//                               );
//                             },
//                           ),
//               ),
//             ),

//             // باقي الصفحة (العروض الخاصة)
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 20, right: 16),
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   child: Text(
//                     localizations.translate('special_offers'),
//                     style: const TextStyle(
//                       color: Colors.blue,
//                       fontFamily: 'Pacifico',
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SliverList(
//               delegate: SliverChildBuilderDelegate(
//                 (context, index) {
//                   return OfferCard(
//                     imagePath: 'assets/images/pic1.jpg',
//                     title: localizations.translate('home_in_homs'),
//                     subtitle: localizations.translate('offer_for_two_months'),
//                     price: localizations.translate('price_20000'),
//                     onDetailsPressed: () {},
//                   );
//                 },
//                 childCount: 3,
//               ),
//             ),
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 20),
//                 child: Center(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // الانتقال إلى صفحة كل العروض
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                       padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                     ),
//                     child: Text(
//                       localizations.translate('show_more'),
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:property_system/client/components/blog_card.dart';
import 'package:property_system/client/components/spechial_offer.dart';
import 'package:property_system/client/models/blog_model.dart';
import 'package:property_system/client/screens/main/Blog/All_Blogs_Page.dart';
import 'package:property_system/client/services/Blog_service_done.dart';
import 'package:property_system/l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BlogModel> blogs = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadBlogs();
  }

  Future<void> _loadBlogs() async {
    setState(() => isLoading = true);
    blogs = await BlogService().getAllBlogs() ?? [];
    setState(() => isLoading = false);
  }

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
                builder: (context, constraints) {
                  final isCollapsed = constraints.maxHeight <=
                      kToolbarHeight + MediaQuery.of(context).padding.top;
                  return FlexibleSpaceBar(
                    background: Image.asset('assets/images/sliver2.png', fit: BoxFit.cover),
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
                    titlePadding: const EdgeInsetsDirectional.only(start: 14, bottom: 18),
                  );
                },
              ),
            ),

            // عنوان المدونات
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
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
                        // الانتقال لصفحة جميع المدونات
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => AllBlogsPage(blogs: blogs)),
                        );
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

            // عرض أول 5 مدونات فقط بشكل أفقي مع تقليل ارتفاع البطاقة
            SliverToBoxAdapter(
              child: SizedBox(
                height: 250, // تصغير طول البطاقة
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : blogs.isEmpty
                        ? const Center(child: Text('لا توجد مدونات حالياً'))
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: blogs.length > 5 ? 5 : blogs.length,
                            itemBuilder: (context, index) {
                              final blog = blogs[index];
                              return SizedBox(
                                width: 280,
                                child: BlogCard(blog: blog),
                              );
                            },
                          ),
              ),
            ),

            // باقي الصفحة (العروض الخاصة)
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
                      // الانتقال إلى صفحة كل العروض
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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

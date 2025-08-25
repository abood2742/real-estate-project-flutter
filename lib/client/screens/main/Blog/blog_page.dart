import 'package:flutter/material.dart';
import 'package:property_system/client/screens/search/resault/office/Office_Details_Page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:property_system/client/models/blog_model.dart';

/// صفحة عرض تفاصيل المدونة مع دعم 1–4 صور
class BlogPage extends StatefulWidget {
  final BlogModel blog;

  const BlogPage({super.key, required this.blog});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  final PageController _pageController = PageController();


  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final blog = widget.blog;

    // صورة المدونة (يمكن لاحقًا جعلها قائمة)
    final List<String> images = [blog.blogMedia.url] ;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'مدونة',
          style: TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 24,
            color: Color(0xFF4A3F91),
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFF4A3F91)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // عرض الصور
              if (images.isNotEmpty)
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: images.length,
                    itemBuilder: (context, index) => ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        images[index],
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, progress) =>
                            progress == null ? child : const Center(child: CircularProgressIndicator()),
                        errorBuilder: (_, __, ___) => const Center(
                          child: Icon(Icons.broken_image_rounded, size: 40),
                        ),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 12),

              // SmoothPageIndicator
              if (images.length > 1)
                SmoothPageIndicator(
                  controller: _pageController,
                  count: images.length,
                  effect: const WormEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    activeDotColor: Color(0xFF4A3F91),
                    dotColor: Colors.grey,
                  ),
                ),
              const SizedBox(height: 24),

              // محتوى المدونة
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  blog.content,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.8,
                    color: Color(0xFF333333),
                    fontFamily: 'Cairo',
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 30),

              // زر الانتقال للمكتب
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => OfficeDetailsPage(
                            officeId: blog.office.id,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.business, color: Colors.white),
                    label: Text(
                      'زيارة مكتب ${blog.office.name}',
                      style: const TextStyle(fontSize: 18, color: Colors.white, fontFamily: 'Cairo'),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4A3F91),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

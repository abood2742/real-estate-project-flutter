import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BlogPage extends StatefulWidget {
  /// قائمة عناوين الصور (شبكة أو Storage أو Asset).
  final List<String> imageUrls;

  /// نصّ المدوّنة القادم من الـ API.
  final String content;

  /// الدالة التي تفتح صفحة العقار.
  final VoidCallback onOpenProperty;

  const BlogPage({
    super.key,
    required this.imageUrls,
    required this.content,
    required this.onOpenProperty,
  }) : assert(imageUrls.length >= 1 && imageUrls.length <= 4,
            'يمكن تمرير من صورة واحدة حتى أربع صور فقط');

  @override
  State<BlogPage> createState() => _BlogPostPageState();
}

class _BlogPostPageState extends State<BlogPage> {
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'مدونة ',
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
              /* ———— عرض الصور (1–4) ———— */
              AspectRatio(
                aspectRatio: 16 / 9,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.imageUrls.length,
                  itemBuilder: (context, index) => ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      widget.imageUrls[index],
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) => progress ==
                              null
                          ? child
                          : const Center(child: CircularProgressIndicator()),
                      errorBuilder: (_, __, ___) => const Center(
                        child: Icon(Icons.broken_image_rounded, size: 40),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              /* ———— مؤشّر الصفحات ———— */
              if (widget.imageUrls.length > 1)
                SmoothPageIndicator(
                  controller: _pageController,
                  count: widget.imageUrls.length,
                  effect: const WormEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    activeDotColor: Color(0xFF4A3F91),
                    dotColor: Colors.grey,
                  ),
                ),
              const SizedBox(height: 24),

              /* ———— نصّ المدوّنة ———— */
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
                  widget.content,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    height: 1.8,
                    fontSize: 16,
                    color: const Color(0xFF333333),
                    fontFamily: 'Cairo',
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 30),

              /* ———— زرّ الانتقال للعقار ———— */
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: ElevatedButton.icon(
                    onPressed: widget.onOpenProperty,
                    icon: const Icon(
                      Icons.home_work_outlined,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'الانتقال إلى العقار',
                      style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 18,
                          color: Colors.white),
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
// import 'package:flutter/material.dart';
// class BlogPage extends StatelessWidget {
//   const BlogPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: AppBar(title: Text('our blog ',style: TextStyle(color: Colors.white,fa),),),
//     );
//   }
// }
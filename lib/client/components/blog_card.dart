import 'package:flutter/material.dart';
import 'package:property_system/client/models/blog_model.dart';
import 'package:property_system/client/screens/main/Blog/blog_page.dart';

/// البطاقة لعرض عنوان وصورة المقالة فقط
class BlogCard extends StatelessWidget {
  final BlogModel blog;

  const BlogCard({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // عند الضغط ننتقل إلى صفحة BlogPage مع كل التفاصيل
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlogPage(
              blog: blog,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12), // تصغير الانحناء
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 6, // تصغير الظل
              offset: const Offset(0, 3),
            ),
          ],
        ),
        width: 260, // تصغير العرض من 320 إلى 260
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة المقالة
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.network(
                blog.blogMedia.url,
                width: double.infinity,
                height: 140, // تصغير ارتفاع الصورة من 200 إلى 140
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey[300],
                  width: double.infinity,
                  height: 140,
                  child: const Icon(Icons.broken_image),
                ),
              ),
            ),
            const SizedBox(height: 6),
            // عنوان المقالة
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Text(
                blog.title,
                style: const TextStyle(
                  fontSize: 15, // تصغير حجم الخط من 18 إلى 15
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

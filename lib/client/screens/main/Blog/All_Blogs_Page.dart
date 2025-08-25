import 'package:flutter/material.dart';
import 'package:property_system/client/components/blog_card.dart';
import 'package:property_system/client/models/blog_model.dart';

class AllBlogsPage extends StatelessWidget {
  final List<BlogModel> blogs;

  const AllBlogsPage({super.key, required this.blogs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('جميع المدونات'),
      ),
      body: blogs.isEmpty
          ? const Center(child: Text('لا توجد مدونات حالياً'))
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,        // عدد الأعمدة (2 بطاقات في الصف)
                  crossAxisSpacing: 10,     // المسافة الأفقية بين البطاقات
                  mainAxisSpacing: 10,      // المسافة العمودية بين الصفوف
                  childAspectRatio: 1,    // نسبة العرض إلى الارتفاع (لتصغير الطول)
                ),
                itemCount: blogs.length,
                itemBuilder: (context, index) {
                  final blog = blogs[index];
                  return BlogCard(blog: blog);
                },
              ),
            ),
    );
  }
}

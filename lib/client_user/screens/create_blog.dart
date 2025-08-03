import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

/// صفحة إنشاء مدوّنة مع رفع وسائط، حفظ مسودة، نشر، ومسودة جديدة.
class CreateBlog extends StatefulWidget {
  const CreateBlog({super.key});

  @override
  State<CreateBlog> createState() => _BlogEditorPageState();
}

class _BlogEditorPageState extends State<CreateBlog> {
  // متحكم النص
  final _controller = TextEditingController();

  // قائمة الوسائط المختارة
  final List<XFile> _media = [];
  final ImagePicker _picker = ImagePicker();

  /// اختيار صور متعددة من المعرض
  Future<void> _pickImages() async {
    try {
      final images = await _picker.pickMultiImage(
        maxWidth: 1600,
        imageQuality: 85,
      );

      if (images.isEmpty) return;

      if (!mounted) return;
      setState(() => _media.addAll(images));
    } on MissingPluginException {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('المكوّن غير مُسجَّل على هذه المنصة')),
      );
    }
  }

  /// حفظ كمسودة (مثال وهمي)
  void _saveDraft() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم حفظ المسودة ')),
    );
  }

  /// النشر (مثال وهمي)
  void _publish() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم نشر المدونة ')),
    );
  }

  /// مسودة جديدة – يعيد الصفحة لحالة فارغة
  void _newDraft() {
    setState(() {
      _controller.clear();
      _media.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 86, 33, 185),
        title: const Text(
          'إنشاء مدونة ',
          style: TextStyle(color: Colors.white, fontFamily: 'Pacifico'),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'حفظ كمسودة',
            icon: const Icon(Icons.save_alt_rounded),
            onPressed: _saveDraft,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _newDraft,
        icon: const Icon(Icons.note_add_rounded),
        label: const Text('مسودة جديدة'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // حقل نص المدونة
            Card(
              elevation: 4,
              shadowColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  controller: _controller,
                  minLines: 6,
                  maxLines: null,
                  textDirection: TextDirection.rtl, // اتجاه اللغة
                  textAlign: TextAlign.right, // محاذاة النص
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'كتابة مدونة',
                    hintTextDirection: TextDirection.rtl,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
            // شبكة الوسائط المختارة + زر إضافة
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                for (final file in _media)
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.file(
                          File(file.path),
                          height: 110,
                          width: 110,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _media.remove(file);
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black45,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(4),
                            child: const Icon(
                              Icons.close,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                // زر إضافة صور
                GestureDetector(
                  onTap: _pickImages,
                  child: Container(
                    height: 110,
                    width: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: theme.colorScheme.primary.withOpacity(.1),
                    ),
                    child: const Center(
                      child: Icon(Icons.add_photo_alternate_outlined, size: 32),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(120),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color.fromARGB(255, 42, 97, 142),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      tooltip: 'نشر',
                      icon: const Icon(
                        Icons.publish_rounded,
                        color: Colors.white,
                      ),
                      onPressed: _publish,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

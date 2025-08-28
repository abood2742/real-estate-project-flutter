import 'dart:convert';
import 'dart:io' as io;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:property_system/client/services/Blog_service_done.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateBlogPage extends StatefulWidget {
  const CreateBlogPage({super.key});

  @override
  State<CreateBlogPage> createState() => _CreateBlogPageState();
}

class _CreateBlogPageState extends State<CreateBlogPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  List<Uint8List> _imageBytes = []; // للويب
  List<io.File> _imageFiles = []; // للجوال

  Color primaryColor = Colors.indigo.shade700;
  Color backgroundColor = Colors.grey.shade100;

  @override
  void initState() {
    super.initState();
    _loadDraft(); // تحميل المسودة عند فتح الصفحة
  }

  /// اختيار الصور (ويب أو جوال)
  Future<void> _pickImages() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();

    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      if (kIsWeb) {
        List<Uint8List> webImages = [];
        for (var file in pickedFiles) {
          final bytes = await file.readAsBytes();
          webImages.add(bytes);
        }
        setState(() {
          _imageBytes = webImages;
          _imageFiles.clear();
        });
      } else {
        List<io.File> mobileFiles =
            pickedFiles.map((f) => io.File(f.path)).toList();
        setState(() {
          _imageFiles = mobileFiles;
          _imageBytes.clear();
        });
      }
    }
  }

  /// حفظ المسودة فعليًا باستخدام SharedPreferences
  Future<void> _saveDraft() async {
    if (_titleController.text.isEmpty &&
        _contentController.text.isEmpty &&
        _imageFiles.isEmpty &&
        _imageBytes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('لا توجد بيانات لحفظها')),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();

    // تخزين النصوص
    await prefs.setString('draft_title', _titleController.text);
    await prefs.setString('draft_content', _contentController.text);

    // تخزين الصور
    if (kIsWeb) {
      List<String> base64Images =
          _imageBytes.map((b) => base64Encode(b)).toList();
      await prefs.setStringList('draft_images', base64Images);
    } else {
      List<String> paths = _imageFiles.map((f) => f.path).toList();
      await prefs.setStringList('draft_images', paths);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ تم حفظ المسودة بنجاح')),
    );
  }

  /// تحميل المسودة عند فتح الصفحة
  Future<void> _loadDraft() async {
    final prefs = await SharedPreferences.getInstance();
    String? title = prefs.getString('draft_title');
    String? content = prefs.getString('draft_content');
    List<String>? images = prefs.getStringList('draft_images');

    if (title != null) _titleController.text = title;
    if (content != null) _contentController.text = content;

    if (images != null && images.isNotEmpty) {
      if (kIsWeb) {
        List<Uint8List> webImages =
            images.map((b64) => base64Decode(b64)).toList();
        setState(() {
          _imageBytes = webImages;
        });
      } else {
        List<io.File> mobileFiles = images.map((p) => io.File(p)).toList();
        setState(() {
          _imageFiles = mobileFiles;
        });
      }
    }
  }


void _publish() async {
  if (_titleController.text.isEmpty ||
      _contentController.text.isEmpty ||
      (_imageFiles.isEmpty && _imageBytes.isEmpty)) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('يرجى إدخال العنوان والمحتوى واختيار صورة')),
    );
    return;
  }

  try {
    // تحويل الصور إلى نوع مناسب للـ FormData
    List<MultipartFile> photos = [];

    if (kIsWeb) {
      for (var i = 0; i < _imageBytes.length; i++) {
        photos.add(
          MultipartFile.fromBytes(
            _imageBytes[i],
            filename: 'blog_image_$i.png',
            contentType: MediaType('image', 'png'),
          ),
        );
      }
    } else {
      for (var file in _imageFiles) {
        photos.add(await MultipartFile.fromFile(file.path, filename: file.path.split('/').last));
      }
    }

    var success = await BlogService().createBlog(
      title: _titleController.text,
      content: _contentController.text,
      blogPhoto: photos,
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ تم نشر المدونة بنجاح!')),
      );

      _titleController.clear();
      _contentController.clear();
      setState(() {
        _imageFiles.clear();
        _imageBytes.clear();
      });

      _clearDraft(); // حذف المسودة بعد النشر
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('❌ خطأ في النشر: $e')),
    );
  }
}


  /// حذف المسودة من SharedPreferences بعد النشر
  Future<void> _clearDraft() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('draft_title');
    await prefs.remove('draft_content');
    await prefs.remove('draft_images');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title:
            const Text('📝 إنشاء مدونة', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          TextButton.icon(
            onPressed: _saveDraft,
            icon: const Icon(Icons.save_alt_rounded, color: Colors.white),
            label: const Text(
              'حفظ كمسودة',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('عنوان المدونة'),
              const SizedBox(height: 8),
              _buildTextField(_titleController, 'أدخل عنوان المدونة'),
              const SizedBox(height: 16),
              _buildSectionTitle('محتوى المدونة'),
              const SizedBox(height: 8),
              _buildTextField(_contentController, 'أدخل محتوى المدونة',
                  maxLines: 6),
              const SizedBox(height: 20),
              _buildSectionTitle('صور المدونة'),
              const SizedBox(height: 10),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      FloatingActionButton(
                        heroTag: 'blogPhotosBtn',
                        mini: true,
                        onPressed: _pickImages,
                        backgroundColor: primaryColor,
                        child: const Icon(Icons.add_photo_alternate),
                      ),
                      const SizedBox(height: 16),
                      (_imageBytes.isNotEmpty || _imageFiles.isNotEmpty)
                          ? Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                ..._imageBytes.map(
                                    (b) => _buildImagePreview(imageBytes: b)),
                                ..._imageFiles
                                    .map((f) => _buildImagePreview(file: f)),
                              ],
                            )
                          : const Text('لم يتم اختيار صور'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton.icon(
                  onPressed: _publish,
                  icon: const Icon(Icons.publish),
                  label: const Text('نشر المدونة'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
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

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: primaryColor,
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint,
      {int maxLines = 1}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
          ),
        ),
      ),
    );
  }

  Widget _buildImagePreview({Uint8List? imageBytes, io.File? file}) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: imageBytes != null
              ? Image.memory(imageBytes,
                  height: 100, width: 100, fit: BoxFit.cover)
              : Image.file(file!, height: 100, width: 100, fit: BoxFit.cover),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: () {
              setState(() {
                if (imageBytes != null) {
                  _imageBytes.remove(imageBytes);
                } else if (file != null) {
                  _imageFiles.remove(file);
                }
              });
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black45,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(4),
              child: const Icon(Icons.close, color: Colors.white, size: 18),
            ),
          ),
        ),
      ],
    );
  }
}

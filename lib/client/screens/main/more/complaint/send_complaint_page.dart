import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class SendComplaintPage extends StatefulWidget {
  const SendComplaintPage({super.key});

  @override
  State<SendComplaintPage> createState() => _SubmitComplaintPageState();
}

class _SubmitComplaintPageState extends State<SendComplaintPage> {
  final _controller = TextEditingController();
  final List<XFile> _attachments = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImages() async {
    try {
      final images = await _picker.pickMultiImage(
        maxWidth: 1600,
        imageQuality: 85,
      );

      if (images.isEmpty || !mounted) return;

      setState(() => _attachments.addAll(images));
    } on MissingPluginException {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('هذه الميزة غير مدعومة على الجهاز')),
      );
    }
  }

  void _submitComplaint() {
    final complaintText = _controller.text.trim();

    if (complaintText.isEmpty && _attachments.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى كتابة الشكوى أو إرفاق وسائط')),
      );
      return;
    }

    // إرسال البيانات أو منطق الحفظ
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم إرسال الشكوى بنجاح')),
    );

    // إعادة تعيين النموذج
    setState(() {
      _controller.clear();
      _attachments.clear();
    });
  }

  void _cancelComplaint() {
    // تعيد تعيين الحقول بدون إرسال
    setState(() {
      _controller.clear();
      _attachments.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم إلغاء الشكوى')),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 86, 33, 185),
        title: const Text(
          'إرسال شكوى',
          style: TextStyle(color: Colors.white, fontFamily: 'Pacifico'),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _cancelComplaint,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 31, 37, 145),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                icon: const Icon(Icons.cancel),
                label: const Text(
                  'إلغاء',
                  style: TextStyle(fontFamily: 'Pacifico', color: Colors.white),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _submitComplaint,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                icon: const Icon(Icons.send_rounded),
                label: const Text(
                  'إرسال الشكوى',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // حقل الشكوى
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
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'اكتب شكواك هنا...',
                    hintTextDirection: TextDirection.rtl,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // عرض الوسائط المرفقة + زر إضافة وسائط
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                for (final file in _attachments)
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
                              _attachments.remove(file);
                            });
                          },
                          child: Container(
                            decoration: const BoxDecoration(
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

                // زر الإضافة
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
          ],
        ),
      ),
    );
  }
}

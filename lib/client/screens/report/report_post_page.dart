import 'package:flutter/material.dart';

class ReportPostPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPostPage> {
  final TextEditingController _reportController = TextEditingController();

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'تأكيد الإرسال',
            style: TextStyle(fontFamily: 'Pacifico'),
          ),
          content: Text(
            'هل تريد إرسال الإبلاغ؟',
            style: TextStyle(fontFamily: 'Pacifico'),
          ),
          actions: [
            TextButton(
              child: Text(
                'إلغاء',
                style: TextStyle(fontFamily: 'Pacifico'),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // يغلق الـ dialog فقط
              },
            ),
            ElevatedButton(
              child: Text(
                'إرسال',
                style: TextStyle(fontFamily: 'Pacifico'),
              ),
              onPressed: () {
                // قم بإرسال الإبلاغ هنا مثلاً عبر API أو أي منطق آخر
                print('تم إرسال الإبلاغ: ${_reportController.text}');
                Navigator.of(context).pop(); // يغلق الـ dialog
                _showSuccessDialog(); // عرض رسالة نجاح بعد الإرسال
              },
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('تم الإرسال'),
          content: Text('تم إرسال الإبلاغ بنجاح.'),
          actions: [
            TextButton(
              child: Text('حسنًا'),
              onPressed: () {
                Navigator.of(context).pop();
                _reportController.clear(); // مسح النص بعد الإرسال
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _reportController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(
          'إبلاغ',
          style: TextStyle(fontFamily: 'Pacifico', color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _reportController,
              maxLines: 6,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'اكتب تفاصيل الإبلاغ هنا...',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text(
                'إرسال',
                style: TextStyle(fontFamily: 'Pacifico', color: Colors.blue),
              ),
              onPressed: () {
                if (_reportController.text.trim().isNotEmpty) {
                  _showConfirmationDialog();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('يرجى كتابة الإبلاغ أولاً')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

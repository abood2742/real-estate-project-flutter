import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:property_system/client/models/notification_model.dart';
import 'package:property_system/client/services/notification_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late IO.Socket socket;
  List<NotificationModel>? notifications; // nullable لعرض مؤشر التحميل

  @override
  void initState() {
    super.initState();
    getAllNotification();
  }

  Future<void> getAllNotification() async {
    final data = await NotificationService().getAllNotifications();
    setState(() {
      notifications = data;
    });
  }

  bool _isArabic(String text) {
    final arabicRegex = RegExp(r'[\u0600-\u06FF]');
    return arabicRegex.hasMatch(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        shadowColor: Colors.blue,
        title: const Text(
          'إشعاراتي',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 99, 163, 215),
      ),
      body: notifications == null
          ? const Center(child: CircularProgressIndicator()) // حالة التحميل
          : notifications!.isEmpty
              ? const Center(
                  child: Text(
                    'لا توجد إشعارات',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : ListView.builder(
                  itemCount: notifications!.length,
                  itemBuilder: (context, index) {
                    final item = notifications![index];
                    bool isArabicTitle = _isArabic(item.title);
                    bool isArabicBody = _isArabic(item.message);

                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                              textAlign: isArabicTitle
                                  ? TextAlign.right
                                  : TextAlign.left,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.message,
                              style: const TextStyle(color: Colors.blue),
                              textAlign: isArabicBody
                                  ? TextAlign.right
                                  : TextAlign.left,
                            ),
                            const SizedBox(height: 8),
                            const SizedBox(height: 4),
                            Text('Created At:  ${formatDate(item.createdAt)}',
                                style: const TextStyle(
                                    fontSize: 12, fontStyle: FontStyle.italic)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  String formatDate(String dateStr) {
    try {
      final dateTime = DateTime.parse(dateStr);
      return DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
    } catch (e) {
      return dateStr;
    }
  }
}

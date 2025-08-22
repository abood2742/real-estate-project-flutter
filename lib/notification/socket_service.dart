import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static final SocketService _instance = SocketService._internal();
  late IO.Socket socket;

  factory SocketService() {
    return _instance;
  }

  SocketService._internal();

  void connect(String userId) async {
    bool state = await checkIfNotificationsEnabled();
    if (state) {
      socket = IO.io('http://localhost:3000', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
      });

      socket.onConnect((_) {
        print('Connected to server');
        socket.emit('registerUser', userId);
      });

      socket.on('receiveNotification', (data) {
        print('New receiveNotification: $data');
        // هنا ممكن تضيف كود لإظهار إشعار في التطبيق

        // افترض أن البيانات تحتوي على title و body
        final title = data['title'] ?? 'إشعار جديد';
        final body = data['message'] ?? 'لديك رسالة جديدة';

        // إظهار إشعار باستخدام overlay_support
        showSimpleNotification(
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(body),
          leading: Icon(Icons.notifications, color: Colors.white),
          background: Colors.blue,
          autoDismiss: true, // يغلق تلقائياً بعد وقت قصير
          slideDismiss: true, // يمكن للمستخدم سحب الإشعار لإغلاقه
        );
      });

      socket.onDisconnect((_) {
        print('Disconnected from server');
      });
    }
  }

  void sendNotification(Map<String, dynamic> data) {
    socket.emit('sendNotification', data);
  }

  /// دالة لإيقاف استقبال الإشعارات وإغلاق الاتصال
  void disconnect() {
    // إلغاء الاستماع على جميع الأحداث
    socket.off('receiveNotification');
    socket.off('connect');
    socket.off('disconnect');

    // إغلاق الاتصال مع السيرفر
    socket.disconnect();
    socket.close();

    print('Notifications stopped and socket disconnected');
  }

  Future<bool> checkIfNotificationsEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    bool? state = prefs.getBool('notifications_enabled');
    if (state != null && state) {
      return true;
    } else if (state != null && !state) {
      return false;
    }
    return false;
  }
}

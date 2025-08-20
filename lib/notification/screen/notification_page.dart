
// import 'package:flutter/material.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// class NotificationPage extends StatefulWidget {
//   const NotificationPage({Key? key}) : super(key: key);

//   @override
//   _NotificationPageState createState() => _NotificationPageState();
// }

// class _NotificationPageState extends State<NotificationPage> {
//   late IO.Socket socket;
//   List<dynamic> notifications = [];

//   @override
//   void initState() {
//     super.initState();

//     // إشعار تجريبي فقط لرؤية الشكل
//     notifications
//         .add({'title': 'Test Notification', 'body': 'This is just a UI test'});
//     notifications
//         .add({'title': 'Test Notification', 'body': 'This is just a UI test'});
//     notifications
//         .add({'title': 'Test Notification', 'body': 'This is just a UI test'});
//     notifications
//         .add({'title': 'Test Notification', 'body': 'This is just a UI test'});
//     notifications
//         .add({'title': 'Test Notification', 'body': 'This is just a UI test'});

//     _connectToSocket();
//   }

//   void _connectToSocket() {
//     socket = IO.io('http://localhost:3000', <String, dynamic>{
//       'transports': ['websocket'],
//       'autoConnect': true,
//     });

//     socket.onConnect((_) {
//       print('Connected');
//     });

//     socket.on('newNotification', (data) {
//       setState(() {
//         notifications.add(data);
//       });
//     });

//     socket.onDisconnect((_) => print('Disconnected'));
//   }

//   @override
//   void dispose() {
//     socket.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(60, 49, 26, 131),
//       appBar: AppBar(
//         title: const Text('Notifications'),
//       ),
//       body: ListView.builder(
//         itemCount: notifications.length,
//         itemBuilder: (context, index) {
//           final item = notifications[index];
//           return Card(
//             margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             child: ListTile(
//               title: Text(
//                 item['title'].toString(),
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text(
//                 item['body'].toString(),
//                 style: TextStyle(color: Colors.blue),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late IO.Socket socket;
  List<dynamic> notifications = [];

  @override
  void initState() {
    super.initState();

    // إشعارات تجريبية
    notifications.add({'title': 'إشعار تجريبي', 'body': 'هذا مجرد اختبار واجهة'});
    notifications.add({'title': 'Test Notification', 'body': 'This is just a UI test'});
    notifications.add({'title': 'إشعار آخر', 'body': 'اختبار الاتجاه العربي'});
    notifications.add({'title': 'Another Notification', 'body': 'LTR text example'});

    _connectToSocket();
  }

  void _connectToSocket() {
    socket = IO.io('http://localhost:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket.onConnect((_) {
      print('Connected');
    });

    socket.on('newNotification', (data) {
      setState(() {
        notifications.add(data);
      });
    });

    socket.onDisconnect((_) => print('Disconnected'));
  }

  bool _isArabic(String text) {
    final arabicRegex = RegExp(r'[\u0600-\u06FF]');
    return arabicRegex.hasMatch(text);
  }

  @override
  void dispose() {
    socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(60, 49, 26, 131),
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: const Color.fromARGB(255, 12, 46, 74),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final item = notifications[index];
          bool isArabicTitle = _isArabic(item['title'].toString());
          bool isArabicBody = _isArabic(item['body'].toString());

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                item['title'].toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
                textAlign: isArabicTitle ? TextAlign.right : TextAlign.left,
              ),
              subtitle: Text(
                item['body'].toString(),
                style: const TextStyle(color: Colors.blue),
                textAlign: isArabicBody ? TextAlign.right : TextAlign.left,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          );
        },
      ),
    );
  }
}

import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  void connect() {
   socket = IO.io('http://localhost:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket.onConnect((_) {
      print('Connected to server');
    });

    socket.on('newNotification', (data) {
      print('New notification: $data');
      // هنا ممكن تضيف كود لإظهار إشعار في التطبيق
    });

    socket.onDisconnect((_) {
      print('Disconnected from server');
    });
  }

  void sendNotification(Map<String, dynamic> data) {
    socket.emit('sendNotification', data);
  }
}

import 'package:dio/dio.dart';
import 'package:property_system/client/models/notification_model.dart';
import 'package:property_system/client/services/token_service.dart';
import 'package:property_system/client/services/profile_service_done.dart';
//import 'package:property_system/client/services/user_profile.service.dart';

class NotificationService {
  Future<void> notifyUser(
      {required String title, required String message}) async {
    Dio dio = new Dio();

    final userId = await ProfileService().getProfile();

    final accessToken = await AuthService.getAccessToken();
    // if (userId != null) {
    final body = {"userId": userId!.id, 'title': title, 'message': message};
    try {
      await dio.post('http://localhost:3000/api/notification/notify-user',
          data: body,
          options: Options(headers: {
            'Authorization': 'Bearer $accessToken',
          }));
    } catch (e) {
      print(e);
    }
    // } else {
    //   print('You have to login or register first');
    //   return;
    // }
  }

  Future<List<NotificationModel>?> getAllNotifications() async {
    Dio dio = new Dio();

    final userId = await ProfileService().getProfile();

    final accessToken = await AuthService.getAccessToken();
    // if (userId != null) {

    try {
      Response response =
          await dio.get('http://localhost:3000/api/notification/user/${userId!.id}',
              options: Options(headers: {
                'Authorization': 'Bearer $accessToken',
              }));

      if (response.statusCode == 200) {
        List<dynamic> list = response.data;

        List<NotificationModel> notifications = [];

        var notification;
        for (int i = 0; i < list.length; i++) {
          notification = NotificationModel.fromJson(list[i]);
          notifications.add(notification);
        }
        return notifications;
      } else {
        print('You don\'t have any notifications');
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<List<NotificationModel>?> getUnreadNotifications() async {
    Dio dio = new Dio();

    //final userId = await ProfileService().getProfile();

    final accessToken = await AuthService.getAccessToken();
    // if (userId != null) {

    try {
      Response response =
          await dio.get('http://localhost:3000/api/notification/user',
              options: Options(headers: {
                'Authorization': 'Bearer $accessToken',
              }));

      if (response.statusCode == 200) {
        List<dynamic> list = response.data;

        List<NotificationModel> notifications = [];

        var notification;
        for (int i = 0; i < list.length; i++) {
          notification = NotificationModel.fromJson(list[i]);
          notifications.add(notification);
        }
        return notifications;
      } else {
        print('You don\'t have any notifications');
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}

import 'package:dio/dio.dart';
import 'package:property_system/client/models/ching_password_model.dart';
import 'package:property_system/client/services/token_service.dart';

class ChangePasswordService {
  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    Dio dio = Dio();

    final body = {
      'current_password': currentPassword,
      'new_password': newPassword,
      'confirm_password': confirmPassword,
    };

  var token = await AuthService.getAccessToken();
  print(token);
    try {
      Response response = await dio.post(
        'http://localhost:3000/api/user/edite-password',
        data: body,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 201) {
        print('Password changed successfully');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      if (e is DioError) {
        print('Error response: ${e.response?.data}');
      }
      print('Exception: $e');
      return false;
    }
  }
}

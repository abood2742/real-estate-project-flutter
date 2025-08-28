import 'package:dio/dio.dart';
import 'package:property_system/client/models/auth_model.dart';
import 'package:property_system/client/services/token_service.dart';

class LoginService {
  Future<AuthModel?> login(
      {required String email, required String password}) async {
    Dio dio = Dio();

    final body = {'email': email, 'password': password};

    try {
      Response response =
          await dio.post('http://localhost:3000/api/user/login', data: body);

      if (response.statusCode == 201) {
        AuthModel authModel = AuthModel.fromJson(response.data);

        await AuthService.saveAccessToken(authModel.accessToken);
        await AuthService.saveAccessToken(authModel.refreshToken);
        await AuthService.saveUserRole(authModel.role!);

        print('accessToken = ${await AuthService.getAccessToken()}');
        print('accessToken = ${await AuthService.getUserRole()}');

        return authModel;
      } else {
        return null;
      }
    } catch (e) {
      if (e is DioError) {
        print('Error response: ${e.response?.data}');
      }
      print('Exception: $e');
      return null;
    }
  }
}

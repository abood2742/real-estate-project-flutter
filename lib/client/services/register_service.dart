import 'dart:io';

import 'package:dio/dio.dart';
import 'package:property_system/client/models/start_register_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterService {
  Future<StartRegisterModel?> startRegisterPost(
      {required String email, required String phoneNumber}) async {
    print("$email , + , $phoneNumber");
    Dio dio = Dio();

    final body = {
      'email': email,
      'phone': phoneNumber,
    };
    try {
      Response response = await dio.post(
        'http://localhost:3000/api/user/start-register',
        data: body,
      );

      if (response.statusCode == 201) {
        StartRegisterModel startRegisterModel =
            StartRegisterModel.fromJson(response.data);

        print("done");
        print(startRegisterModel);
        print(startRegisterModel.runtimeType);

        final prefs = await SharedPreferences.getInstance();

        await prefs.setString('accessToken', startRegisterModel.accessToken);
        await prefs.setString('refreshToken', startRegisterModel.refreshToken);

        return startRegisterModel;
      } else {
        print('gyg');

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

  Future<bool?> verifyCodePost({required String verifyCode}) async {
    Dio dio = Dio();

    final body = {
      'verify_code': verifyCode,
    };

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');

    print(token);

    try {
      Response response =
          await dio.post('http://localhost:3000/api/user/verify-code',
              data: body,
              options: Options(
                headers: {
                  'Authorization': 'Bearer $token',
                },
              ));

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      if (e is DioError) {
        print('Error response: ${e.response?.data}');
      }
      print('Exception: $e');
      return null;
    }
  }

  Future<bool?> enterInfoPost({
    required String firstName,
    required String lastName,
    required String nationalNumber,
    required String receiverIdentifier,
    required String password,
    File? image, // خليها nullable عشان ممكن ما ترسلش صورة
  }) async {
    Dio dio = Dio();

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');

    try {
      FormData formData = FormData.fromMap({
        'first_name': firstName,
        'last_name': lastName,
        'national_number': nationalNumber,
        'receiverIdentifier': receiverIdentifier,
        'password': password,
        if (image != null)
          'profile_photo': await MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
          ),
      });

      Response response = await dio.post(
        'http://localhost:3000/api/user/complete-register',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data', // مهم جدًا
          },
        ),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
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

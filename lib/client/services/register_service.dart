import 'dart:io';
import 'package:dio/dio.dart';
import 'package:property_system/client/models/auth_model.dart';
import 'package:property_system/client/services/token_service.dart';

class RegisterService {
  Future<AuthModel?> startRegisterPost(
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
        AuthModel authModel = AuthModel.fromJson(response.data);

        AuthService.saveAccessToken(authModel.accessToken);
        AuthService.saveAccessToken(authModel.refreshToken);

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

  Future<bool?> verifyCodePost({required String verifyCode}) async {
    Dio dio = Dio();

    final body = {
      'verify_code': verifyCode,
    };

    var token = await AuthService.getAccessToken();

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

  Future<bool?> enterClientInfoPost({
    required String firstName,
    required String lastName,
    required String nationalNumber,
    required String receiverIdentifier,
    required String password,
    File? image, // خليها nullable عشان ممكن ما ترسلش صورة
  }) async {
    Dio dio = Dio();

    var token = await AuthService.getAccessToken();

    try {
      FormData formData = FormData.fromMap({
        'first_name': firstName,
        'last_name': lastName,
        'national_number': nationalNumber,
        'receiver_identifier': receiverIdentifier,
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

  Future<bool?> enterOfficeInfoPost({
    required String officeName,
    required String password,
    required String licenseNumber,
    required String personalIdentityNumber,
    required String receiverIdentifier,
    File? officePhoto, // خليها nullable عشان ممكن ما ترسلش صورة
    File? licensePhoto,
  }) async {
    Dio dio = Dio();

    var token = await AuthService.getAccessToken();

    try {
      FormData formData = FormData.fromMap({
        'name': officeName,
        'license_number': licenseNumber,
        'personal_identity_number': personalIdentityNumber,
        'receiver_identifier': receiverIdentifier,
        'password': password,
        if (licensePhoto != null)
          'license_photo': await MultipartFile.fromFile(
            licensePhoto.path,
            filename: licensePhoto.path.split('/').last,
          ),
        if (officePhoto != null)
          'office_photo': await MultipartFile.fromFile(
            officePhoto.path,
            filename: officePhoto.path.split('/').last,
          ),
      });

      Response response = await dio.post(
        'http://localhost:3000/api/office/create-office',
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

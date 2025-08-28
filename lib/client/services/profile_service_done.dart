import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:property_system/client/models/client_info_model.dart';
import 'package:property_system/client/models/profile.model.dart';
import 'package:property_system/client/services/token_service.dart';

class ProfileService {
  Future<ProfileModel?> getProfile() async {
    //done
    Dio dio = Dio();

    var token = await AuthService.getAccessToken();

    try {
      Response response =
          await dio.get('http://localhost:3000/api/user/get-current',
              options: Options(headers: {
                'Authorization': 'Bearer $token',
                //    'Content-Type': 'multipart/form-data', // مهم جدًا
              }));

      if (response.statusCode == 200) {
        ProfileModel profileModel = ProfileModel.fromJson(response.data);
        return profileModel;
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

  Future<ProfileModel?> getUserById({required String userId}) async {
    Dio dio = Dio();

    var token = await AuthService.getAccessToken();

    try {
      Response response =
          await dio.get('http://localhost:3000/api/user/$userId',
              options: Options(headers: {
                'Authorization': 'Bearer $token',
                //    'Content-Type': 'multipart/form-data', // مهم جدًا
              }));

      if (response.statusCode == 200) {
        ProfileModel profileModel = ProfileModel.fromJson(response.data);
        return profileModel;
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

  Future<ClientInfoModel> updateClientInfo({
    required String firstName,
    required String lastName,
    required String receiverIdentifier,
    dynamic profilePhoto, // Uint8List على الويب، File على الجوال أو null
  }) async {
    Dio dio = new Dio();
    try {
      var token = await AuthService.getAccessToken();

      FormData formData = FormData.fromMap({
        'first_name': firstName,
        'last_name': lastName,
        'receiver_identifier': receiverIdentifier,
      });

      if (profilePhoto != null) {
        if (kIsWeb && profilePhoto is Uint8List) {
          MediaType? mediaType = detectImageMimeType(profilePhoto);
          mediaType ??= MediaType('image', 'jpeg');

          formData.files.add(
            MapEntry(
              'profile_photo',
              MultipartFile.fromBytes(
                profilePhoto,
                filename: 'profile_photo.${mediaType.subtype}',
                contentType: mediaType,
              ),
            ),
          );
        } else if (!kIsWeb && profilePhoto is File) {
          String ext = profilePhoto.path.split('.').last;
          MediaType mediaType = getMediaTypeFromExtension(ext);

          formData.files.add(
            // ifohasifa
            MapEntry(
              'profile_photo',
              await MultipartFile.fromFile(
                profilePhoto.path,
                filename: profilePhoto.path.split('/').last,
                contentType: mediaType,
              ),
            ),
          );
        } else {
          throw Exception('نوع الصورة غير مدعوم');
        }
      }

      final response = await dio.put(
        'http://localhost:3000/api/user/update-profile',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      return ClientInfoModel.fromJson(response.data);
    } catch (e) {
      throw Exception('فشل في تحديث معلومات العميل: $e');
    }
  }

  // للتعرف على نوع الصورة في الويب
  MediaType? detectImageMimeType(Uint8List bytes) {
    if (bytes.length < 12) return null;

    if (bytes[0] == 0xFF && bytes[1] == 0xD8 && bytes[2] == 0xFF) {
      return MediaType('image', 'jpeg');
    }
    if (bytes[0] == 0x89 &&
        bytes[1] == 0x50 &&
        bytes[2] == 0x4E &&
        bytes[3] == 0x47 &&
        bytes[4] == 0x0D &&
        bytes[5] == 0x0A &&
        bytes[6] == 0x1A &&
        bytes[7] == 0x0A) {
      return MediaType('image', 'png');
    }
    return null;
  }

  // للتعرف على نوع الصورة في الجوال
  MediaType getMediaTypeFromExtension(String ext) {
    switch (ext.toLowerCase()) {
      case 'jpg':
      case 'jpeg':
        return MediaType('image', 'jpeg');
      case 'png':
        return MediaType('image', 'png');
      case 'avif':
        return MediaType('image', 'avif');
      default:
        return MediaType('application', 'octet-stream');
    }
  }


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

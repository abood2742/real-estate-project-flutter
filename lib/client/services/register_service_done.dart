import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:property_system/client/models/auth_model.dart';
import 'package:property_system/client/services/token_service.dart';
import 'package:http_parser/http_parser.dart';

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
        AuthService.saveUserRole('user');


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

  Future<bool?> enterInfoPost({
    required String firstName,
    required String lastName,
    required String nationalNumber,
    required String receiverIdentifier,
    required String password,
    dynamic image, // على الهاتف File، وعلى الويب Uint8List
  }) async {
    var token = await AuthService.getAccessToken();

    Dio dio = new Dio();
    try {
      FormData formData = FormData.fromMap({
        'first_name': firstName,
        'last_name': lastName,
        'national_number': nationalNumber,
        'receiver_identifier': receiverIdentifier,
        'password': password,
      });

      if (image != null) {
        if (kIsWeb) {
          formData.files.add(
            MapEntry(
              'profile_photo',
              MultipartFile.fromBytes(
                image, // Uint8List
                filename: 'upload.jpg',
              ),
            ),
          );
        } else {
          formData.files.add(
            MapEntry(
              'profile_photo',
              await MultipartFile.fromFile(
                image.path,
                filename: image.path.split('/').last,
              ),
            ),
          );
        }
      }

      Response response = await dio.post(
        'http://localhost:3000/api/user/complete-register',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 201) {
        print(response.data);
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

  Future<CreateOfficeResponce?> createOfficePost({
    required String officeName,
    required String officeEmail,
    required String officePhone,
    required String licenseNumber,
    required String personalIdentityNumber,
    dynamic officePhoto, // Uint8List على الويب، File على الجوال أو null
    dynamic licensePhoto, // كذلك
  }) async {
    Dio dio = Dio();

    var token = await AuthService.getAccessToken();

    try {
      FormData formData = FormData.fromMap({
        'name': officeName,
        'office_email': officeEmail,
        'office_phone': officePhone,
        'license_number': licenseNumber,
        'personal_identity_number': personalIdentityNumber,
      });

      if (officePhoto != null) {
        if (kIsWeb) {
          // officePhoto هو Uint8List
          MediaType? mediaType = detectImageMimeType(officePhoto);
          mediaType ??= MediaType('image', 'jpeg'); // افتراض

          formData.files.add(
            MapEntry(
              'office_photo',
              MultipartFile.fromBytes(
                officePhoto,
                filename: 'office_photo.${mediaType.subtype}',
                contentType: mediaType,
              ),
            ),
          );
        } else {
          // على الجوال، officePhoto هو File
          String ext = officePhoto.path.split('.').last;
          MediaType mediaType = getMediaTypeFromExtension(ext);

          formData.files.add(
            MapEntry(
              'office_photo',
              await MultipartFile.fromFile(
                officePhoto.path,
                filename: officePhoto.path.split('/').last,
                contentType: mediaType,
              ),
            ),
          );
        }
      }

      if (licensePhoto != null) {
        if (kIsWeb) {
          MediaType? mediaType = detectImageMimeType(licensePhoto);
          mediaType ??= MediaType('image', 'jpeg');

          formData.files.add(
            MapEntry(
              'license_photo',
              MultipartFile.fromBytes(
                licensePhoto,
                filename: 'license_photo.${mediaType.subtype}',
                contentType: mediaType,
              ),
            ),
          );
        } else {
          String ext = licensePhoto.path.split('.').last;
          MediaType mediaType = getMediaTypeFromExtension(ext);

          formData.files.add(
            MapEntry(
              'license_photo',
              await MultipartFile.fromFile(
                licensePhoto.path,
                filename: licensePhoto.path.split('/').last,
                contentType: mediaType,
              ),
            ),
          );
        }
      }

      Response response = await dio.post(
        'http://localhost:3000/api/office/create-office',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 201) {
        CreateOfficeResponce createOfficeResponce =
            CreateOfficeResponce.fromJson(response.data, true);
        return createOfficeResponce;
      } else {
        CreateOfficeResponce createOfficeResponce =
            CreateOfficeResponce.fromJson(response.data, false);
        return createOfficeResponce;
      }
    } catch (e) {
      if (e is DioError) {
        print('Error response: ${e.response?.data}');
      }
      print('Exception: $e');
      return null;
    }
  }

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
    // ممكن تضيف avif أو غيرها إذا تعرف طريقة فحصها

    return null;
  }

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
}

class CreateOfficeResponce {
  final bool statusCode;
  final String message;

  CreateOfficeResponce({required this.statusCode, required this.message});

  factory CreateOfficeResponce.fromJson(
          Map<String, dynamic> json, bool statusCode) =>
      CreateOfficeResponce(
        statusCode: statusCode,
        message: json["message"],
      );
}

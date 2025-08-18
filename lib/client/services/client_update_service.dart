import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:property_system/client/models/client_info_model.dart';
import 'package:property_system/client/services/token_service.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:io';


class UpdateProductService {
  final Dio _dio = Dio();

  Future<ClientInfoModel> updateClientInfo({
    required String firstName,
    required String lastName,
    required String receiverIdentifier,
    dynamic profilePhoto, // Uint8List على الويب، File على الجوال أو null
  }) async {
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

          formData.files.add( // ifohasifa
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

      final response = await _dio.put(
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
}

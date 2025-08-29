import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http_parser/http_parser.dart';
import 'package:property_system/client/models/complaient/create_office_complaint_model.dart';
import 'package:property_system/client/models/complaient/get_case_2_complainet_model.dart';
import 'package:property_system/client/models/complaient/get_case_4_complainet_model.dart';
import 'package:property_system/client/services/token_service.dart';

class PropertyComplaintService {
  final Dio _dio = Dio();
  Future<Response> createComplaint(
      CreateOfficeComplaintModel complaint, List<dynamic> images) async {
    try {
      final token = await AuthService.getAccessToken();
      print('enter to service ');

      // تجهيز البيانات النصية
      FormData formData = FormData.fromMap({
        "propertyId": complaint.officeId,
        "title": complaint.title,
        "content": complaint.content,
      });

      // إضافة الصور بنفس منطق ProfileService
      for (int i = 0; i < images.length; i++) {
        if (kIsWeb && images[i] is Uint8List) {
          MediaType? mediaType = detectImageMimeType(images[i]);
          mediaType ??= MediaType('image', 'jpeg');

          formData.files.add(
            MapEntry(
              "complaint_media",
              MultipartFile.fromBytes(
                images[i],
                filename: "image_$i.${mediaType.subtype}",
                contentType: mediaType,
              ),
            ),
          );
        } else if (!kIsWeb && images[i] is File) {
          final file = images[i] as File;
          String ext = file.path.split('.').last;
          MediaType mediaType = getMediaTypeFromExtension(ext);

          formData.files.add(
            MapEntry(
              "complaint_media",
              await MultipartFile.fromFile(
                file.path,
                filename: file.path.split('/').last,
                contentType: mediaType,
              ),
            ),
          );
        } else {
          throw Exception('نوع الملف غير مدعوم');
        }
      }
      print('yes');

      // إرسال للـ API
      final response = await _dio.post(
        'http://localhost:3000/api/property-complaint',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      print('no');

      return response;
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<GetCase2ComplainetModel>?> getUserComplaintsOnProperties() async {
    var token = await AuthService.getAccessToken();

    try {
      Response response =
          await _dio.get('http://localhost:3000/api/property-complaint/user',
              options: Options(headers: {
                'Authorization': 'Bearer $token',
                'Content-Type': 'multipart/form-data',
              }));

      if (response.statusCode == 200) {
        List<dynamic> list = response.data;

        List<GetCase2ComplainetModel> complaints = [];

        var complaint;

        for (int i = 0; i < list.length; i++) {
          complaint = GetCase2ComplainetModel.fromJson(list[i]);
          complaints.add(complaint);
        }

        return complaints;
      }
    } on DioError catch (e) {
      throw _handleError(e);
    }
    return null;
  }

  Future<List<GetCase4ComplainetModel>?>
      getAllComplaintsOnOfficeProperties() async {
    var token = await AuthService.getAccessToken();
    try {
      Response response =
          await _dio.get('http://localhost:3000/api/property-complaint',
              options: Options(headers: {
                'Authorization': 'Bearer $token',
                'Content-Type': 'multipart/form-data',
              }));

      if (response.statusCode == 200) {
        List<dynamic> list = response.data;

        List<GetCase4ComplainetModel> complaints = [];

        var complaint;

        for (int i = 0; i < list.length; i++) {
          complaint = GetCase4ComplainetModel.fromJson(list[i]);
          complaints.add(complaint);
        }

        return complaints;
      }
    } on DioError catch (e) {
      throw _handleError(e);
    }
    return null;
  }

  // التعرف على نوع الصورة (للويب)
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

  // التعرف على نوع الصورة (للموبايل)
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

  String _handleError(DioError error) {
    if (error.response != null) {
      return 'خطأ من الخادم: ${error.response?.statusCode} - ${error.response?.data}';
    } else {
      return 'خطأ في الاتصال: ${error.message}';
    }
  }
}

import 'dart:convert';
import 'dart:io' as io;
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:property_system/client/services/token_service.dart';

class PropertyService {
  Future<bool?> createProperty({
    required String propertyNumber,
    required String owner,
    required String typeOperation,
    required double space,
    required double price,
    required String description,
    required String propertyTypeId,
    required String governorate,
    required String province,
    required String city,
    required String street,
    required String licenseType,
    required String licenseNumber,
    required List<Map<String, dynamic>> attributes,
    required List<dynamic> propertyPhotos,
  }) async {
    Dio dio = Dio();

    FormData formData = FormData();

    // البيانات الأساسية
    formData.fields.addAll([
      MapEntry('propertyNumber', propertyNumber),
      MapEntry('owner', owner),
      MapEntry('typeOperation', typeOperation),
      MapEntry('space', space.toString()),
      MapEntry('price', price.toString()),
      MapEntry('description', description),
      MapEntry('propertyType', propertyTypeId),
      MapEntry('licenseType', licenseType),
      MapEntry('licenseNumber', licenseNumber),
      MapEntry(
        'location',
        jsonEncode({
          'governorate': governorate,
          'province': province,
          'city': city,
          'street': street,
        }),
      ),
    ]);

    // الصفات (attributes) - JSON String
    formData.fields.add(MapEntry("attributes", jsonEncode(attributes)));
    // الصور
    for (var photo in propertyPhotos) {
      if (photo is io.File) {
        final ext = photo.path.split('.').last.toLowerCase();
        final mimeType = ext == "png"
            ? MediaType("image", "png")
            : MediaType("image", "jpeg");

        formData.files.add(MapEntry(
          'property_photos',
          await MultipartFile.fromFile(
            photo.path,
            filename: photo.path.split('/').last,
            contentType: mimeType,
          ),
        ));
      } else if (photo is Uint8List) {
        formData.files.add(MapEntry(
          'property_photos',
          MultipartFile.fromBytes(
            photo,
            filename: "upload.jpg",
            contentType: MediaType("image", "jpeg"),
          ),
        ));
      }
    }

    // التوكن
    var token = await AuthService.getAccessToken();

    try {
      final response = await dio.post(
        'http://localhost:3000/api/property',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      print(response.data);
      return true;
    } on DioException catch (e) {
      print("Status code: ${e.response?.statusCode}");
      print("Response data: ${e.response?.data}");
      return null;
    }
  }

  Future<bool?> PayBeforeDeletePropertyById({
    required String type,
    required String cardNumber,
    required int expiryMonth,
    required int expiryYear,
    required String cvv,
    required String propertyId,
  }) async {
    Dio dio = Dio();

    final body = {
      'type': type,
      'expiryYear': expiryYear,
      'cardNumber': cardNumber,
      'expiryMonth': expiryMonth,
      'cvv': cvv
    };

    // التوكن
    var token = await AuthService.getAccessToken();

    try {
      final response = await dio.post(
        'http://localhost:3000/api/property/pay-before/$propertyId',
        data: body,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      print(response.data);
      return true;
    } on DioException catch (e) {
      print("Status code: ${e.response?.statusCode}");
      print("Response data: ${e.response?.data}");
      return null;
    }
  }
}

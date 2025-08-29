import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:property_system/client/services/token_service.dart';

class PropertyRequestService {
  Future<String?> sendPropertyRequest({
    required String property_Number,
    required String propertyType,
    required String typeOfPropertyType,
    required String space,
    required String location_Id,
    required int owner_personal_Identity_Number,
    required String owner_name,
    required int client_personal_Identity_Number,
    required String client_name,
    required double price,
    required String type,
    DateTime? sell_Date,
    DateTime? rental_Start_Date,
    DateTime? rental_End_Date,
  }) async {
    Dio dio = Dio();
    var token = await AuthService.getAccessToken();

    // إنشاء الـ DTOs كـ Maps مع معالجة صحيحة للتواريخ
    final createArchiveDto = {
      "property_Number": property_Number,
      "propertyType": propertyType,
      "typeOfPropertyType": typeOfPropertyType,
      "space": space,
      "location_Id": location_Id
    };

    final createRecordDto = <String, dynamic>{
      "owner_personal_Identity_Number": owner_personal_Identity_Number,
      "owner_name": owner_name,
      "client_personal_Identity_Number": client_personal_Identity_Number,
      "client_name": client_name,
      "price": price,
      "type": type,
    };

    // إضافة التواريخ فقط إذا كانت موجودة
    if (sell_Date != null) {
      createRecordDto["sell_Date"] = sell_Date.toLocal().toIso8601String().split('T')[0];

    }
    if (rental_Start_Date != null) {
      createRecordDto["rental_Start_Date"] =
          rental_Start_Date.toLocal().toIso8601String().split('T')[0];
    }
    if (rental_End_Date != null) {//2025-08-28T20:44:45.041Z
      createRecordDto["rental_End_Date"] = rental_End_Date.toLocal().toIso8601String().split('T')[0];
    }

    try {
      // استخدام FormData بدلاً من JSON لتوافق أفضل مع NestJS Transform
      FormData formData = FormData.fromMap({
        "createArchiveDto": jsonEncode(createArchiveDto),
        "createRecordDto": jsonEncode(createRecordDto),
      });

      print("Sending FormData:");
      print("createArchiveDto: ${jsonEncode(createArchiveDto)}");
      print("createRecordDto: ${jsonEncode(createRecordDto)}");

      Response response =
          await dio.post('http://localhost:3000/api/property-request',
              data: formData,
              options: Options(headers: {
                'Authorization': 'Bearer $token',
              }));

      if (response.statusCode == 201 || response.statusCode == 200) {
        print("Success: ${response.data}");
        return "Request sent successfully";
      } else {
        print("Unexpected status code: ${response.statusCode}");
        return "Request failed to send";
      }
    } on DioException catch (e) {
      print("DioException occurred:");
      print("Status code: ${e.response?.statusCode}");
      print("Response data: ${e.response?.data}");
      print("Error message: ${e.message}");

      if (e.response?.statusCode == 400) {
        print("Validation error details: ${e.response?.data}");
      }

      return "Request failed: ${e.response?.data ?? e.message}";
    } catch (e) {
      print("Unexpected error: $e");
      return "Unexpected error occurred";
    }
  }

  // دالة مساعدة لتصحيح البيانات قبل الإرسال
  Map<String, dynamic> _debugRequestData({
    required String property_Number,
    required String propertyType,
    required String typeOfPropertyType,
    required String space,
    required String location_Id,
    required int owner_personal_Identity_Number,
    required String owner_name,
    required int client_personal_Identity_Number,
    required String client_name,
    required double price,
    required String type,
    DateTime? sell_Date,
    DateTime? rental_Start_Date,
    DateTime? rental_End_Date,
  }) {
    return {
      "Archive": {
        "property_Number": property_Number,
        "propertyType": propertyType,
        "typeOfPropertyType": typeOfPropertyType,
        "space": space,
        "location_Id": location_Id,
      },
      "Record": {
        "owner_personal_Identity_Number": owner_personal_Identity_Number,
        "owner_name": owner_name,
        "client_personal_Identity_Number": client_personal_Identity_Number,
        "client_name": client_name,
        "price": price,
        "type": type,
        "sell_Date": sell_Date?.toIso8601String(),
        "rental_Start_Date": rental_Start_Date?.toIso8601String(),
        "rental_End_Date": rental_End_Date?.toIso8601String(),
      }
    };
  }
}

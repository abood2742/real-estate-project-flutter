// // // import 'package:dio/dio.dart';
// // // import 'package:property_system/client/models/complaient/create_office_complainet_model.dart';
// // // import 'package:property_system/client/services/token_service.dart';

// // // class ComplaintService {
// // //   final Dio _dio = Dio();

// // //   Future<Response> createComplaint(CreateOfficeComplainetModel complaint) async {
// // //     try {
// // //    final token = await AuthService.getAccessToken();
// // //       print('TOKEN = $token');


// // //       final response = await _dio.post(
// // //        'http://localhost:3000/api/office-complaint',
// // //         data: complaint.toJson(),
// // //         options: Options(
// // //           headers: {
// // //                        'Authorization': 'Bearer $token',

// // //             // أضف أي هيدرات أخرى مطلوبة مثل التوكن
// // //           },
// // //         ),
// // //       );
// // //       return response;
// // //     } on DioError catch (e) {
// // //       throw _handleError(e);
// // //     }
// // //   }

// // //   String _handleError(DioError error) {
// // //     if (error.response != null) {
// // //       return 'خطأ من الخادم: ${error.response?.statusCode} - ${error.response?.data}';
// // //     } else {
// // //       return 'خطأ في الاتصال: ${error.message}';
// // //     }
// // //   }
// // // }

// // import 'package:dio/dio.dart';
// // import 'package:property_system/client/models/complaient/create_office_complainet_model.dart';
// // import 'package:property_system/client/services/token_service.dart';

// // class ComplaintService {
  

// //   final Dio _dio = Dio();
// //   Future<Response> createComplaint(CreateOfficeComplainetModel complaint) async {
// //     try {
// //       final token = await AuthService.getAccessToken();
// //       print('TOKEN = $token');
// //    print('2');
// // print("🚀 Data before sending to server: $complaint");
// //       final response = await _dio.post(
// //         'http://localhost:3000/api/office-complaint',
// //         data: complaint.toJson(),
// //         options: Options(
// //           headers: {
// //             'Authorization': 'Bearer $token',
// //           },
// //         ),
// //       );
// //          print('3');

// //       return response;
// //     } on DioError catch (e) {
// //       throw _handleError(e);
// //     }
// //   }

// //   String _handleError(DioError error) {
// //     if (error.response != null) {
// //       return 'خطأ من الخادم: ${error.response?.statusCode} - ${error.response?.data}';
// //     } else {
// //       return 'خطأ في الاتصال: ${error.message}';
// //     }
// //   }
// // }
// import 'dart:convert';
// import 'package:dio/dio.dart';
// import 'package:property_system/client/models/complaient/create_office_complainet_model.dart';
// import 'package:property_system/client/services/token_service.dart';

// class ComplaintService {
//   final Dio _dio = Dio();

//   Future<Response> createComplaint(CreateOfficeComplainetModel complaint) async {
//     try {
//       final token = await AuthService.getAccessToken();
//       print('TOKEN = $token');

//       // اطبع البودي الحقيقي قبل ما يتبعت
//       final body = complaint.toJson();
//       print("🚀 Data before sending to server: ${jsonEncode(body)}");

//       final response = await _dio.post(
//         'http://localhost:3000/api/office-complaint',
//         data: body,
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token',
//             'Content-Type': 'application/json',
//           },
//         ),
//       );

//       print('📥 Response: ${response.data}');
//       return response;
//     } on DioError catch (e) {
//       throw _handleError(e);
//     }
//   }

//   String _handleError(DioError error) {
//     if (error.response != null) {
//       return 'خطأ من الخادم: ${error.response?.statusCode} - ${error.response?.data}';
//     } else {
//       return 'خطأ في الاتصال: ${error.message}';
//     }
//   }
// }
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:property_system/client/models/complaient/create_office_complainet_model.dart';
import 'package:property_system/client/services/token_service.dart';

class ComplaintService {
  final Dio _dio = Dio();

  // رفع صورة واحدة
  Future<String> uploadImage(File file) async {
    final token = await AuthService.getAccessToken();
    String fileName = file.path.split('/').last;

    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path, filename: fileName),
    });

    final response = await _dio.post(
      "http://localhost:3000/api/upload-image", // endpoint رفع الصورة
      data: formData,
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "multipart/form-data",
        },
      ),
    );

    return response.data['url']; // السيرفر يرجع URL الصورة
  }

  // إرسال الشكوى
  Future<Response> createComplaint(CreateOfficeComplainetModel complaint) async {
    try {
      final token = await AuthService.getAccessToken();
      final body = complaint.toJson();
      print("🚀 Data before sending to server: ${jsonEncode(body)}");

      final response = await _dio.post(
        'http://localhost:3000/api/office-complaint',
        data: body,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      print('📥 Response: ${response.data}');
      return response;
    } on DioError catch (e) {
      throw _handleError(e);  
      
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

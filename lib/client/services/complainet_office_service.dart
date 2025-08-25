// import 'package:dio/dio.dart';
// import 'package:property_system/client/models/complaient/create_office_complainet_model.dart';
// import 'package:property_system/client/services/token_service.dart';

// class ComplaintService {
//   final Dio _dio = Dio();

//   Future<Response> createComplaint(CreateOfficeComplainetModel complaint) async {
//     try {
//    final token = await AuthService.getAccessToken();
//       print('TOKEN = $token');


//       final response = await _dio.post(
//        'http://localhost:3000/api/office-complaint',
//         data: complaint.toJson(),
//         options: Options(
//           headers: {
//                        'Authorization': 'Bearer $token',

//             // أضف أي هيدرات أخرى مطلوبة مثل التوكن
//           },
//         ),
//       );
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
import 'package:dio/dio.dart';
import 'package:property_system/client/models/complaient/create_office_complainet_model.dart';
import 'package:property_system/client/services/token_service.dart';

class ComplaintService {
  final Dio _dio = Dio();

  Future<Response> createComplaint(CreateOfficeComplainetModel complaint) async {
    try {
      final token = await AuthService.getAccessToken();
      print('TOKEN = $token');

      final response = await _dio.post(
        'http://localhost:3000/api/office-complaint',
        data: complaint.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
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

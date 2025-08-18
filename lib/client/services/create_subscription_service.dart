// import 'package:dio/dio.dart';
// import 'package:property_system/client/models/create_subscription_model.dart';

// class SubscriptionService {
//   final Dio _dio = Dio();
//   // دالة تسجيل الاشتراك
//   Future<bool> registerSubscription(CreateSubscriptionModel payment) async {
//     final url = 'http://localhost:3000/api/office-subscription';

//     try {
//        print('1');

//       final response = await _dio.post(
//         url,
//         data: payment.toJson(),
//         options: Options(
//           headers: {'Content-Type': 'application/json'},
//         ),
//       );
//        print('2');

//       if (response.statusCode == 200) {
//         // التسجيل نجح
//      print('3');

//         return true;
//       } else {
//         // فشل التسجيل
//         print('Failed: ${response.data}');
//         return false;
//       }
//     } catch (e) {
//       print('Error: $e');
//       return false;
//     }
//   }
// }
// /*
// import 'package:dio/dio.dart';
// import 'package:property_system/client/models/create_subscription_model.dart';

// class SubscriptionService {
//   final Dio _dio = Dio();

//   Future<bool> registerSubscription(CreateSubscriptionModel payment) async {
//     try {
//       final response = await _dio.post(
//         'http://localhost:3000/api/office-subscription',
//         data: payment.toJson(),
//       );

//       print('API RESPONSE: ${response.data}');

//       if (response.statusCode == 200) {
//         return true;
//       } else {
//         return false;
//       }
//     } catch (e) {
//       print('Exception: $e');
//       return false;
//     }
//   }
// }

// */import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:property_system/client/models/create_subscription_model.dart';
import 'package:property_system/client/services/token_service.dart';

class SubscriptionService {
  final Dio _dio = Dio();

  Future<bool> registerSubscription(CreateSubscriptionModel payment) async {
    try {
      // جلب التوكن من AuthService
      final String? accessToken = await AuthService.getAccessToken();

      final response = await _dio.post(
        'http://localhost:3000/api/office-subscription',
        data: payment.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Exception: $e');
      return false;
    }
  }
}

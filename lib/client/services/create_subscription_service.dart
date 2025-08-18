import 'package:dio/dio.dart';
import 'package:property_system/client/models/create_subscription_model.dart';


class SubscriptionService {
  final Dio _dio = Dio();

  // دالة تسجيل الاشتراك
  Future<bool> registerSubscription(CreateSubscriptionModel payment) async {
    final url = 'https://api.example.com/subscription/register';

    try {
      final response = await _dio.post(
        url,
        data: payment.toJson(),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        // التسجيل نجح
        return true;
      } else {
        // فشل التسجيل
        print('Failed: ${response.data}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}

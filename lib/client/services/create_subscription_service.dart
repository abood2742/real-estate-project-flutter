
import 'package:dio/dio.dart';
import 'package:property_system/client/models/create_subscription_model.dart';
import 'package:property_system/client/services/token_service.dart';

class SubscriptionService {
  final Dio _dio = Dio();

  Future<bool> registerSubscription(CreateSubscriptionModel payment) async {
    try {
      // جلب التوكن الحقيقي
      final accessToken = await AuthService.getAccessToken();
      print('TOKEN = $accessToken');

      // طباعة الـ body للتأكد فقط
      print(payment.toJson());

      final response = await _dio.post(
        'http://localhost:3000/api/office-subscription',
        data: {
          'subscriptionId': payment.subscriptionId,
          'cardNumber': payment.cardNumber,
          'expiryMonth': payment.expiryMonth,
          'expiryYear': payment.expiryYear,
          'cvv': payment.cvv,
          // نحول "1 شهر" إلى رقم فقط
          'duration': int.parse(payment.type.split(' ')[0]),
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      print('STATUS = ${response.statusCode}');
      print('BODY   = ${response.data}');

      return response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}

import 'package:dio/dio.dart';
import 'package:property_system/client/models/all_subscription_model.dart';
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
      print('success');
      print(
        payment.subscriptionId,
      );
      print(
        payment.expiryMonth,
      );

      print(
        payment.expiryYear,
      );

      print(
        payment.cvv,
      );
       print(
        payment.type,
      );

     

      print('success');
    
      print('SENT TOKEN = Bearer $accessToken');


      final response = await _dio.post(
        'http://localhost:3000/api/office-subscription',
        data: {
          'subscriptionId': payment.subscriptionId,
          'cardNumber': payment.cardNumber,
          'expiryMonth': payment.expiryMonth,
          'expiryYear': payment.expiryYear,
          'cvv': payment.cvv,
          'type':payment.type,
          // نحول "1 شهر" إلى رقم فقط
          // 'duration': payment.duration,
          // 'duration': int.parse(payment.duration.split(' ')[0]),


          // 'amount': payment.amount, //
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );
      print('STATUS CODE = ${response.statusCode}');
      if (response.statusCode == 201) {
        print('ok');
      } else {
        print('no');
      }

      print('success1');

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

   Future<List<AllSubscriptionModel>> getAllSubscriptions() async {
    try {
      Response response = await _dio.get(
        'http://localhost:3000/api/subscription',
      );
      print('API RESPONSE: ${response.data}');

      if (response.statusCode == 200) {
        List<AllSubscriptionModel> subscriptions = [];
        List<dynamic> list = response.data;

        for (var item in list) {
          subscriptions.add(AllSubscriptionModel.fromJson(item));
        }

        return subscriptions;
      } else {
        return [];
// في حال ستاتس كود غير 200 ارجع قائمة فاضية
      }
    } catch (e) {
      print('Exception: $e');
      return []; // أيضا في حال الخطأ ارجع قائمة فاضية
    }
  }
}

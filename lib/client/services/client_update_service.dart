import 'package:dio/dio.dart';
import 'package:property_system/client/models/client_info_model.dart';

class UpdateProductService {
  final Dio _dio = Dio();

  Future<ClientInfoModel> updateClientInfo({
    required String firstName,
    required String lastName,
    required String receiverIdentifier,
    required String profilePhoto,
  }) async {
    try {
      final response = await _dio.put(
        'http://localhost:3000/api/user/update-profile',
        data: {
          'firstName': firstName,
          'lastName': lastName,
          'receiverIdentifier': receiverIdentifier,
          'profilePhoto': profilePhoto,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            // إذا كنت تستخدم توكن JWT، أضف السطر التالي:
            // 'Authorization': 'Bearer YOUR_TOKEN_HERE',
          },
        ),
      );

      return ClientInfoModel.fromJson(response.data);
    } catch (e) {
      // يمكنك تخصيص نوع الخطأ أو تسجيله أو إظهاره للمستخدم
      throw Exception('فشل في تحديث معلومات العميل: $e');
    }
  }
}

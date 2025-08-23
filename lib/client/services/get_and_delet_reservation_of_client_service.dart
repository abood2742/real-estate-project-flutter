import 'package:dio/dio.dart';
import 'package:property_system/client/models/property_model.dart';
import 'package:property_system/client/services/token_service.dart';

class GetAndDeletReservationOfClientService {
  final Dio dio = Dio();
  final String baseUrl = "https://postman-rest-api-learner.glitch.me";

  /// جلب عقارات العميل المحجوزة (نرجع قائمة PropertyModel مباشرة)
  Future<List<PropertyModel>?> getClientReservations(String clientId) async {
    try {
      var token = await AuthService.getAccessToken();

      final response = await dio.get(
        "$baseUrl/info?id=$clientId",
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      if (response.statusCode == 200) {
        final raw = response.data;
        final List<dynamic> items =
            raw is List ? raw : (raw["data"] as List<dynamic>);

        // نرجع العقار فقط من كل حجز
        return items
            .map((json) => PropertyModel.fromJson(json["property"]))
            .toList();
      }
      return null;
    } catch (e) {
      print("❌ Error fetching client reservations: $e");
      return null;
    }
  }

  /// حذف حجز للعميل
  Future<bool> deleteClientReservation(String reservationId) async {
    try {
      var token = await AuthService.getAccessToken();

      final response = await dio.delete(
        "$baseUrl/info?id=$reservationId",
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print("❌ Error deleting reservation: $e");
      return false;
    }
  }
}

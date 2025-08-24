import 'package:dio/dio.dart';
import 'package:property_system/client/reservation%20_for_client/get_reservation_client_model.dart';

class GetOneAndDeletClientReservationService {
  final Dio _dio = Dio();

  // Endpoint أمثلة حسب ما زوّدتني:
  // GET  : https://postman-rest-api-learner.glitch.me/info?id={id}
  // DELETE: https://postman-rest-api-learner.glitch.me/info/{id}

  Future<GetReservationClientModel?> getOneReservation(String reservationId) async {
    try {
      final resp = await _dio.get(
        'https://postman-rest-api-learner.glitch.me/info',
        queryParameters: {'id': reservationId},
      );

      if (resp.statusCode == 200 && resp.data != null) {
        final data = resp.data;

        // قد يرجع Map أو {data: Map} أو {data: List} أو List مباشرة
        if (data is Map<String, dynamic>) {
          final payload = data['data'] ?? data;
          if (payload is Map<String, dynamic>) {
            return GetReservationClientModel.fromJson(payload);
          } else if (payload is List && payload.isNotEmpty) {
            final first = payload.first as Map<String, dynamic>;
            return GetReservationClientModel.fromJson(first);
          }
        } else if (data is List && data.isNotEmpty) {
          return GetReservationClientModel.fromJson(
              data.first as Map<String, dynamic>);
        }
      }

      return null;
    } catch (e) {
      // للتشخيص فقط
      // ignore: avoid_print
      print('getOneReservation error: $e');
      return null;
    }
  }

  Future<bool> deleteReservation(String reservationId) async {
    try {
      final resp = await _dio.delete(
        'https://postman-rest-api-learner.glitch.me/info/$reservationId',
      );
      return resp.statusCode == 200 || resp.statusCode == 204;
    } catch (e) {
      // ignore: avoid_print
      print('deleteReservation error: $e');
      return false;
    }
  }
}

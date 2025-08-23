// import 'package:dio/dio.dart';
// import 'package:property_system/client/models/create_reservation_model.dart';
// import 'package:property_system/client/services/token_service.dart';
// import 'package:property_system/office/models/get_reservation_model.dart';

// class ReservationService {
//   final Dio dio = Dio();

//   Future<bool> createReservation(CreateReservationModel request) async {
//     try {
//       var token = await AuthService.getAccessToken();

//       final response = await dio.post(
//         "http://localhost:3000/api/reservation/c3cbc465-ca6a-434c-a69d-9c1b2355bd9b",
//         options: Options(headers: {"Authorization": "Bearer $token"}),
//         data: request.toJson(),
//       );

//       // بعض الـ APIs ترجع 201، وبعضها 200
//       return response.statusCode == 201 || response.statusCode == 200;
//     } catch (e) {
//       print("Error creating reservation: $e");
//       return false;
//     }
//   }

//   Future<List<GetReservationModel>?> getReservations() async {
//     try {
//       var token = await AuthService.getAccessToken();

//       final response = await dio.get(
//         "http://localhost:3000/api/info?id=1",
//         options: Options(headers: {"Authorization": "Bearer $token"}),
//       );

//       if (response.statusCode == 200) {
//         // أحيانًا الـ API يرجع List مباشرة، وأحيانًا داخل data
//         final raw = response.data;
//         final List<dynamic> items =
//             raw is List ? raw : (raw["data"] as List<dynamic>);

//         return items
//             .map((json) => GetReservationModel.fromJson(json))
//             .toList();
//       }
//       return null;
//     } catch (e) {
//       print("Error getting reservations: $e");
//       return null;
//     }
//   }
// }
import 'package:dio/dio.dart';
import 'package:property_system/client/models/create_reservation_model.dart';
import 'package:property_system/client/services/token_service.dart';
import 'package:property_system/office/models/get_reservation_model.dart';

class ReservationService {
  final Dio dio = Dio();

  // CREATE
  Future<bool> createReservation(CreateReservationModel request,
      {required String propertyId}) async {
    try {
      var token = await AuthService.getAccessToken();
      final body = request.toJson();
      final response = await dio.post(
          "http://localhost:3000/api/reservation/$propertyId",
          options: Options(headers: {"Authorization": "Bearer $token"}),
          data: body);

      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print("Error creating reservation: $e");
      return false;
    }
  }

  // GET
  Future<List<GetReservationModel>?> getReservations() async {
    try {
      var token = await AuthService.getAccessToken();

      final response = await dio.get(
        "http://localhost:3000/api/info?id=1",
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      if (response.statusCode == 200) {
        final raw = response.data;
        final List<dynamic> items =
            raw is List ? raw : (raw["data"] as List<dynamic>);

        return items.map((json) => GetReservationModel.fromJson(json)).toList();
      }
      return null;
    } catch (e) {
      print("Error getting reservations: $e");
      return null;
    }
  }

  // UPDATE (PUT)
  Future<bool> updateReservation(
      String reservationId, Map<String, dynamic> updatedData) async {
    try {
      var token = await AuthService.getAccessToken();

      final response = await dio.put(
        "http://localhost:3000/api/reservation/$reservationId",
        options: Options(headers: {"Authorization": "Bearer $token"}),
        data: updatedData, // يمكن تحويل نموذج CreateReservationModel إلى Map
      );

      return response.statusCode == 200;
    } catch (e) {
      print("Error updating reservation: $e");
      return false;
    }
  }


  // DELETE
  Future<bool> deleteReservation(String reservationId) async {
    try {
      var token = await AuthService.getAccessToken();

      final response = await dio.delete(
        "http://localhost:3000/api/reservation/$reservationId",
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print("Error deleting reservation: $e");
      return false;
    }
  }
}

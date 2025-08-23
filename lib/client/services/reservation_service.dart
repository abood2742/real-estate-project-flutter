// import 'package:dio/dio.dart';
// import 'package:property_system/client/models/create_reservation_model.dart';
// import 'package:property_system/client/services/token_service.dart';

// class CreateReservationService {
//   final Dio dio = Dio();

//   Future<bool> createReservation(CreateReservationModel request) async {
//     try {
//       var token = await AuthService.getAccessToken();

//       Response response = await dio.post(
//         "http://localhost:3000/api/reservations",
//         options: Options(headers: {"Authorization": "Bearer $token"}),
//         data: request.toJson(),
//       );

//       return response.statusCode == 201;
//     } catch (e) {
//       print("Error creating reservation: $e");
//       return false;
//     }
//   }

//   Future<List<CreateReservationModel>?> getReservations() async {
//     try {
//       var token = await AuthService.getAccessToken();

//       Response response = await dio.get(
//         "http://localhost:3000/api/reservations",
//         options: Options(headers: {"Authorization": "Bearer $token"}),
//       );

//       if (response.statusCode == 200) {
//         List<dynamic> data = response.data;
//         return data.map((json) => CreateReservationModel.fromJson(json)).toList();
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

  Future<bool> createReservation(CreateReservationModel request) async {
    try {
      var token = await AuthService.getAccessToken();

      final response = await dio.post(
        "http://localhost:3000/api/reservation/c3cbc465-ca6a-434c-a69d-9c1b2355bd9b",
        options: Options(headers: {"Authorization": "Bearer $token"}),
        data: request.toJson(),
      );

      // بعض الـ APIs ترجع 201، وبعضها 200
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print("Error creating reservation: $e");
      return false;
    }
  }

  Future<List<GetReservationModel>?> getReservations() async {
    try {
      var token = await AuthService.getAccessToken();

      final response = await dio.get(
        "http://localhost:3000/api/info?id=1",
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      if (response.statusCode == 200) {
        // أحيانًا الـ API يرجع List مباشرة، وأحيانًا داخل data
        final raw = response.data;
        final List<dynamic> items =
            raw is List ? raw : (raw["data"] as List<dynamic>);

        return items
            .map((json) => GetReservationModel.fromJson(json))
            .toList();
      }
      return null;
    } catch (e) {
      print("Error getting reservations: $e");
      return null;
    }
  }
}

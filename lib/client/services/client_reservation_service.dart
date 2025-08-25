import 'package:dio/dio.dart';
import 'package:property_system/client/models/create_reservation_model.dart';
import 'package:property_system/client/models/property_model.dart';
import 'package:property_system/client/services/token_service.dart';

class ClientReservationService {
  Dio dio = Dio();

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

  Future<List<PropertyModel>?> getClientReservedProperties() async {
    var token = await AuthService.getAccessToken();

    Response response = await dio.get(
        'http://localhost:3000/api/property/reserved?page=1&limit=10',
        options: Options(headers: {"Authorization": "Bearer $token"}));

    if (response.statusCode == 200) {
      PropertyPageModel pageModel = PropertyPageModel.fromJson(response.data);
      List<PropertyModel> reservedClientProperty = pageModel.data;

      return reservedClientProperty;
    } else {
      return null;
    }
  }

  Future  cancelReservedPropertyFromClient({required String reservationId}) async {
    Dio dio = Dio();
    var token = await AuthService.getAccessToken();
    Response response = await dio.delete(
        'http://localhost:3000/api/reservation/$reservationId',
        options: Options(headers: {"Authorization": "Bearer $token"}));
    if (response.statusCode == 200 || response.statusCode == 202) {
      print('success');
    }
  }
}

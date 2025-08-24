import 'package:dio/dio.dart';
import 'package:property_system/client/models/Reservation_model.dart';
import 'package:property_system/client/services/token_service.dart';

class ReservedPropertiesService {
  Future<List<ReservationModel>?> getReservedPropertiesForOffice() async {
    Dio dio = new Dio();

    var token = await AuthService.getAccessToken();

    try {
      Response response = await dio.get(
          'http://localhost:3000/api/office/get-reserved/properties',
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));

      if (response.statusCode == 200) {
        List<dynamic> list = response.data;

        List<ReservationModel> reservedProperties = [];

        var property;
        for (int i = 0; i < list.length; i++) {
          property = ReservationModel.fromJson(list[i]);
          reservedProperties.add(property);
        }

        return reservedProperties;
      }
    } catch (e) {
      if (e is DioException) {
        print("DioException: $e");
        return null;
      }

      print("Exception: $e");
      return null;
    }
    return null;
  }
}

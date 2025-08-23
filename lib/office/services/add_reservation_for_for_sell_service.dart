import 'package:dio/dio.dart';
import 'package:property_system/client/models/property_model.dart';
import 'package:property_system/client/services/token_service.dart';

class AddReservationForForSellService {
  Future<bool?> addPropertyToReservation({required String propertyId}) async {
    Dio dio = Dio();

    try {
      var token = await AuthService.getAccessToken();
      final body = {'propertyId': propertyId};

      Response response = await dio.post(
          'http://localhost:3000/api/reservation-sell',
          options: Options(headers: {'Authorization': 'Bearer $token'}),
          data: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      if (e is DioError) {
        print('Error response: ${e.response?.data}');
      }
      print('Exception: $e');
      return false;
    }
  }

  Future<List<PropertyModel>?> getReservedProperties() async {
    Dio dio = Dio();

    try {
      var token = await AuthService.getAccessToken();

      Response response = await dio.get(
          'http://localhost:3000/api/reservation-sell',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200) {
        List<dynamic> reservedProperties = response.data;

        List<PropertyModel> convertedReserved = [];

        for (var i = 0; i < reservedProperties.length; i++) {
          var property = PropertyModel.fromJson(
            reservedProperties[i]["property"],
          );
          convertedReserved.add(property);
        }

        return convertedReserved;
      } else {
        return null;
      }
    } catch (e) {
      if (e is DioError) {
        print('Error response: ${e.response?.data}');
      }
      print('Exception: $e');
      return null;
    }
  }

  Future<bool> removePropertyFromReservation({required String propertyId}) async {
    Dio dio = Dio();

    try {
      var token = await AuthService.getAccessToken();

      Response response = await dio.delete(
          'http://localhost:3000/api/reservation-sell/$propertyId',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      if (e is DioError) {
        print('Error response: ${e.response?.data}');
      }
      print('Exception: $e');
      return false;
    }
  }
}

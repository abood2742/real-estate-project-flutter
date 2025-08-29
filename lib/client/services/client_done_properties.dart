import 'package:dio/dio.dart';
import 'package:property_system/client/models/client_done_Properties.dart';
import 'package:property_system/client/services/token_service.dart';

class ClientDonePropertiesService {
  Future<List<ClientDoneProperties>?> getAllUserProperties() async {
    Dio dio = new Dio();

    var token = await AuthService.getAccessToken();

    try {
      Response response = await dio.get(
          'http://localhost:3000/api/user/properties',
          options: Options(headers: {"Authorization": "Bearer $token"}));

      if (response.statusCode == 200) {
        List<dynamic> list = response.data;

        List<ClientDoneProperties> properties = [];

        var property;

        for (int i = 0; i < list.length; i++) {
          property = ClientDoneProperties.fromJson(list[i]);
          properties.add(property);
        }

        return properties;
      }
    } catch (e) {
      if (e is DioError) {
        print('Error response: ${e.response?.data}');
      }
      print('Exception: $e');
      return null;
    }
    return null;
  }
}

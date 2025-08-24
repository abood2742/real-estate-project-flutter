import 'package:dio/dio.dart';
import 'package:property_system/client/models/property_model.dart';
import 'package:property_system/client/services/token_service.dart';

class GetClientReservationService {
  final Dio dio = Dio();

  Future<List<PropertyModel>?> getClientReservation() async {
    print('1');
    var token = await AuthService.getAccessToken();
    print(token);

    Response response = await dio
        .get('http://localhost:3000/api/property/reserved?page=1&limit=10',   options:
    Options(headers: {"Authorization": "Bearer $token"}));
    print('2');

 

    if (response.statusCode == 200) {
       PropertyPageModel pageModel = PropertyPageModel.fromJson(response.data);
        List<PropertyModel> reservedClientProperty = pageModel.data;
       print('3');
      
      return reservedClientProperty;
      
    } else {
      return null;
    }
  }
}

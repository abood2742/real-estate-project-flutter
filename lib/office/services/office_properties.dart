import 'package:dio/dio.dart';
import 'package:property_system/client/models/property_model.dart';
import 'package:property_system/client/services/token_service.dart';

class OfficeProperties {
  Dio dio = new Dio();

  Future<List<PropertyModel>?> getAcceptedPropertiesForOffice() async {
    var token = await AuthService.getAccessToken();

    try {
      Response response =
          await dio.get('http://localhost:3000/api/property/accepted',
              options: Options(headers: {
                'Authorization': 'Bearer $token',
              }));

      if (response.statusCode == 200) {
        PropertyPageModel propertyPageModel =
            PropertyPageModel.fromJson(response.data);

        List<PropertyModel> list = propertyPageModel.data;

        return list;
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

  Future<List<PropertyModel>?> getPendingPropertiesForOffice() async {
    var token = await AuthService.getAccessToken();

    try {
      Response response =
          await dio.get('http://localhost:3000/api/property/pending',
              options: Options(headers: {
                'Authorization': 'Bearer $token',
              }));

      if (response.statusCode == 200) {
        PropertyPageModel propertyPageModel =
            PropertyPageModel.fromJson(response.data);

        List<PropertyModel> list = propertyPageModel.data;

        return list;
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

  Future<List<PropertyModel>?> getDonePropertiesForOffice() async {
    var token = await AuthService.getAccessToken();

    try {
      Response response =
          await dio.get('http://localhost:3000/api/property/done',
              options: Options(headers: {
                'Authorization': 'Bearer $token',
              }));

      if (response.statusCode == 200) {
        PropertyPageModel propertyPageModel =
            PropertyPageModel.fromJson(response.data);

        List<PropertyModel> list = propertyPageModel.data;

        return list;
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

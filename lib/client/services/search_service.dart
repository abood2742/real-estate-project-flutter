import 'package:dio/dio.dart';
import 'package:property_system/client/models/office_card_model.dart';
import 'package:property_system/client/models/office_details_model.dart';
import 'package:property_system/client/models/property_model.dart';
import 'package:property_system/client/services/token_service.dart';

class SearchService {
  Future<List<OfficeCardModel>?> getAllOffices() async {
    Dio dio = Dio();

    try {
      Response response =
          await dio.get('http://localhost:3000/api/office?page=1&limit=10');

      if (response.statusCode == 200) {
        PageModel pageModel = PageModel.fromJson(response.data);
        List<OfficeCardModel> officeCardModels = pageModel.data;

        return officeCardModels;
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

  Future<OfficeDetailsModel?> getOneOffice({required String officeId}) async {
    Dio dio = Dio();

    try {
      Response response =
          await dio.get('http://localhost:3000/api/office/$officeId');

      var token = await AuthService.getAccessToken();

      if (response.statusCode == 200) {
        OfficeDetailsModel officeDetailsModel;
        if (token == null) {
          officeDetailsModel =
              OfficeDetailsModel.fromJson(response.data, isFavorite: false);
        } else {
          Response isFavorite = await dio.get(
              'http://localhost:3000/api/favorite-office/$officeId',
              options: Options(headers: {'Authorization': 'Bearer $token'}));
          if (isFavorite.data == 'true') {
            officeDetailsModel =
                OfficeDetailsModel.fromJson(response.data, isFavorite: true);
          } else {
            officeDetailsModel =
                OfficeDetailsModel.fromJson(response.data, isFavorite: false);
          }
        }
        return officeDetailsModel;
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

  Future<List<PropertyModel>?> getAllProperties() async {
    Dio dio = Dio();

    try {
      Response response =
          await dio.get('http://localhost:3000/api/property?page=1&limit=10');
      if (response.statusCode == 200) {
        PropertyPageModel pageModel = PropertyPageModel.fromJson(response.data);
              print(response.statusCode);

        List<PropertyModel> propertyModels = pageModel.data;
        print(propertyModels);
        return propertyModels;
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
}

import 'package:dio/dio.dart';
import 'package:property_system/client/models/office_details_model.dart';
import 'package:property_system/client/services/token_service.dart';

class FavoriteOfficeService {
  Future<bool?> addOfficeToFavorite({required String officeId}) async {
    Dio dio = new Dio();


    try {

      var token = await AuthService.getAccessToken();
      final body = {'officeId': officeId};

      Response response = await dio
          .post('http://localhost:3000/api/favorite-office',
          options: Options(headers: {'Authorization': 'Bearer $token'}),
          data: body);

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

  Future<List<OfficeDetailsModel>?> getFavoriteOffices() async {
    Dio dio = new Dio();

    try {
      var token = await AuthService.getAccessToken();

      Response response = await dio.get(
          'http://localhost:3000/api/favorite-office',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200) {
        List<dynamic> favoriteOffices = response.data;

        List<OfficeDetailsModel> convertedFavoriteOffices = [];

        if (favoriteOffices == []) {
          return null;
        }

        var office;

        for (var i = 0; i < favoriteOffices.length; i++) {
          office = OfficeDetailsModel.fromJson(favoriteOffices[i],isFavorite: false);
          convertedFavoriteOffices.add(office);
        }

        return convertedFavoriteOffices;
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

  Future<bool> removeOfficeFromFavorite({required String officeId}) async {
    Dio dio = new Dio();

    try {
      var token = await AuthService.getAccessToken();

      Response response = await dio.delete(
          'http://localhost:3000/api/favorite-office/$officeId',
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

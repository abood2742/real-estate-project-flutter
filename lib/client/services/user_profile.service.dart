import 'package:dio/dio.dart';
import 'package:property_system/client/models/profile.model.dart';
import 'package:property_system/client/services/token_service.dart';

class ProfileService {
  Future<ProfileModel?> getProfile() async {
    Dio dio = Dio();

    var token = await AuthService.getAccessToken();

    print(token);
    try {
      Response response =
          await dio.get('http://localhost:3000/api/user/get-current',
              options: Options(headers: {
                'Authorization': 'Bearer $token',
            //    'Content-Type': 'multipart/form-data', // مهم جدًا
              }));

      if (response.statusCode == 200) {
        print('${response.data} + rf');
        ProfileModel profileModel = ProfileModel.fromJson(response.data);
        return profileModel;
      } else {
        print('${response.data} + rf');

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

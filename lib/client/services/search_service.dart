import 'package:dio/dio.dart';
import 'package:property_system/client/models/office_card_model.dart';
import 'package:property_system/client/models/office_details_model.dart';

class SearchService {
  Future<List<OfficeCardModel>?> getAllOffices() async {
    Dio dio = Dio();

    try {
      Response response =
          await dio.get('http://localhost:3000/api/office?page=1&limit=10');

      if (response.statusCode == 200) {
        PageModel pageModel = PageModel.fromJson(response.data);
        List<OfficeCardModel> officeCardModels = pageModel.data;
        officeCardModels[0].ratingsCount = 3;
        officeCardModels[1].ratingsCount = 4.5;

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

      if (response.statusCode == 200) {
        OfficeDetailsModel officeDetailsModel =
            OfficeDetailsModel.fromJson(response.data);

        officeDetailsModel.ratingsCount = 3.5;
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
}

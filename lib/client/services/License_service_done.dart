import 'package:dio/dio.dart';
import 'package:property_system/client/models/LicenseType_model.dart';

class LicenseService {
  Future<List<LicensetypeModel>?> getAllLicenseTypes() async{
    Dio dio = new Dio();

    try{

      Response response = await dio.get('http://localhost:3000/api/license-types');

      if(response.statusCode == 200){
        
        List<dynamic> list = response.data;

        List<LicensetypeModel> licenseTypeList = [];

        var licenseType;

        for(int i = 0 ; i < list.length; i++){
          licenseType = LicensetypeModel.fromJson(list[i]);
          licenseTypeList.add(licenseType);
        }
        return licenseTypeList;
      }
    } catch(e){
      if (e is DioError) {
        print('Error response: ${e.response?.data}');
      }
      print('Exception: $e');
      return null;
    }
    return null;
  }
}

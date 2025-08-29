import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:property_system/client/models/complaient/get_case_1_complainet_model.dart';


class ComplaintGetOfiiceToClientService {
  final String baseUrl = "http://localhost:3000/api/office-complaint/user";

  Future<GetCase1ComplainetModel> fetchComplaintById(String id) async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return GetCase1ComplainetModel.fromJson(data);
    } else {
      throw Exception("فشل في جلب بيانات الشكوى");
    }
  }
}

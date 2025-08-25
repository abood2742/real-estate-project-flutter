import 'package:dio/dio.dart';
import 'package:property_system/client/models/blog_model.dart';
import 'package:property_system/client/services/token_service.dart';

class BlogService {
  Future<List<BlogModel>?> getAllBlogs() async {
    Dio dio = new Dio();

    try {
      Response response = await dio.get('http://localhost:3000/api/blog');

      if (response.statusCode == 200) {
        List<dynamic> list = response.data;

        List<BlogModel> blogs = [];

        var blog;

        for (int i = 0; i < list.length; i++) {
          blog = BlogModel.fromJson(list[i]);
          blogs.add(blog);
        }

        return blogs;
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

  Future<bool> createBlog({
    required String title,
    required String content,
    required List<MultipartFile> blogPhoto,
  }) async {
    Dio dio = Dio();
    var token = await AuthService.getAccessToken();

    try {
      FormData formData = FormData.fromMap({
        'title': title,
        'content': content,
        'blog_photo': blogPhoto, // الصور كمصفوفة MultipartFile
      });

      Response response = await dio.post(
        'http://localhost:3000/api/blog',
        data: formData,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'multipart/form-data',
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        // تحويل النتيجة إلى List<BlogModel> إذا كانت API ترجع بيانات متعددة
        return true;
      }
    } catch (e) {
      if (e is DioError) {
        print('Error response: ${e.response?.data}');
      }
      print('Exception: $e');
      return false;
    }
    return false;
  }
}

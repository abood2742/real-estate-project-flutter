import 'package:dio/dio.dart';
import 'package:property_system/client/models/comment_and_rating_model.dart';
import 'package:property_system/client/services/token_service.dart';

class CommentAndRatingService {
  Future<List<CommentAndRatingModel>?> getCommentsOnOffice(
      {required String officeId}) async {
    Dio dio = Dio();

    try {
      Response response = await dio
          .get('http://localhost:3000/api/office-comment/office/$officeId');

      if (response.statusCode == 200) {
        List<dynamic> commentAndRatingModelList = response.data;

        List<CommentAndRatingModel> convertedCommentAndRatingModelList = [];

        var review;

        for (var i = 0; i < commentAndRatingModelList.length; i++) {
          review = CommentAndRatingModel.fromJson(commentAndRatingModelList[i]);
          convertedCommentAndRatingModelList.add(review);
        }

        return convertedCommentAndRatingModelList;
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

  Future<Rating?> rateOffice(
      {required String officeId, required int rating}) async {
    Dio dio = Dio();

    final body = {
      "rating": rating,
    };

    var token = await AuthService.getAccessToken();

    try {

      Response response =
          await dio.post('http://localhost:3000/api/office/$officeId/rate',
              options: Options(
                headers: {'Authorization': 'Bearer $token'},
              ),
              data: body);

      if (response.statusCode == 201) {
        Rating rating = Rating.fromJson(response.data);

        return rating;
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

  Future<bool?> addCommentToOffice(
      {required String officeId,
      required String comment,
      required String ratingId}) async {
    Dio dio = Dio();

    final body = {
      'officeRatingId': ratingId,
      'officeId': officeId,
      'content': comment,
    };

    var token = await AuthService.getAccessToken();

    try {
      Response response =
          await dio.post('http://localhost:3000/api/office-comment',
              options: Options(
                headers: {'Authorization': 'Bearer $token'},
              ),
              data: body);

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
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

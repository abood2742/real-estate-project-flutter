import 'package:dio/dio.dart';
import 'package:property_system/client/models/comment_and_rating_model.dart';
import 'package:property_system/client/services/token_service.dart';

class CommentAndRatingService {
  Future<bool?> rateOffice(
      // done
      {required String officeId,
      required int rating}) async {
    Dio dio = Dio();

    final body = {
      "officeId": officeId,
      "numberOfStars": rating,
    };

    var token = await AuthService.getAccessToken();

    try {
      Response response =
          await dio.post('http://localhost:3000/api/office/rate',
              options: Options(
                headers: {'Authorization': 'Bearer $token'},
              ),
              data: body);

      if (response.statusCode == 201) {
        //Rating rating = Rating.fromJson(response.data);

        return true;
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

  Future<bool?> addCommentToOffice( //done
      {
    required String officeId,
    required String comment,
    //required String ratingId
  }) async {
    Dio dio = Dio();

    final body = {
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

  Future<List<CommentModel>?> getCommentsOnOffice(
      {required String officeId}) async {
    Dio dio = Dio();

    try {
      Response response = await dio
          .get('http://localhost:3000/api/office-comment/office/$officeId');

      if (response.statusCode == 200) {
        List<dynamic> commentAndRatingModelList = response.data['data'];
        List<CommentModel> convertedCommentAndRatingModelList = [];

        var review;
        for (var i = 0; i < commentAndRatingModelList.length; i++) {
          review = CommentModel.fromJson(commentAndRatingModelList[i]);
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

  Future<bool?> addCommentToProperty( //done
      {
    required String propertyId,
    required String comment,
    //required String ratingId
  }) async {
    Dio dio = Dio();

    final body = {
      'propertyId': propertyId,
      'content': comment,
    };

    var token = await AuthService.getAccessToken();

    try {
      Response response =
          await dio.post('http://localhost:3000/api/property-comment',
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

  Future<List<CommentModel>?> getCommentsOnProperty(
      {required String propertyId}) async {
    Dio dio = Dio();

    try {
      Response response = await dio.get(
          'http://localhost:3000/api/property-comment/property/$propertyId');

      if (response.statusCode == 200) {
        List<dynamic> commentAndRatingModelList = response.data;
        List<CommentModel> convertedCommentAndRatingModelList = [];
        var review;
        for (var i = 0; i < commentAndRatingModelList.length; i++) {
          review = CommentModel.fromJson(commentAndRatingModelList[i]);
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
}

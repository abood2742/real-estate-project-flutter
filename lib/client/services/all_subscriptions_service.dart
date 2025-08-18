// // import 'package:dio/dio.dart';
// // import 'package:property_system/client/models/all_subscription_model.dart';
// // import 'package:property_system/client/models/property_type_model.dart';

// // class AllSubscriptionsService {
// //   final Dio _dio = Dio();

// //   Future<List<AllSubscriptionModel>?> getPropertyTypes() async {
// //     try {
// //       Response response = await _dio.get(
// //         'http://localhost:3000/api/subscription',
// //       );

// //       if (response.statusCode == 200) {
// //         List<PropertyTypeModel> propertyTypeList = [];
// //         List<dynamic> list = response.data;

// //         var propertyType;
// //         for (var i = 0; i < list.length; i++) {
// //           propertyType = PropertyTypeModel.fromJson(list[i]);
// //           propertyTypeList.add(propertyType);
// //         }

// //         return propertyTypeList;
// //       } else {
// //         return null;
// //       }
// //     } catch (e) {
// //       if (e is DioError) {
// //         print('Error response: ${e.response?.data}');
// //       }
// //       print('Exception: $e');
// //       return null;
// //     }
// //   }
// // }
// import 'package:dio/dio.dart';
// import 'package:property_system/client/models/all_subscription_model.dart';

// class AllSubscriptionsService {
//   final Dio _dio = Dio();

//   Future<List<AllSubscriptionModel>?> getAllSubscriptions() async {
//     try {
//     Response response = await _dio.get(
//   'http://localhost:3000/api/subscription',
// );
// print('API RESPONSE: ${response.data}');


//       if (response.statusCode == 200) {
//         List<AllSubscriptionModel> subscriptions = [];
//         List<dynamic> list = response.data;

//         for (var item in list) {
//           subscriptions.add(AllSubscriptionModel.fromJson(item));
//         }

//         return subscriptions;
//       } else {
//         return null;
//       }
//     } catch (e) {
//       print('Exception: $e');
//       return null;
//     }
//   }
// }
import 'package:dio/dio.dart';
import 'package:property_system/client/models/all_subscription_model.dart';

class AllSubscriptionsService {
  final Dio _dio = Dio();

  Future<List<AllSubscriptionModel>> getAllSubscriptions() async {
    try {
      Response response = await _dio.get(
        'http://localhost:3000/api/subscription',
      );
      print('API RESPONSE: ${response.data}');

      if (response.statusCode == 200) {
        List<AllSubscriptionModel> subscriptions = [];
        List<dynamic> list = response.data;

        for (var item in list) {
          subscriptions.add(AllSubscriptionModel.fromJson(item));
        }

        return subscriptions;
      } else {
       return [
  
];
// في حال ستاتس كود غير 200 ارجع قائمة فاضية
      }
    } catch (e) {
      print('Exception: $e');
      return []; // أيضا في حال الخطأ ارجع قائمة فاضية
    }
  }
}

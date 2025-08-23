
// import 'package:property_system/client/models/property_model.dart';

// class ReservationModel {
//   final String id;
//   final PropertyModel property;
//   final String status;
//   final DateTime createdAt;

//   ReservationModel({
//     required this.id,
//     required this.property,
//     required this.status,
//     required this.createdAt,
//   });

//   factory ReservationModel.fromJson(Map<String, dynamic> json) {
//     return ReservationModel(
//       id: json["id"],
//       property: PropertyModel.fromJson(json["property"]),
//       status: json["status"],
//       createdAt: DateTime.parse(json["createdAt"]),
//     );
//   }
// }
import 'package:property_system/client/models/property_model.dart';

class GetReservationModel {
  final String id;
  final PropertyModel property;
  final String status;
  final DateTime createdAt;

  GetReservationModel({
    required this.id,
    required this.property,
    required this.status,
    required this.createdAt,
  });

  factory GetReservationModel.fromJson(Map<String, dynamic> json) {
    return GetReservationModel(
      id: json["id"]?.toString() ?? "",
      property: PropertyModel.fromJson(json["property"]),
      status: json["status"]?.toString() ?? "",
      createdAt: DateTime.parse(json["createdAt"]),
    );
  }
}

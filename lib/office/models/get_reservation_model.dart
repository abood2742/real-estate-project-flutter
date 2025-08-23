
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

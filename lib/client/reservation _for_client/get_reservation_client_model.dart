import 'package:property_system/client/models/property_model.dart';


class GetReservationClientModel {
  final String reservationId; // id الحجز (مختلف عن id العقار)
  final PropertyModel property; // تفاصيل العقار
  final DateTime createdAt;

  GetReservationClientModel({
    required this.reservationId,
    required this.property,
    required this.createdAt,
  });

  factory GetReservationClientModel.fromJson(Map<String, dynamic> json) {
    return GetReservationClientModel(
      reservationId: json['id'],
      property: PropertyModel.fromJson(json['property']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

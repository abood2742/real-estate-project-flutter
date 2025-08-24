import 'package:property_system/client/models/profile.model.dart';
import 'package:property_system/client/models/property_model.dart';

class ReservationModel {
  final PropertyModel propertyModel;
  final ProfileModel user;
  final String id;
  final String reservation_date;
  final String amount_paid;
  final bool reservation_status;
  final String expires_at;
  final bool is_expired;
  final String created_at;

  ReservationModel({
    required this.propertyModel,
    required this.user,
    required this.id,
    required this.reservation_date,
    required this.amount_paid,
    required this.reservation_status,
    required this.expires_at,
    required this.is_expired,
    required this.created_at,
  });

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
        propertyModel: PropertyModel.fromJson(json["property"]),
        user: ProfileModel.fromJson(json['reservation']["user"]),
        id: json['reservation']["id"],
        reservation_date: json['reservation']["reservation_date"],
        amount_paid: json['reservation']["amount_paid"],
        reservation_status: json['reservation']["reservation_status"],
        expires_at: json['reservation']["expires_at"],
        is_expired: json['reservation']["is_expired"],
        created_at: json['reservation']["created_at"]);
  }
}

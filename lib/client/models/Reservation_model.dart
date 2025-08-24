import 'package:property_system/client/models/profile.model.dart';

class ReservationModel {
  ProfileModel? user;
  final String id;
  final String reservation_date;
  final String amount_paid;
  final bool reservation_status;
  final String expires_at;
  final bool is_expired;
  final String created_at;

  ReservationModel({
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
        user:json["user"] != null ? ProfileModel.fromJson(json["user"]) : null,
        id: json["id"],
        reservation_date: json["reservation_date"],
        amount_paid: json["amount_paid"],
        reservation_status: json["reservation_status"],
        expires_at: json["expires_at"],
        is_expired: json["is_expired"],
        created_at: json["created_at"]);
  }
}

// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:property_system/client/models/photo_model.dart';

// OfficeDetailsModel welcomeFromJson(String str) =>
//     OfficeDetailsModel.fromJson(json.decode(str));

String welcomeToJson(OfficeDetailsModel data) => json.encode(data.toJson());

class OfficeDetailsModel {
  String id;
  String name;
  String officePhone;
  String officeEmail;
  Photo officePhoto;
  Photo licensePhoto;
  String licenseNumber;
  String personalIdentityNumber;
  double ratings;
  bool isFavorite;
  List<dynamic> blogs;

  OfficeDetailsModel({
    required this.id,
    required this.name,
    required this.officePhone,
    required this.officeEmail,
    required this.officePhoto,
    required this.licensePhoto,
    required this.licenseNumber,
    required this.personalIdentityNumber,
    required this.ratings,
    required this.isFavorite,
    required this.blogs,
  });

  factory OfficeDetailsModel.fromJson(Map<String, dynamic> json, {required bool isFavorite}) =>
      OfficeDetailsModel(
        id: json["id"],
        name: json["name"],
        officePhone: json["office_phone"],
        officeEmail: json["office_email"],
        officePhoto: Photo.fromJson(json["office_photo"]),
        licensePhoto: Photo.fromJson(json["license_photo"]),
        licenseNumber: json["license_Number"],
        personalIdentityNumber: json["personal_identity_number"],
        isFavorite: isFavorite,
        ratings: json["ratings"],
        blogs: List<dynamic>.from(json["blogs"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "office_phone": officePhone,
        "office_email": officeEmail,
        "office_photo": officePhoto.toJson(),
        "license_photo": licensePhoto.toJson(),
        "license_Number": licenseNumber,
        "personal_identity_number": personalIdentityNumber,
        "ratings": ratings,
        "isFavorite": isFavorite,
        "blogs": List<dynamic>.from(blogs.map((x) => x)),
      };

  @override
  String toString() {
    return "favoritOffice : (id: $id \nname: $name \noffice_phone: $officePhone \noffice_email: $officeEmail \noffice_photo: $officePhoto \nlicense_photo: $licensePhoto \nlicense_Number: $licenseNumber \npersonal_identity_number: $personalIdentityNumber \nratings: $ratings \nisFavorite: $isFavorite \nblogs: $blogs)";
  }
}


// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'package:property_system/client/models/photo_model.dart';

// OfficeDetailsModel welcomeFromJson(String str) =>
//     OfficeDetailsModel.fromJson(json.decode(str));

class OfficeDetailsModel {
  String id;
  String name;
  String officePhone;
  String officeEmail;
  Photo? officePhoto;
  Photo? licensePhoto;
  String licenseNumber;
  String personalIdentityNumber;
  double? ratings;
  bool isFavorite;
  List<dynamic>? blogs;

  OfficeDetailsModel({
    required this.id,
    required this.name,
    required this.officePhone,
    required this.officeEmail,
    this.officePhoto,
    this.licensePhoto,
    required this.licenseNumber,
    required this.personalIdentityNumber,
    this.ratings,
    required this.isFavorite,
    this.blogs,
  });

  factory OfficeDetailsModel.fromJson(Map<String, dynamic> json,
      {required bool isFavorite}) {
    return OfficeDetailsModel(
      id: json["id"],
      name: json["name"],
      officePhone: json["office_phone"],
      officeEmail: json["office_email"],
      officePhoto: json["office_photo"] != null
          ? Photo.fromJson(json["office_photo"])
          : null,
      licensePhoto: json["license_photo"] != null
          ? Photo.fromJson(json["license_photo"])
          : null,
      licenseNumber: json["license_number"],
      personalIdentityNumber: json["personal_identity_number"],
      isFavorite: isFavorite,
      ratings: json["ratings"] != null ? json["ratings"] : null,
      blogs: json["blogs"] != null
          ? List<dynamic>.from(json["blogs"].map((x) => x))
          : null,
    );
  }

  @override
  String toString() {
    return "favoritOffice : (id: $id \nname: $name \noffice_phone: $officePhone \noffice_email: $officeEmail \noffice_photo: $officePhoto \nlicense_photo: $licensePhoto \nlicense_Number: $licenseNumber \npersonal_identity_number: $personalIdentityNumber \nratings: $ratings \nisFavorite: $isFavorite \nblogs: $blogs)";
  }
}

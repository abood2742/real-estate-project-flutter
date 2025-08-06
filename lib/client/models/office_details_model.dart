// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

OfficeDetailsModel welcomeFromJson(String str) =>
    OfficeDetailsModel.fromJson(json.decode(str));

String welcomeToJson(OfficeDetailsModel data) => json.encode(data.toJson());

class OfficeDetailsModel {
  String id;
  String name;
  String officePhone;
  String officeEmail;
  OfficePhoto officePhoto;
  LicensePhoto licensePhoto;
  String licenseNumber;
  String personalIdentityNumber;
  double ratingsCount;
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
    required this.ratingsCount,
    required this.blogs,
  });

  factory OfficeDetailsModel.fromJson(Map<String, dynamic> json) =>
      OfficeDetailsModel(
        id: json["id"],
        name: json["name"],
        officePhone: json["office_phone"],
        officeEmail: json["office_email"],
        officePhoto: OfficePhoto.fromJson(json["office_photo"]),
        licensePhoto: LicensePhoto.fromJson(json["license_photo"]),
        licenseNumber: json["license_Number"],
        personalIdentityNumber: json["personal_identity_number"],
        ratingsCount: json["ratingsCount"],
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
        "ratingsCount": ratingsCount,
        "blogs": List<dynamic>.from(blogs.map((x) => x)),
      };
}

class OfficePhoto {
  String id;
  String url;
  String publicId;

  OfficePhoto({
    required this.id,
    required this.url,
    required this.publicId,
  });

  factory OfficePhoto.fromJson(Map<String, dynamic> json) => OfficePhoto(
        id: json["id"],
        url: json["url"],
        publicId: json["public_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "public_id": publicId,
      };
}

class LicensePhoto {
  String id;
  String url;
  String publicId;

  LicensePhoto({
    required this.id,
    required this.url,
    required this.publicId,
  });

  factory LicensePhoto.fromJson(Map<String, dynamic> json) => LicensePhoto(
        id: json["id"],
        url: json["url"],
        publicId: json["public_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "public_id": publicId,
      };
}

// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:property_system/client/models/photo_model.dart';

ProfileModel welcomeFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String welcomeToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
    String id;
    String firstName;
    String lastName;
    Photo? profilePhoto;
    String nationalNumber;
    String phone;
    String email;
    String role;
    //dynamic banned;
    //dynamic userWarnings;

    ProfileModel({
        required this.id,
        required this.firstName,
        required this.lastName,
        this.profilePhoto,
        required this.nationalNumber,
        required this.phone,
        required this.email,
        required this.role,
        //required this.banned,
        //required this.userWarnings,
    });

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        profilePhoto: json["profile_photo"] != null
      ? Photo.fromJson(json["profile_photo"])
      : null,
        nationalNumber: json["national_number"],
        phone: json["phone"],
        email: json["email"],
        role: json["role"],
        //banned: json["banned"],
        //userWarnings: json["userWarnings"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "profile_photo": profilePhoto?.toJson(),
        "national_number": nationalNumber,
        "phone": phone,
        "email": email,
        "role": role,
        //"banned": banned,
        //"userWarnings": userWarnings,
    };
}



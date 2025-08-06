// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ProfileModel welcomeFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String welcomeToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
    String id;
    String firstName;
    String lastName;
    ProfilePhoto profilePhoto;
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
        required this.profilePhoto,
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
        profilePhoto: ProfilePhoto.fromJson(json["profile_photo"]),
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
        "profile_photo": profilePhoto.toJson(),
        "national_number": nationalNumber,
        "phone": phone,
        "email": email,
        "role": role,
        //"banned": banned,
        //"userWarnings": userWarnings,
    };
}

class ProfilePhoto {
    String id;
    String url;
    String publicId;

    ProfilePhoto({
        required this.id,
        required this.url,
        required this.publicId,
    });

    factory ProfilePhoto.fromJson(Map<String, dynamic> json) => ProfilePhoto(
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

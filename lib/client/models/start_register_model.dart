// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

// Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

// String welcomeToJson(Welcome data) => json.encode(data.toJson());

class StartRegisterModel {
  String accessToken;
  String refreshToken;

  StartRegisterModel({
    required this.accessToken,
    required this.refreshToken,
  });

  factory StartRegisterModel.fromJson(Map<String, dynamic> json) =>
      StartRegisterModel(
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
      };
}

class AuthModel {
  String accessToken;
  String refreshToken;
  String? role;

  AuthModel({
    required this.accessToken,
    required this.refreshToken,
    this.role
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
        role: json['role'] != null ? json["role"] : null
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
      };
}

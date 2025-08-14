class ClientInfoModel {
  final String firstName;
  final String lastName;
  final String receiverIdentifier;
  final ProfilePhoto? profilePhoto;
  ClientInfoModel({
    required this.firstName,
    required this.lastName,
    required this.receiverIdentifier,
    required this.profilePhoto,
  });

  factory ClientInfoModel.fromJson(jsonData) {
    return ClientInfoModel(
      firstName: jsonData['first_name'],
      lastName: jsonData['last_name'],
      receiverIdentifier: jsonData['national_number'],
      profilePhoto: jsonData["profile_photo"] != null
          ? ProfilePhoto.fromJson(jsonData["profile_photo"])
          : null,
    );
  }
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

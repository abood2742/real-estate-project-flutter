import 'package:property_system/client/models/photo_model.dart';

class ClientInfoModel {
  final String firstName;
  final String lastName;
  final String receiverIdentifier;
  final Photo? profilePhoto;
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
          ? Photo.fromJson(jsonData["profile_photo"])
          : null,
    );
  }
}

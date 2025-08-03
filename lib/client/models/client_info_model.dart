class ClientInfoModel {
  final String firstName;
  final String lastName;
  final String receiverIdentifier;
  final String profilePhoto;
  ClientInfoModel({
    required this.firstName,
    required this.lastName,
    required this.receiverIdentifier,
    required this.profilePhoto,
  });

  factory ClientInfoModel.fromJson(jsonData) {
    return ClientInfoModel(
      firstName: jsonData['firstName'],
      lastName: jsonData['lastName'],
      receiverIdentifier: jsonData['receiverIdentifier'],
      profilePhoto: jsonData['profilePhoto'],
    );
  }
}

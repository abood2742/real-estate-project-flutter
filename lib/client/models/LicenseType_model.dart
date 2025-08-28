class LicensetypeModel {
  final String id;
  final String name;

  LicensetypeModel({required this.id, required this.name});

  factory LicensetypeModel.fromJson(Map<String, dynamic> json) {
    return LicensetypeModel(id: json["id"], name: json["name"]);
  }
}

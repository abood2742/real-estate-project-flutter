class PropertyTypeModel {
  String id;
  String name;
  List<AttributesModel>
      attributes; // ⬅ غير List<dynamic> إلى List<AttributesModel>

  PropertyTypeModel({
    required this.id,
    required this.name,
    required this.attributes,
  });

  factory PropertyTypeModel.fromJson(Map<String, dynamic> jsonData) {
    var attrs = <AttributesModel>[];
    if (jsonData['attributes'] != null) {
      attrs = List<AttributesModel>.from(
    jsonData['attributes'].map((x) => AttributesModel.fromJson(x, hasWrapper: true))
);
}

    return PropertyTypeModel(
      id: jsonData['id'],
      name: jsonData['name'],
      attributes: attrs,
    );
  }
}
class AttributesModel {
  String id;
  String name;
  String type;

  AttributesModel({
    required this.id,
    required this.name,
    required this.type,
  });

  factory AttributesModel.fromJson(Map<String, dynamic> json, {bool hasWrapper = false}) {
    final data = hasWrapper ? json["attribute"] : json;
    return AttributesModel(
      id: data["id"],
      name: data["name"],
      type: data["type"],
    );
  }
}

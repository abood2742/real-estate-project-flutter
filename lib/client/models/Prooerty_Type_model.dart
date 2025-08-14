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
          jsonData['attributes'].map((x) => AttributesModel.fromJson(x)));
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

  factory AttributesModel.fromJson(Map<String, dynamic> json) {

    return AttributesModel(
      id: json["attribute"]["id"],
      name: json["attribute"]["name"],
      type: json["attribute"]["type"],
    );
  }
}

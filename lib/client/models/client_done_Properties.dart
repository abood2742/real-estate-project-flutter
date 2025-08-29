import 'package:property_system/client/models/property_model.dart';

class ClientDoneProperties {
  final String id;
  final String date;
  final String type;
  final PropertyModel propertyModel;

  ClientDoneProperties(
      {required this.id,
      required this.date,
      required this.type,
      required this.propertyModel});

  factory ClientDoneProperties.fromJson(Map<String, dynamic> json) {
    return ClientDoneProperties(
        id: json["id"],
        date: json["date"],
        type: json['type'],
        propertyModel: PropertyModel.fromJson(json['property']));
  }
}

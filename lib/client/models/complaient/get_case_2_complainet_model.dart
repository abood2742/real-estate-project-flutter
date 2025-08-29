  import 'package:property_system/client/models/property_model.dart';

class GetCase2ComplainetModel {
  final String id;
  final String title;
  final String content;
  final String date;
  final PropertyModel propertyModel;
  final List<PropertyComplaintPhoto> propertyComplaintPhotos;

  GetCase2ComplainetModel({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.propertyModel,
    required this.propertyComplaintPhotos,
  });

  factory GetCase2ComplainetModel.fromJson(Map<String, dynamic> json) {
    return GetCase2ComplainetModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      date: json['date'] ?? '',
      propertyModel: PropertyModel.fromJson(json['property'] ?? {}),
      propertyComplaintPhotos: (json['propertyComplaintPhotos'] as List<dynamic>? ?? [])
          .map((e) => PropertyComplaintPhoto.fromJson(e))
          .toList(),
    );
  }
}

class PropertyComplaintPhoto {
  final String id;
  final String publicId;
  final String url;

  PropertyComplaintPhoto({
    required this.id,
    required this.publicId,
    required this.url,
  });

  factory PropertyComplaintPhoto.fromJson(Map<String, dynamic> json) {
    return PropertyComplaintPhoto(
      id: json['id'] ?? '',
      publicId: json['public_id'] ?? '',
      url: json['url'] ?? '',
    );
  }
}

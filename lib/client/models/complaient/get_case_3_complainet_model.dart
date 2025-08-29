  import 'package:property_system/client/models/profile.model.dart';

class GetCase3ComplainetModel {
  final String id;
  final String title;
  final String content;
  final String date;
  final ProfileModel user;
  final List<OfficeComplaintPhoto> officeComplaintPhotos;

  GetCase3ComplainetModel({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.user,
    required this.officeComplaintPhotos,
  });

  factory GetCase3ComplainetModel.fromJson(Map<String, dynamic> json) {
    return GetCase3ComplainetModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      date: json['date'] ?? '',
      user: ProfileModel.fromJson(json['user'] ?? {}),
      officeComplaintPhotos: (json['officeComplaintPhotos'] as List<dynamic>? ?? [])
          .map((e) => OfficeComplaintPhoto.fromJson(e))
          .toList(),
    );
  }
}

class OfficeComplaintPhoto {
  final String id;
  final String publicId;
  final String url;

  OfficeComplaintPhoto({
    required this.id,
    required this.publicId,
    required this.url,
  });

  factory OfficeComplaintPhoto.fromJson(Map<String, dynamic> json) {
    return OfficeComplaintPhoto(
      id: json['id'] ?? '',
      publicId: json['public_id'] ?? '',
      url: json['url'] ?? '',
    );
  }
}

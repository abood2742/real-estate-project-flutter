import 'package:property_system/client/models/office_details_model.dart';
import 'package:property_system/client/models/photo_model.dart';

class BlogModel {
  final String id;
  final String title;
  final String content;
  final OfficeDetailsModel office;
  final Photo blogMedia;

  BlogModel({
    required this.title,
    required this.content,
    required this.office,
    required this.blogMedia,
    required this.id,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json["id"],
      title: json["title"],
      content: json["content"],
      office: OfficeDetailsModel.fromJson(json["office"], isFavorite: false),
      blogMedia: Photo.fromJson(json["blog_media"]),
    );
  }
}

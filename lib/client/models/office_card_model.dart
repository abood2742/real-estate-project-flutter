// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:property_system/client/models/photo_model.dart';

PageModel welcomeFromJson(String str) {
  final jsonData = json.decode(str);
  return PageModel.fromJson(jsonData);
}

String welcomeToJson(PageModel data) {
  final mapData = data.toJson();
  return json.encode(mapData);
}

class PageModel {
  List<OfficeCardModel> data;
  int total;
  int page;
  int limit;
  int pageCount;

  PageModel({
    required this.data,
    required this.total,
    required this.page,
    required this.limit,
    required this.pageCount,
  });

  factory PageModel.fromJson(Map<String, dynamic> json) {
    return PageModel(
      data: List<OfficeCardModel>.from(
        json["data"].map((x) => OfficeCardModel.fromJson(x)),
      ),
      total: json["total"],
      page: json["page"],
      limit: json["limit"],
      pageCount: json["pageCount"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "data": List<dynamic>.from(data.map((x) => x.toJson())),
      "total": total,
      "page": page,
      "limit": limit,
      "pageCount": pageCount,
    };
  }
}

class OfficeCardModel {
  String id;
  String name;
  String officePhone;
  String officeEmail;

  String status; /* * */

  Photo officePhoto;
  double ratings;

  List<dynamic> blogs; /* * */

  OfficeCardModel({
    required this.id,
    required this.name,
    required this.officePhone,
    required this.officeEmail,
    required this.status,
    /* * */

    required this.officePhoto,
    required this.ratings,
    required this.blogs,
    /* * */
  });

  factory OfficeCardModel.fromJson(Map<String, dynamic> json) {
    return OfficeCardModel(
      id: json["id"],
      name: json["name"],
      officePhone: json["office_phone"],
      officeEmail: json["office_email"],
      status: json["status"],
      officePhoto: Photo.fromJson(json["office_photo"]),
      ratings: json["ratings"],
      blogs: List<dynamic>.from(json["blogs"].map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "office_phone": officePhone,
      "office_email": officeEmail,
      "status": status,
      "office_photo": officePhoto.toJson(),
      "ratings": ratings,
      "blogs": List<dynamic>.from(blogs.map((x) => x)),
    };
  }
}




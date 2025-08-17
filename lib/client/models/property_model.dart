import 'package:property_system/client/models/photo_model.dart';
import 'package:property_system/client/models/property_type_model.dart';

class PropertyPageModel {
  List<PropertyModel> data;
  int total;
  int page;
  int limit;
  int pageCount;

  PropertyPageModel({
    required this.data,
    required this.total,
    required this.page,
    required this.limit,
    required this.pageCount,
  });

  factory PropertyPageModel.fromJson(Map<String, dynamic> json) {
    return PropertyPageModel(
      data: List<PropertyModel>.from(
        json["data"].map((x) => PropertyModel.fromJson(x)),
      ),
      total: json["total"],
      page: json["page"],
      limit: json["limit"],
      pageCount: json["pageCount"],
    );
  }
}

class PropertyModel {
  String id;
  String propertyNumber;
  String typeOperation;
  int space;
  String price;
  String description;
  PropertyType propertyType;
  Location location;
  DateTime publishDate;
  String status;
  bool softDelete;
  List<Photo> photos;
  LicenseDetails licenseDetails;
  List<PropertyAttribute> propertyAttributes;
  DateTime createdAt;

  PropertyModel({
    required this.id,
    required this.propertyNumber,
    required this.typeOperation,
    required this.space,
    required this.price,
    required this.description,
    required this.propertyType,
    required this.location,
    required this.publishDate,
    required this.status,
    required this.softDelete,
    required this.photos,
    required this.licenseDetails,
    required this.propertyAttributes,
    required this.createdAt,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    var convertedPhotos = <Photo>[];
    if (json['photos'] != null) {
      convertedPhotos =
          List<Photo>.from(json['photos'].map((x) => Photo.fromJson(x)));
    }

    var convertedPropertyAttributes = <PropertyAttribute>[];
    if (json['propertyAttributes'] != null) {
      convertedPropertyAttributes = List<PropertyAttribute>.from(
          json['propertyAttributes'].map((x) => PropertyAttribute.fromJson(x)));
    }

    return PropertyModel(
        id: json["id"],
        propertyNumber: json["propertyNumber"],
        typeOperation: json["typeOperation"],
        space: json["space"],
        price: json["price"],
        description: json["description"],
        propertyType: PropertyType.fromJson(json["propertyType"]),
        location: Location.fromJson(json["location"]),
        publishDate: DateTime.parse(json["publishDate"]),
        status: json["status"],
        softDelete: json["softDelete"],
        photos: convertedPhotos,
        licenseDetails: LicenseDetails.fromJson(json["licenseDetails"]),
        propertyAttributes: convertedPropertyAttributes,
        createdAt: DateTime.parse(json["createdAt"]));
  }
}

class LicenseDetails {
  String id;
  LicenseModel license;
  String licenseNumber;
  DateTime date;

  LicenseDetails({
    required this.id,
    required this.license,
    required this.licenseNumber,
    required this.date,
  });

  factory LicenseDetails.fromJson(Map<String, dynamic> json) {
    return LicenseDetails(
        id: json["id"],
        license: LicenseModel.fromJson(json["license"]),
        licenseNumber: json["licenseNumber"],
        date: DateTime.parse(json["date"]));
  }
}

class LicenseModel {
  String id;
  String name;

  LicenseModel({
    required this.id,
    required this.name,
  });

  factory LicenseModel.fromJson(Map<String, dynamic> json) {
    return LicenseModel(id: json["id"], name: json["name"]);
  }
}

class PropertyType {
  String id;
  String name;

  PropertyType({
    required this.id,
    required this.name,
  });

  factory PropertyType.fromJson(Map<String, dynamic> json) {
    return PropertyType(id: json["id"], name: json["name"]);
  }
}

class Location {
  String id;
  String governorate;
  String province;
  String city;
  String street;

  Location({
    required this.id,
    required this.governorate,
    required this.province,
    required this.city,
    required this.street,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
        id: json["id"],
        governorate: json["governorate"],
        province: json["province"],
        city: json["city"],
        street: json["street"]);
  }
}

class PropertyAttribute {
  String id;
  AttributesModel attribute;
  String value;

  PropertyAttribute({
    required this.id,
    required this.attribute,
    required this.value,
  });

  factory PropertyAttribute.fromJson(Map<String, dynamic> json) {
    return PropertyAttribute(
        id: json["id"],
        attribute: AttributesModel.fromJson(json["attribute"]),
        value: json["value"]);
  }
}

  class GetCase1ComplainetModel {
  final String id;
  final String title;
  final String content;
  final String date;
  final Office office;
  final List<OfficeComplaintPhoto> officeComplaintPhotos;

  GetCase1ComplainetModel({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.office,
    required this.officeComplaintPhotos,
  });

  factory GetCase1ComplainetModel.fromJson(Map<String, dynamic> json) {
    return GetCase1ComplainetModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      date: json['date'] ?? '',
      office: Office.fromJson(json['office'] ?? {}),
      officeComplaintPhotos: (json['officeComplaintPhotos'] as List<dynamic>? ?? [])
          .map((e) => OfficeComplaintPhoto.fromJson(e))
          .toList(),
    );
  }
}

class Office {
  final String id;
  final String name;
  final String officeEmail;
  final String officePhone;
  final String licenseNumber;
  final String personalIdentityNumber;
  final String status;

  Office({
    required this.id,
    required this.name,
    required this.officeEmail,
    required this.officePhone,
    required this.licenseNumber,
    required this.personalIdentityNumber,
    required this.status,
  });

  factory Office.fromJson(Map<String, dynamic> json) {
    return Office(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      officeEmail: json['office_email'] ?? '',
      officePhone: json['office_phone'] ?? '',
      licenseNumber: json['license_number'] ?? '',
      personalIdentityNumber: json['personal_identity_number'] ?? '',
      status: json['status'] ?? '',
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

class Photo {
  String id;
  String url;
  String publicId;

  Photo({
    required this.id,
    required this.url,
    required this.publicId,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json["id"],
        url: json["url"],
        publicId: json["public_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "public_id": publicId,
      };
}

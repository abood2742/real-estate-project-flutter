class CommentModel {
  String id;
  String content;
  String date;
  CommenterInfo user;

  CommentModel({
    required this.id,
    required this.content,
    required this.date,
    required this.user,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
        id: json["id"],
        content: json["content"],
        date: json["createAt"],
        user: CommenterInfo.fromJson(json["user"]));
  }
}

class Rating {
  String? id;
  int rating;

  Rating({required this.rating, this.id});

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        rating: json["rating"],
        id: json["id"],
      );
}

class CommenterInfo {
  String firstName;
  String lastName;
  ProfilePhoto? profilePhoto;

  CommenterInfo(
      {required this.firstName, required this.lastName, this.profilePhoto});

  factory CommenterInfo.fromJson(Map<String, dynamic> json) => CommenterInfo(
        firstName: json["first_name"],
        lastName: json["last_name"],
        profilePhoto: json['profile_photo'] != null
            ? ProfilePhoto.fromJson(json['profile_photo'])
            : null,
      );
}

class ProfilePhoto {
  String url;

  ProfilePhoto({
    required this.url,
  });

  factory ProfilePhoto.fromJson(Map<String, dynamic> json) => ProfilePhoto(
        url: json["url"],
      );
}

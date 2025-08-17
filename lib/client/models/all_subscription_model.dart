// class AllSubscriptionModel {
//   String accessToken;
//   String refreshToken;

//   AllSubscriptionModel({
//     required this.accessToken,
//     required this.refreshToken,
//   });

//   factory AllSubscriptionModel.fromJson(Map<String, dynamic> json) =>
//       AllSubscriptionModel(
//         accessToken: json["accessToken"],
//         refreshToken: json["refreshToken"],
//       );

//   Map<String, dynamic> toJson() => {
//         "accessToken": accessToken,
//         "refreshToken": refreshToken,
//       };
// }
class AllSubscriptionModel {
  final String name;
  final String description;
  final double price;
  final String period;
  final int maxProperties;
  final int maxPromotions;

  AllSubscriptionModel({
    required this.name,
    required this.description,
    required this.price,
    required this.period,
    required this.maxProperties,
    required this.maxPromotions,
  });

  factory AllSubscriptionModel.fromJson(Map<String, dynamic> json) {
    return AllSubscriptionModel(
      name: json["name"],
      description: json["description"],
      price: json["price"].toDouble(),
      period: json["period"],
      maxProperties: json["maxProperties"],
      maxPromotions: json["maxPromotions"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "price": price,
      "period": period,
      "maxProperties": maxProperties,
      "maxPromotions": maxPromotions,
    };
  }
}

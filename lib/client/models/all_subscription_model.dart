
class AllSubscriptionModel {
  final String id;
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
    required this.id
  });

  factory AllSubscriptionModel.fromJson(Map<String, dynamic> json) {
    return AllSubscriptionModel(
      name: json["name"],
      description: json["description"],
      price: double.parse(json["price"].toString()),     // تحويل من String إلى double
      period: json["duration"].toString(),               // اسم الحقل من API
      maxProperties: json["propertyNumber"],            // اسم الحقل من API
      maxPromotions: json["numberOfPromotion"], 
       id:json["id"]  ,          // اسم الحقل من API
    );
  }
}

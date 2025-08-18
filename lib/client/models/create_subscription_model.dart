class CreateSubscriptionModel {
  String subscriptionId;
  String cardNumber;
  int expiryMonth;
  int expiryYear;
  String cvv;
  String type;

  CreateSubscriptionModel({
    required this.subscriptionId,
    required this.cardNumber,
    required this.expiryMonth,
    required this.expiryYear,
    required this.cvv,
    required this.type,
  });

  // تحويل من JSON
  factory CreateSubscriptionModel.fromJson(Map<String, dynamic> json) {
    return CreateSubscriptionModel(
      subscriptionId: json['subscriptionId'],
      cardNumber: json['cardNumber'],
      expiryMonth: json['expiryMonth'],
      expiryYear: json['expiryYear'],
      cvv: json['cvv'],
      type: json['type'],
    );
  }

  // تحويل إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'subscriptionId': subscriptionId,
      'cardNumber': cardNumber,
      'expiryMonth': expiryMonth,
      'expiryYear': expiryYear,
      'cvv': cvv,
      'type': type,
    };
  }
}

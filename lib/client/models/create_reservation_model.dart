// class CreateReservationModel {
//   final String type;
//   final String cardNumber;
//   final int expiryMonth;
//   final int expiryYear;
//   final String cvv;
//   final String propertyId;

//   CreateReservationModel({
//     required this.type,
//     required this.cardNumber,
//     required this.expiryMonth,
//     required this.expiryYear,
//     required this.cvv,
//     required this.propertyId,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       "type": type,
//       "cardNumber": cardNumber,
//       "expiryMonth": expiryMonth,
//       "expiryYear": expiryYear,
//       "cvv": cvv,
//       "propertyId": propertyId,
//     };
//   }
// }
class CreateReservationModel {
  final String type;
  final String cardNumber;
  final int expiryMonth;
  final int expiryYear;
  final String cvv;
  final String propertyId;

  CreateReservationModel({
    required this.type,
    required this.cardNumber,
    required this.expiryMonth,
    required this.expiryYear,
    required this.cvv,
    required this.propertyId,
  });

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "cardNumber": cardNumber,
      "expiryMonth": expiryMonth,
      "expiryYear": expiryYear,
      "cvv": cvv,
      "propertyId": propertyId,
    };
  }
}

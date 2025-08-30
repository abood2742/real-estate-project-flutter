// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:property_system/client/models/create_reservation_model.dart';
// // import 'package:property_system/client/services/client_reservation_service_done.dart';

// // class ClientCreateReservationPage extends StatefulWidget {
// //   final String propertyId;

// //   const ClientCreateReservationPage({
// //     super.key,
// //     required this.propertyId,
// //   });

// //   @override
// //   State<ClientCreateReservationPage> createState() =>
// //       _ClientCreateReservationPageState();
// // }

// // class _ClientCreateReservationPageState
// //     extends State<ClientCreateReservationPage> {
// //   final _formKey = GlobalKey<FormState>();
// //   final _cardNumberController = TextEditingController();
// //   final _expiryDateController = TextEditingController();
// //   final _cvvController = TextEditingController();

// //   String _selectedType = 'visa';
// //   bool _isProcessing = false;

// //   @override
// //   void dispose() {
// //     _cardNumberController.dispose();
// //     _expiryDateController.dispose();
// //     _cvvController.dispose();
// //     super.dispose();
// //   }

// //   Future<void> _submit() async {
// //     if (!_formKey.currentState!.validate()) return;

// //     setState(() => _isProcessing = true);

// //     final expiryParts = _expiryDateController.text.split('/');

// //     final reservationModel = CreateReservationModel(
// //     //  propertyId: widget.propertyId,
// //       type: _selectedType,
// //       cardNumber: _cardNumberController.text.replaceAll(' ', ''),
// //       expiryMonth: int.parse(expiryParts[0]),
// //       expiryYear: int.parse(expiryParts[1]),
// //       cvv: _cvvController.text, amount: 1.2,
// //     );

// //     print(reservationModel.toJson()); // 👈 عشان تتأكد بالـ console

// //     final isSuccess =
// //         await ClientReservationService().createReservation(reservationModel,propertyId:widget.propertyId);
// //         //getCommentsOnOffice(officeId: widget.officeId);

// //     setState(() => _isProcessing = false);

// //     if (isSuccess) {
// //       _showPaymentSuccessDialog();
// //     } else {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text("فشل الحجز ❌")),
// //       );
// //     }
// //   }

// //   void _showPaymentSuccessDialog() {
// //     showDialog(
// //       context: context,
// //       builder: (context) {
// //         return AlertDialog(
// //           title: const Text("نجاح ✅"),
// //           content: const Text("تم حجز العقار بنجاح!"),
// //           actions: [
// //             TextButton(
// //               onPressed: () {
// //                 Navigator.pop(context); // غلق الـ Dialog
// //                 Navigator.pop(context, true); // رجوع للصفحة السابقة
// //               },
// //               child: const Text("موافق"),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text(
// //           'بيانات الدفع لحجز العقار',
// //           style: TextStyle(
// //             fontSize: 18,
// //             color: Color.fromARGB(255, 66, 198, 139),
// //             fontFamily: 'Pacifico',
// //           ),
// //         ),
// //         centerTitle: true,
// //       ),
// //       body: SingleChildScrollView(
// //         padding: const EdgeInsets.all(16),
// //         child: Form(
// //           key: _formKey,
// //           child: Column(
// //             children: [
// //               _buildCardNumberField(),
// //               const SizedBox(height: 16),
// //               Row(
// //                 children: [
// //                   Expanded(child: _buildExpiryDateField()),
// //                   const SizedBox(width: 16),
// //                   Expanded(child: _buildCvvField()),
// //                 ],
// //               ),
// //               const SizedBox(height: 16),
// //               _buildCardTypeDropdown(),
// //               const SizedBox(height: 24),
// //               SizedBox(
// //                 width: double.infinity,
// //                 child: ElevatedButton(
// //                   onPressed: _isProcessing ? null : _submit,
// //                   style: ElevatedButton.styleFrom(
// //                     padding: const EdgeInsets.symmetric(vertical: 16),
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(8),
// //                     ),
// //                   ),
// //                   child: _isProcessing
// //                       ? const CircularProgressIndicator(color: Colors.white)
// //                       : const Text(
// //                           'تأكيد الحجز',
// //                           style: TextStyle(
// //                               fontSize: 18, fontWeight: FontWeight.bold),
// //                         ),
// //                 ),
// //               ),
// //               const SizedBox(height: 16),
// //               _buildSecurityInfo(),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildCardNumberField() {
// //     return TextFormField(
// //       controller: _cardNumberController,
// //       decoration: const InputDecoration(
// //         labelText: 'رقم البطاقة',
// //         border: OutlineInputBorder(),
// //         hintText: '1234 5678 9012 3456',
// //       ),
// //       keyboardType: TextInputType.number,
// //       inputFormatters: [
// //         FilteringTextInputFormatter.digitsOnly,
// //         LengthLimitingTextInputFormatter(16),
// //         CardNumberFormatter(),
// //       ],
// //       validator: (value) {
// //         if (value == null || value.isEmpty) return 'الرجاء إدخال رقم البطاقة';
// //         if (value.replaceAll(' ', '').length < 16) {
// //           return 'رقم البطاقة يجب أن يكون 16 رقمًا';
// //         }
// //         return null;
// //       },
// //     );
// //   }

// //   Widget _buildExpiryDateField() {
// //     return TextFormField(
// //       controller: _expiryDateController,
// //       decoration: const InputDecoration(
// //         labelText: 'تاريخ الانتهاء',
// //         border: OutlineInputBorder(),
// //         hintText: 'MM/YY',
// //       ),
// //       keyboardType: TextInputType.number,
// //       inputFormatters: [
// //         FilteringTextInputFormatter.digitsOnly,
// //         LengthLimitingTextInputFormatter(4),
// //         ExpiryDateFormatter(),
// //       ],
// //       validator: (value) {
// //         if (value == null || value.isEmpty) {
// //           return 'الرجاء إدخال تاريخ الانتهاء';
// //         }
// //         if (value.length < 5) {
// //           return 'يجب أن يكون التاريخ بالصيغة MM/YY';
// //         }
// //         return null;
// //       },
// //     );
// //   }

// //   Widget _buildCvvField() {
// //     return TextFormField(
// //       controller: _cvvController,
// //       keyboardType: TextInputType.number,
// //       obscureText: true,
// //       decoration: const InputDecoration(
// //         labelText: 'CVV',
// //         border: OutlineInputBorder(),
// //         hintText: '123',
// //       ),
// //       inputFormatters: [
// //         FilteringTextInputFormatter.digitsOnly,
// //         LengthLimitingTextInputFormatter(3),
// //       ],
// //       validator: (value) {
// //         if (value == null || value.isEmpty) return 'الرجاء إدخال CVV';
// //         if (value.length < 3) return 'CVV يجب أن يكون 3 أرقام';
// //         return null;
// //       },
// //     );
// //   }

// //   Widget _buildCardTypeDropdown() {
// //     return DropdownButtonFormField<String>(
// //       value: _selectedType,
// //       decoration: const InputDecoration(
// //         labelText: 'نوع البطاقة',
// //         border: OutlineInputBorder(),
// //       ),
// //       items: const [
// //         DropdownMenuItem(
// //           value: 'visa',
// //           child: Text('Visa'),
// //         ),
// //         DropdownMenuItem(
// //           value: 'mastercard',
// //           child: Text('MasterCard'),
// //         ),
// //       ],
// //       onChanged: (value) {
// //         setState(() => _selectedType = value!);
// //       },
// //     );
// //   }

// //   Widget _buildSecurityInfo() {
// //     return const Text(
// //       'نحن لا نخزن بيانات بطاقتك البنكية. الدفع آمن بالكامل.',
// //       textAlign: TextAlign.center,
// //       style: TextStyle(color: Colors.grey),
// //     );
// //   }
// // }

// // // Formatter لرقم البطاقة
// // class CardNumberFormatter extends TextInputFormatter {
// //   @override
// //   TextEditingValue formatEditUpdate(
// //       TextEditingValue oldValue, TextEditingValue newValue) {
// //     final digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');
// //     final buffer = StringBuffer();
// //     for (int i = 0; i < digitsOnly.length; i++) {
// //       if (i != 0 && i % 4 == 0) buffer.write(' ');
// //       buffer.write(digitsOnly[i]);
// //     }
// //     return TextEditingValue(
// //       text: buffer.toString(),
// //       selection: TextSelection.collapsed(offset: buffer.length),
// //     );
// //   }
// // }

// // // Formatter لتاريخ الانتهاء
// // class ExpiryDateFormatter extends TextInputFormatter {
// //   @override
// //   TextEditingValue formatEditUpdate(
// //       TextEditingValue oldValue, TextEditingValue newValue) {
// //     var digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');
// //     if (digitsOnly.length > 4) digitsOnly = digitsOnly.substring(0, 4);
// //     final buffer = StringBuffer();
// //     for (int i = 0; i < digitsOnly.length; i++) {
// //       if (i == 2) buffer.write('/');
// //       buffer.write(digitsOnly[i]);
// //     }
// //     return TextEditingValue(
// //       text: buffer.toString(),
// //       selection: TextSelection.collapsed(offset: buffer.length),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:property_system/client/models/create_reservation_model.dart';
// import 'package:property_system/client/services/client_reservation_service_done.dart';
// import 'package:property_system/l10n/app_localizations.dart';

// class ClientCreateReservationPage extends StatefulWidget {
//   final String propertyId;

//   const ClientCreateReservationPage({
//     super.key,
//     required this.propertyId,
//   });

//   @override
//   State<ClientCreateReservationPage> createState() =>
//       _ClientCreateReservationPageState();
// }

// class _ClientCreateReservationPageState
//     extends State<ClientCreateReservationPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _cardNumberController = TextEditingController();
//   final _expiryDateController = TextEditingController();
//   final _cvvController = TextEditingController();

//   String _selectedType = 'visa';
//   bool _isProcessing = false;

//   @override
//   void dispose() {
//     _cardNumberController.dispose();
//     _expiryDateController.dispose();
//     _cvvController.dispose();
//     super.dispose();
//   }

//   Future<void> _submit() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() => _isProcessing = true);

//     final expiryParts = _expiryDateController.text.split('/');

//     final reservationModel = CreateReservationModel(
//       // propertyId: widget.propertyId,
//       type: _selectedType,
//       cardNumber: _cardNumberController.text.replaceAll(' ', ''),
//       expiryMonth: int.parse(expiryParts[0]),
//       expiryYear: int.parse(expiryParts[1]),
//       cvv: _cvvController.text,
//       amount: 1.2,
//     );

//     print(reservationModel.toJson()); // 👈 عشان تتأكد بالـ console

//     final isSuccess =
//         await ClientReservationService().createReservation(reservationModel, propertyId: widget.propertyId);
//     //getCommentsOnOffice(officeId: widget.officeId);

//     setState(() => _isProcessing = false);

//     if (isSuccess) {
//       _showPaymentSuccessDialog();
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(localizations.translate('reservation_failed'))),
//       );
//     }
//   }

//   void _showPaymentSuccessDialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text(localizations.translate('success')),
//           content: Text(localizations.translate('reservation_success')),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context); // غلق الـ Dialog
//                 Navigator.pop(context, true); // رجوع للصفحة السابقة
//               },
//               child: Text(localizations.translate('ok')),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final localizations = AppLocalizations.of(context)!;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           localizations.translate('payment_details'),
//           style: const TextStyle(
//             fontSize: 18,
//             color: Color.fromARGB(255, 66, 198, 139),
//             fontFamily: 'Pacifico',
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               _buildCardNumberField(),
//               const SizedBox(height: 16),
//               Row(
//                 children: [
//                   Expanded(child: _buildExpiryDateField()),
//                   const SizedBox(width: 16),
//                   Expanded(child: _buildCvvField()),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               _buildCardTypeDropdown(),
//               const SizedBox(height: 24),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: _isProcessing ? null : _submit,
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: _isProcessing
//                       ? const CircularProgressIndicator(color: Colors.white)
//                       : Text(
//                           localizations.translate('confirm_reservation'),
//                           style: const TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               _buildSecurityInfo(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCardNumberField() {
//     return TextFormField(
//       controller: _cardNumberController,
//       decoration: InputDecoration(
//         labelText: localizations.translate('card_number'),
//         border: const OutlineInputBorder(),
//         hintText: localizations.translate('card_number_hint'),
//       ),
//       keyboardType: TextInputType.number,
//       inputFormatters: [
//         FilteringTextInputFormatter.digitsOnly,
//         LengthLimitingTextInputFormatter(16),
//         CardNumberFormatter(),
//       ],
//       validator: (value) {
//         if (value == null || value.isEmpty) return localizations.translate('enter_card_number');
//         if (value.replaceAll(' ', '').length < 16) {
//           return localizations.translate('card_number_length_error');
//         }
//         return null;
//       },
//     );
//   }

//   Widget _buildExpiryDateField() {
//     return TextFormField(
//       controller: _expiryDateController,
//       decoration: InputDecoration(
//         labelText: localizations.translate('expiry_date'),
//         border: const OutlineInputBorder(),
//         hintText: localizations.translate('expiry_date_hint'),
//       ),
//       keyboardType: TextInputType.number,
//       inputFormatters: [
//         FilteringTextInputFormatter.digitsOnly,
//         LengthLimitingTextInputFormatter(4),
//         ExpiryDateFormatter(),
//       ],
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return localizations.translate('enter_expiry_date');
//         }
//         if (value.length < 5) {
//           return localizations.translate('expiry_date_format_error');
//         }
//         return null;
//       },
//     );
//   }

//   Widget _buildCvvField() {
//     return TextFormField(
//       controller: _cvvController,
//       keyboardType: TextInputType.number,
//       obscureText: true,
//       decoration: InputDecoration(
//         labelText: localizations.translate('cvv'),
//         border: OutlineInputBorder(),
//         hintText: localizations.translate('cvv_hint'),
//       ),
//       inputFormatters: [
//         FilteringTextInputFormatter.digitsOnly,
//         LengthLimitingTextInputFormatter(3),
//       ],
//       validator: (value) {
//         if (value == null || value.isEmpty) return localizations.translate('enter_cvv');
//         if (value.length < 3) return localizations.translate('cvv_length_error');
//         return null;
//       },
//     );
//   }

//   Widget _buildCardTypeDropdown() {
//     return DropdownButtonFormField<String>(
//       value: _selectedType,
//       decoration: InputDecoration(
//         labelText: localizations.translate('card_type'),
//         border: const OutlineInputBorder(),
//       ),
//       items: [
//         DropdownMenuItem(
//           value: 'visa',
//           child: Text(localizations.translate('visa')),
//         ),
//         DropdownMenuItem(
//           value: 'mastercard',
//           child: Text(localizations.translate('mastercard')),
//         ),
//       ],
//       onChanged: (value) {
//         setState(() => _selectedType = value!);
//       },
//     );
//   }

//   Widget _buildSecurityInfo() {
//     return Text(
//       localizations.translate('security_info'),
//       textAlign: TextAlign.center,
//       style: const TextStyle(color: Colors.grey),
//     );
//   }
// }

// // Formatter لرقم البطاقة
// class CardNumberFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     final digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');
//     final buffer = StringBuffer();
//     for (int i = 0; i < digitsOnly.length; i++) {
//       if (i != 0 && i % 4 == 0) buffer.write(' ');
//       buffer.write(digitsOnly[i]);
//     }
//     return TextEditingValue(
//       text: buffer.toString(),
//       selection: TextSelection.collapsed(offset: buffer.length),
//     );
//   }
// }

// // Formatter لتاريخ الانتهاء
// class ExpiryDateFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     var digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');
//     if (digitsOnly.length > 4) digitsOnly = digitsOnly.substring(0, 4);
//     final buffer = StringBuffer();
//     for (int i = 0; i < digitsOnly.length; i++) {
//       if (i == 2) buffer.write('/');
//       buffer.write(digitsOnly[i]);
//     }
//     return TextEditingValue(
//       text: buffer.toString(),
//       selection: TextSelection.collapsed(offset: buffer.length),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:property_system/client/models/create_reservation_model.dart';
import 'package:property_system/client/services/client_reservation_service_done.dart';
import 'package:property_system/l10n/app_localizations.dart';

class ClientCreateReservationPage extends StatefulWidget {
  final String propertyId;

  const ClientCreateReservationPage({
    super.key,
    required this.propertyId,
  });

  @override
  State<ClientCreateReservationPage> createState() =>
      _ClientCreateReservationPageState();
}

class _ClientCreateReservationPageState
    extends State<ClientCreateReservationPage> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();

  String _selectedType = 'visa';
  bool _isProcessing = false;

  /// 👉 Getter للوصول لـ AppLocalizations بسهولة بأي مكان داخل الـ State
  AppLocalizations get localizations => AppLocalizations.of(context)!;

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isProcessing = true);

    final expiryParts = _expiryDateController.text.split('/');

    final reservationModel = CreateReservationModel(
      type: _selectedType,
      cardNumber: _cardNumberController.text.replaceAll(' ', ''),
      expiryMonth: int.parse(expiryParts[0]),
      expiryYear: int.parse(expiryParts[1]),
      cvv: _cvvController.text,
      amount: 1.2,
    );

    print(reservationModel.toJson()); // 👈 Debug

    final isSuccess = await ClientReservationService()
        .createReservation(reservationModel, propertyId: widget.propertyId);

    setState(() => _isProcessing = false);

    if (isSuccess) {
      _showPaymentSuccessDialog();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(localizations.translate('reservation_failed'))),
      );
    }
  }

  void _showPaymentSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(localizations.translate('success')),
          content: Text(localizations.translate('reservation_success')),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // إغلاق Dialog
                Navigator.pop(context, true); // رجوع للصفحة السابقة
              },
              child: Text(localizations.translate('ok')),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations.translate('payment_details'),
          style: const TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 66, 198, 139),
            fontFamily: 'Pacifico',
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildCardNumberField(),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _buildExpiryDateField()),
                  const SizedBox(width: 16),
                  Expanded(child: _buildCvvField()),
                ],
              ),
              const SizedBox(height: 16),
              _buildCardTypeDropdown(),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isProcessing ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: _isProcessing
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          localizations.translate('confirm_reservation'),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
              const SizedBox(height: 16),
              _buildSecurityInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardNumberField() {
    return TextFormField(
      controller: _cardNumberController,
      decoration: InputDecoration(
        labelText: localizations.translate('card_number'),
        border: const OutlineInputBorder(),
        hintText: localizations.translate('card_number_hint'),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(16),
        CardNumberFormatter(),
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return localizations.translate('enter_card_number');
        }
        if (value.replaceAll(' ', '').length < 16) {
          return localizations.translate('card_number_length_error');
        }
        return null;
      },
    );
  }

  Widget _buildExpiryDateField() {
    return TextFormField(
      controller: _expiryDateController,
      decoration: InputDecoration(
        labelText: localizations.translate('expiry_date'),
        border: const OutlineInputBorder(),
        hintText: localizations.translate('expiry_date_hint'),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(4),
        ExpiryDateFormatter(),
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return localizations.translate('enter_expiry_date');
        }
        if (value.length < 5) {
          return localizations.translate('expiry_date_format_error');
        }
        return null;
      },
    );
  }

  Widget _buildCvvField() {
    return TextFormField(
      controller: _cvvController,
      keyboardType: TextInputType.number,
      obscureText: true,
      decoration: InputDecoration(
        labelText: localizations.translate('cvv'),
        border: const OutlineInputBorder(),
        hintText: localizations.translate('cvv_hint'),
      ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(3),
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return localizations.translate('enter_cvv');
        }
        if (value.length < 3) {
          return localizations.translate('cvv_length_error');
        }
        return null;
      },
    );
  }

  Widget _buildCardTypeDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedType,
      decoration: InputDecoration(
        labelText: localizations.translate('card_type'),
        border: const OutlineInputBorder(),
      ),
      items: [
        DropdownMenuItem(
          value: 'visa',
          child: Text(localizations.translate('visa')),
        ),
        DropdownMenuItem(
          value: 'mastercard',
          child: Text(localizations.translate('mastercard')),
        ),
      ],
      onChanged: (value) {
        setState(() => _selectedType = value!);
      },
    );
  }

  Widget _buildSecurityInfo() {
    return Text(
      localizations.translate('security_info'),
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.grey),
    );
  }
}

// Formatter لرقم البطاقة
class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();
    for (int i = 0; i < digitsOnly.length; i++) {
      if (i != 0 && i % 4 == 0) buffer.write(' ');
      buffer.write(digitsOnly[i]);
    }
    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}

// Formatter لتاريخ الانتهاء
class ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length > 4) digitsOnly = digitsOnly.substring(0, 4);
    final buffer = StringBuffer();
    for (int i = 0; i < digitsOnly.length; i++) {
      if (i == 2) buffer.write('/');
      buffer.write(digitsOnly[i]);
    }
    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}

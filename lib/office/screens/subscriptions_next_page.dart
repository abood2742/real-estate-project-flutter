// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class SubscriptionsNextPage extends StatefulWidget {
//   final String planName;
//   final double? planPrice; // أصبح اختياري

//   const SubscriptionsNextPage({
//     super.key,
//     required this.planName,
//     this.planPrice, // لم يعد required
//   });

//   @override
//   State<SubscriptionsNextPage> createState() => _PaymentDetailsPageState();
// }

// class _PaymentDetailsPageState extends State<SubscriptionsNextPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _cardNumberController = TextEditingController();
//   final _expiryDateController = TextEditingController();
//   final _cvvController = TextEditingController();
//   final _cardHolderController = TextEditingController();

//   String _selectedDuration = '1 شهر';
//   bool _saveCardInfo = false;
//   bool _isProcessing = false;

//   final List<String> _durationOptions = [
//     '1 شهر',
//     '2 أشهر',
//     '3 أشهر',
//     '6 أشهر',
//     '12 شهر'
//   ];

//   @override
//   void dispose() {
//     _cardNumberController.dispose();
//     _expiryDateController.dispose();
//     _cvvController.dispose();
//     _cardHolderController.dispose();
//     super.dispose();
//   }

//   // void _processPayment() {
//   //   if (_formKey.currentState!.validate()) {
//   //     setState(() => _isProcessing = true);
      
//   //     // محاكاة عملية الدفع
//   //     Future.delayed(const Duration(seconds: 2), () {
//   //       setState(() => _isProcessing = false);
//   //       _showPaymentSuccessDialog();
//   //     });
//   //   }
//   // }

      




//   void _showPaymentSuccessDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('تم الدفع بنجاح'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Icon(Icons.check_circle, color: Colors.green, size: 60),
//             const SizedBox(height: 16),
//             Text(
//               'تم تفعيل باقة ${widget.planName} بنجاح',
//               style: const TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'المبلغ: \$${widget.planPrice ?? 0}', // التعامل مع null
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'المدة: $_selectedDuration',
//               style: const TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
//             child: const Text('حسناً'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final totalPrice = _calculateTotalPrice();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('بيانات الدفع',
//           style: TextStyle(fontSize: 18,color: Color.fromARGB(255, 44, 82, 207),fontFamily: 'Pacifico'),),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildPlanInfoCard(),
//               const SizedBox(height: 24),
//               const Text(
//                 'معلومات البطاقة',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 8),
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
//               _buildCardHolderField(),
//               const SizedBox(height: 16),
//               _buildDurationDropdown(),
//               const SizedBox(height: 16),
//               // _buildSaveCardCheckbox(),
//               const SizedBox(height: 24),
//               _buildPaymentSummary(totalPrice),
//               const SizedBox(height: 24),
//               _buildPaymentButton(),
//               const SizedBox(height: 16),
//               _buildSecurityInfo(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPlanInfoCard() {
//     return Card(
//       elevation: 2,
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Row(
//           children: [
//             Icon(
//               Icons.credit_card,
//               color: Theme.of(context).primaryColor,
//               size: 40,
//             ),
//             const SizedBox(width: 16),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'الباقة: ${widget.planName}',
//                   style: const TextStyle(fontSize: 16),
//                 ),
//                 Text(
//                   'السعر الشهري: \$${widget.planPrice ?? 0}', // التعامل مع null
//                   style: const TextStyle(fontSize: 16),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCardNumberField() {
//     return TextFormField(
//       controller: _cardNumberController,
//       decoration: InputDecoration(
//         labelText: 'رقم البطاقة',
//         prefixIcon: const Icon(Icons.credit_card),
//         border: OutlineInputBorder(),
//         hintText: '1234 5678 9012 3456',
//       ),
//       keyboardType: TextInputType.number,
//       inputFormatters: [
//         FilteringTextInputFormatter.digitsOnly,
//         LengthLimitingTextInputFormatter(16),
//         CardNumberFormatter(),
//       ],
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'الرجاء إدخال رقم البطاقة';
//         }
//         if (value.length < 16) {
//           return 'رقم البطاقة يجب أن يكون 16 رقمًا';
//         }
//         return null;
//       },
//     );
//   }

//   Widget _buildExpiryDateField() {
//     return TextFormField(
//       controller: _expiryDateController,
//       decoration: InputDecoration(
//         labelText: 'تاريخ الانتهاء',
//         prefixIcon: const Icon(Icons.calendar_today),
//         border: OutlineInputBorder(),
//         hintText: 'MM/YY',
//       ),
//       keyboardType: TextInputType.number,
//       inputFormatters: [
//         FilteringTextInputFormatter.digitsOnly,
//         LengthLimitingTextInputFormatter(4),
//         ExpiryDateFormatter(),
//       ],
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'الرجاء إدخال تاريخ الانتهاء';
//         }
//         if (value.length < 4) {
//           return 'يجب أن يكون التاريخ MM/YY';
//         }
//         return null;
//       },
//     );
//   }

//   Widget _buildCvvField() {
//     return TextFormField(
//       controller: _cvvController,
//       decoration: InputDecoration(
//         labelText: 'CVV',
//         prefixIcon: const Icon(Icons.lock),
//         border: OutlineInputBorder(),
//         hintText: '123',
//       ),
//       keyboardType: TextInputType.number,
//       obscureText: true,
//       inputFormatters: [
//         FilteringTextInputFormatter.digitsOnly,
//         LengthLimitingTextInputFormatter(3),
//       ],
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'الرجاء إدخال CVV';
//         }
//         if (value.length < 3) {
//           return 'CVV يجب أن يكون 3 أرقام';
//         }
//         return null;
//       },
//     );
//   }

//   Widget _buildCardHolderField() {
//     return TextFormField(
//       controller: _cardHolderController,
//       decoration: InputDecoration(
//         labelText: 'اسم صاحب البطاقة',
//         prefixIcon: const Icon(Icons.person),
//         border: OutlineInputBorder(),
//         hintText: 'كما هو مدون على البطاقة',
//       ),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'الرجاء إدخال اسم صاحب البطاقة';
//         }
//         return null;
//       },
//     );
//   }

//   Widget _buildDurationDropdown() {
//     return DropdownButtonFormField<String>(
//       value: _selectedDuration,
//       decoration: InputDecoration(
//         labelText: 'مدة الاشتراك',
//         prefixIcon: const Icon(Icons.calendar_month),
//         border: OutlineInputBorder(),
//       ),
//       items: _durationOptions.map((duration) {
//         return DropdownMenuItem<String>(
//           value: duration,
//           child: Text(duration),
//         );
//       }).toList(),
//       onChanged: (value) {
//         setState(() => _selectedDuration = value!);
//       },
//     );
//   }

//   // Widget _buildSaveCardCheckbox() {
//   //   return Row(
//   //     children: [
//   //       Checkbox(
//   //         value: _saveCardInfo,
//   //         onChanged: (value) {
//   //           setState(() => _saveCardInfo = value!);
//   //         },
//   //       ),
//   //       const Text('حفظ معلومات البطاقة للمرة القادمة'),
//   //     ],
//   //   );
//   // }

//   Widget _buildPaymentSummary(double totalPrice) {
//     return Card(
//       elevation: 2,
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             _buildSummaryRow('الباقة', widget.planName),
//             _buildSummaryRow('السعر الشهري', '\$${widget.planPrice ?? 0}'),
//             _buildSummaryRow('مدة الاشتراك', _selectedDuration),
//             const Divider(),
//             _buildSummaryRow(
//               'المبلغ الإجمالي',
//               '\$${totalPrice.toStringAsFixed(2)}',
//               isTotal: true,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
//             ),
//           ),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
//               color: isTotal ? Theme.of(context).primaryColor : null,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPaymentButton() {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: _isProcessing ? null : _processPayment,
//         style: ElevatedButton.styleFrom(
//           padding: const EdgeInsets.symmetric(vertical: 16),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8),
//           ),
//         ),
//         child: _isProcessing
//             ? const CircularProgressIndicator(color: Colors.white)
//             : const Text(
//                 'تأكيد الدفع',
//                 style: TextStyle(fontSize: 18,color: Color.fromARGB(255, 44, 82, 207),fontFamily: 'Pacifico'),
//               ),
//       ),
//     );
//   }

//   Widget _buildSecurityInfo() {
//     return const Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'معلومات الأمان',
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 8),
//         Text(
//           '• نستخدم تشفير SSL لحماية بياناتك\n'
//           '• لن نقوم بتخزين أي معلومات بطاقة ائتمان على خوادمنا\n'
//           '• جميع المعاملات مؤمنة بالكامل',
//           style: TextStyle(fontSize: 14, color: Colors.grey),
//         ),
//       ],
//     );
//   }

//   double _calculateTotalPrice() {
//     final months = int.parse(_selectedDuration.split(' ')[0]);
//     return (widget.planPrice ?? 0) * months;
//   }
// }

// // فورماتر لتنسيق رقم البطاقة (4444 3333 2222 1111)
// class CardNumberFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//     TextEditingValue oldValue,
//     TextEditingValue newValue,
//   ) {
//     if (newValue.text.length > oldValue.text.length) {
//       final text = newValue.text.replaceAll(RegExp(r'\D'), '');
//       String formatted = '';
//       for (int i = 0; i < text.length; i++) {
//         if (i > 0 && i % 4 == 0) formatted += ' ';
//         formatted += text[i];
//       }
//       return TextEditingValue(
//         text: formatted,
//         selection: TextSelection.collapsed(offset: formatted.length),
//       );
//     }
//     return newValue;
//   }
// }

// // فورماتر لتنسيق تاريخ الانتهاء (MM/YY)
// class ExpiryDateFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//     TextEditingValue oldValue,
//     TextEditingValue newValue,
//   ) {
//     if (newValue.text.length > oldValue.text.length) {
//       final text = newValue.text.replaceAll(RegExp(r'\D'), '');
//       if (text.length >= 3) {
//         final month = text.substring(0, 2);
//         final year = text.substring(2);
//         return TextEditingValue(
//           text: '$month/$year',
//           selection: TextSelection.collapsed(offset: '$month/$year'.length),
//         );
//       }
//     }
//     return newValue;
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:property_system/client/models/create_subscription_model.dart';
import 'package:property_system/client/services/create_subscription_service.dart';

class SubscriptionsNextPage extends StatefulWidget {
  final String planName;
  final double? planPrice;

  const SubscriptionsNextPage({
    super.key,
    required this.planName,
    this.planPrice,
  });

  @override
  State<SubscriptionsNextPage> createState() => _PaymentDetailsPageState();
}

class _PaymentDetailsPageState extends State<SubscriptionsNextPage> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();
  final _cardHolderController = TextEditingController();

  String _selectedDuration = '1 شهر';
  bool _saveCardInfo = false;
  bool _isProcessing = false;

  final List<String> _durationOptions = [
    '1 شهر',
    '2 أشهر', 
    '3 أشهر',
    '6 أشهر',
    '12 شهر'
  ];

  // إضافة الـ Dio instance
  final Dio _dio = Dio();

  @override
  void initState() {
    super.initState();
    // إعداد الـ Dio
    _dio.options.headers['Authorization'] = 'Bearer j9_aTPdJLQjCvC923VBHLqLlka39J5o';
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.baseUrl = 'https://your-api-base-url.com'; // ضع الـ URL الخاص بك
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    _cardHolderController.dispose();
    super.dispose();
  }

  // تفعيل دالة الدفع مع استدعاء API
 
  void _showPaymentSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تم الدفع بنجاح'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 60),
            const SizedBox(height: 16),
            Text(
              'تم تفعيل باقة ${widget.planName} بنجاح',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'المبلغ: \$${widget.planPrice ?? 0}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'المدة: $_selectedDuration',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = _calculateTotalPrice();

    return Scaffold(
      appBar: AppBar(
        title: const Text('بيانات الدفع',
          style: TextStyle(fontSize: 18,color: Color.fromARGB(255, 44, 82, 207),fontFamily: 'Pacifico'),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPlanInfoCard(),
              const SizedBox(height: 24),
              const Text(
                'معلومات البطاقة',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
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
              _buildCardHolderField(),
              const SizedBox(height: 16),
              _buildDurationDropdown(),
              const SizedBox(height: 16),
              _buildPaymentSummary(totalPrice),
              const SizedBox(height: 24),
              _buildPaymentButton(),
              const SizedBox(height: 16),
              _buildSecurityInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlanInfoCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(
              Icons.credit_card,
              color: Theme.of(context).primaryColor,
              size: 40,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'الباقة: ${widget.planName}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'السعر الشهري: \$${widget.planPrice ?? 0}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardNumberField() {
    return TextFormField(
      controller: _cardNumberController,
      decoration: InputDecoration(
        labelText: 'رقم البطاقة',
        prefixIcon: const Icon(Icons.credit_card),
        border: OutlineInputBorder(),
        hintText: '1234 5678 9012 3456',
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(16),
        CardNumberFormatter(),
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'الرجاء إدخال رقم البطاقة';
        }
        if (value.length < 16) {
          return 'رقم البطاقة يجب أن يكون 16 رقمًا';
        }
        return null;
      },
    );
  }

  Widget _buildExpiryDateField() {
    return TextFormField(
      controller: _expiryDateController,
      decoration: InputDecoration(
        labelText: 'تاريخ الانتهاء',
        prefixIcon: const Icon(Icons.calendar_today),
        border: OutlineInputBorder(),
        hintText: 'MM/YY',
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(4),
        ExpiryDateFormatter(),
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'الرجاء إدخال تاريخ الانتهاء';
        }
        if (value.length < 4) {
          return 'يجب أن يكون التاريخ MM/YY';
        }
        return null;
      },
    );
  }

  Widget _buildCvvField() {
    return TextFormField(
      controller: _cvvController,
      decoration: InputDecoration(
        labelText: 'CVV',
        prefixIcon: const Icon(Icons.lock),
        border: OutlineInputBorder(),
        hintText: '123',
      ),
      keyboardType: TextInputType.number,
      obscureText: true,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(3),
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'الرجاء إدخال CVV';
        }
        if (value.length < 3) {
          return 'CVV يجب أن يكون 3 أرقام';
        }
        return null;
      },
    );
  }

  Widget _buildCardHolderField() {
    return TextFormField(
      controller: _cardHolderController,
      decoration: InputDecoration(
        labelText: 'اسم صاحب البطاقة',
        prefixIcon: const Icon(Icons.person),
        border: OutlineInputBorder(),
        hintText: 'كما هو مدون على البطاقة',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'الرجاء إدخال اسم صاحب البطاقة';
        }
        return null;
      },
    );
  }

  Widget _buildDurationDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedDuration,
      decoration: InputDecoration(
        labelText: 'مدة الاشتراك',
        prefixIcon: const Icon(Icons.calendar_month),
        border: OutlineInputBorder(),
      ),
      items: _durationOptions.map((duration) {
        return DropdownMenuItem<String>(
          value: duration,
          child: Text(duration),
        );
      }).toList(),
      onChanged: (value) {
        setState(() => _selectedDuration = value!);
      },
    );
  }

  Widget _buildPaymentSummary(double totalPrice) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSummaryRow('الباقة', widget.planName),
            _buildSummaryRow('السعر الشهري', '\$${widget.planPrice ?? 0}'),
            _buildSummaryRow('مدة الاشتراك', _selectedDuration),
            const Divider(),
            _buildSummaryRow(
              'المبلغ الإجمالي',
              '\$${totalPrice.toStringAsFixed(2)}',
              isTotal: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Theme.of(context).primaryColor : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
onPressed: () async {
  if (_formKey.currentState!.validate()) {
    setState(() => _isProcessing = true);

    final service = SubscriptionService();

    // استدعاء الموديل الجاهز مع القيم
    final model = CreateSubscriptionModel(
      subscriptionId: widget.planName, // أو الـ id اذا عندك
      cardNumber: _cardNumberController.text,
      expiryMonth: int.parse(_expiryDateController.text.split('/')[0]),
      expiryYear: int.parse(_expiryDateController.text.split('/')[1]),
      cvv: _cvvController.text,
      type: _selectedDuration,
    );

    final success = await service.registerSubscription(model);

    setState(() => _isProcessing = false);

    if (success) {
      _showPaymentSuccessDialog();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('فشل في الدفع، حاول لاحقاً')),
      );
    }
  }
},
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: _isProcessing
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
                'تأكيد الدفع',
                style: TextStyle(fontSize: 18,color: Color.fromARGB(255, 44, 82, 207),fontFamily: 'Pacifico'),
              ),
      ),
    );
  }

  Widget _buildSecurityInfo() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'معلومات الأمان',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          '• نستخدم تشفير SSL لحماية بياناتك\n'
          '• لن نقوم بتخزين أي معلومات بطاقة ائتمان على خوادمنا\n'
          '• جميع المعاملات مؤمنة بالكامل',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }

  double _calculateTotalPrice() {
    final months = int.parse(_selectedDuration.split(' ')[0]);
    return (widget.planPrice ?? 0) * months;
  }
}

// فورماتر لتنسيق رقم البطاقة (4444 3333 2222 1111)
class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.length > oldValue.text.length) {
      final text = newValue.text.replaceAll(RegExp(r'\D'), '');
      String formatted = '';
      for (int i = 0; i < text.length; i++) {
        if (i > 0 && i % 4 == 0) formatted += ' ';
        formatted += text[i];
      }
      return TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }
    return newValue;
  }
}

// فورماتر لتنسيق تاريخ الانتهاء (MM/YY)
class ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.length > oldValue.text.length) {
      final text = newValue.text.replaceAll(RegExp(r'\D'), '');
      if (text.length >= 3) {
        final month = text.substring(0, 2);
        final year = text.substring(2);
        return TextEditingValue(
          text: '$month/$year',
          selection: TextSelection.collapsed(offset: '$month/$year'.length),
        );
      }
    }
    return newValue;
  }
}
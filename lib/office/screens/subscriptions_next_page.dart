
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:property_system/client/models/create_subscription_model.dart';
import 'package:property_system/client/services/subscription_service_done.dart';

class SubscriptionsNextPage extends StatefulWidget {
  final String planName;
  final double? planPrice;
  final String id;

  const SubscriptionsNextPage({
    super.key,
    required this.planName,
    this.planPrice,
    required this.id,
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
  String _selectedType = 'visa';
  bool _isProcessing = false;

  final List<String> _durationOptions = ['1', '2', '3', '6', '12'];

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    _cardHolderController.dispose();
    super.dispose();
  }

  double _calculateTotalPrice() {
    final months = int.parse(_selectedDuration.split(' ')[0]);
    return (widget.planPrice ?? 0) * months;
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = _calculateTotalPrice();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'بيانات الدفع',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPlanInfoCard(),
              const SizedBox(height: 24),
              const Text('معلومات البطاقة',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
              _buildCardTypeDropdown(),
              const SizedBox(height: 24),
              _buildPaymentSummary(totalPrice),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    // OnEmbraced
                    if (_formKey.currentState!.validate()) {
                      setState(() => _isProcessing = true);

                      // تجهيز الموديل مع ID اللي جاي من الصفحة السابقة
                      final paymentModel = CreateSubscriptionModel(
                        subscriptionId: widget.id,
                        cardNumber:
                            _cardNumberController.text.replaceAll(' ', ''),
                        expiryMonth:
                            int.parse(_expiryDateController.text.split('/')[0]),
                        expiryYear:
                            int.parse(_expiryDateController.text.split('/')[1]),
                        cvv: _cvvController.text, type: _selectedType,
                        // type: _selectedDuration,
                        // duration: int.parse(_selectedDuration.split(' ')[0]).toString(), // 👈 هنا التعديل المهم

                      );
                      print(paymentModel.toJson());

                      final isSuccess =
                          await SubscriptionService().registerSubscription(
                        paymentModel,
                      );

                      setState(() => _isProcessing = false);

                      if (isSuccess) {
                        _showPaymentSuccessDialog(totalPrice);
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
                      : const Text('تأكيد الدفع',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
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

  void _showPaymentSuccessDialog(double totalPrice) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تم الدفع بنجاح'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, size: 60),
            const SizedBox(height: 16),
            Text('تم تفعيل باقة ${widget.planName} بنجاح'),
            Text('المبلغ: \$${totalPrice.toStringAsFixed(2)}'),
            Text('المدة: $_selectedDuration'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسناً'),
          ),
        ],
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
                Text('الباقة: ${widget.planName}',
                    style: const TextStyle(fontSize: 16)),
                Text('السعر الشهري: \$${widget.planPrice ?? 0}',
                    style: const TextStyle(fontSize: 16)),
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
      decoration: const InputDecoration(
        labelText: 'رقم البطاقة',
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
        if (value == null || value.isEmpty) return 'الرجاء إدخال رقم البطاقة';
        if (value.replaceAll(' ', '').length < 16)
          return 'رقم البطاقة يجب أن يكون 16 رقمًا';
        return null;
      },
    );
  }

  Widget _buildExpiryDateField() {
    return TextFormField(
      controller: _expiryDateController,
      decoration: const InputDecoration(
        labelText: 'تاريخ الانتهاء',
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
        if (value == null || value.isEmpty)
          return 'الرجاء إدخال تاريخ الانتهاء';
        if (value.length < 5) return 'يجب أن يكون التاريخ بالصيغة MM/YY';
        return null;
      },
    );
  }

  Widget _buildCvvField() {
    return TextFormField(
      controller: _cvvController,
      keyboardType: TextInputType.number,
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'CVV',
        border: OutlineInputBorder(),
        hintText: '123',
      ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(3),
      ],
      validator: (value) {
        if (value == null || value.isEmpty) return 'الرجاء إدخال CVV';
        if (value.length < 3) return 'CVV يجب أن يكون 3 أرقام';
        return null;
      },
    );
  }

  Widget _buildCardHolderField() {
    return TextFormField(
      controller: _cardHolderController,
      decoration: const InputDecoration(
        labelText: 'اسم صاحب البطاقة',
        border: OutlineInputBorder(),
        hintText: 'كما هو مدون على البطاقة',
      ),
      validator: (value) {
        if (value == null || value.isEmpty)
          return 'الرجاء إدخال اسم صاحب البطاقة';
        return null;
      },
    );
  }

  Widget _buildDurationDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedDuration,
      decoration: const InputDecoration(
        labelText: 'مدة الاشتراك',
        border: OutlineInputBorder(),
      ),
      items: _durationOptions.map((duration) {
        return DropdownMenuItem<String>(
          value: '$duration شهر',
          child: Text('$duration شهر'),
        );
      }).toList(),
      onChanged: (value) {
        setState(() => _selectedDuration = value!);
      },
    );
  }

  Widget _buildCardTypeDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedType,
      decoration: const InputDecoration(
        labelText: 'نوع البطاقة',
        border: OutlineInputBorder(),
      ),
      items: const [
        DropdownMenuItem(
          value: 'visa',
          child: Text('visa'),
        ),
      ],
      onChanged: (value) {
        setState(() => _selectedType = value!);
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
            _buildSummaryRow('المدة', _selectedDuration),
            const Divider(height: 24),
            _buildSummaryRow(
                'المبلغ الإجمالي', '\$${totalPrice.toStringAsFixed(2)}',
                isTotal: true),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String title, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                  fontSize: isTotal ? 18 : 16)),
          Text(value,
              style: TextStyle(
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                  fontSize: isTotal ? 18 : 16)),
        ],
      ),
    );
  }

  Widget _buildSecurityInfo() {
    return const Text(
      'نحن لا نخزن بيانات بطاقتك البنكية. الدفع آمن بالكامل.',
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.grey),
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

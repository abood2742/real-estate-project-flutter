import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:property_system/client/services/property_service_done.dart';

class DeletePropertyPage extends StatefulWidget {
  final String propertyName;
  final String id;
  final double deleteFee; // 👈 قيمة الرسوم مقابل الحذف

  const DeletePropertyPage({
    super.key,
    required this.propertyName,
    required this.id,
    this.deleteFee = 50.0, // 👈 رسوم افتراضية 10$
  });

  @override
  State<DeletePropertyPage> createState() => _DeletePropertyPageState();
}

class _DeletePropertyPageState extends State<DeletePropertyPage> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();
  final _cardHolderController = TextEditingController();

  String _selectedType = 'visa';
  bool _isProcessing = false;

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    _cardHolderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'حذف العقار',
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
              _buildCardTypeDropdown(),
              const SizedBox(height: 24),
              _buildPaymentSummary(widget.deleteFee),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() => _isProcessing = true);

                      final parts = _expiryDateController.text.split('/');
                      final expiryMonth = int.parse(parts[0]);
                      final expiryYear = int.parse(parts[1]);

                      final isSuccess = await PropertyService()
                          .PayBeforeDeletePropertyById(
                        type: _selectedType,
                        cardNumber:
                            _cardNumberController.text.replaceAll(' ', ''),
                        expiryMonth: expiryMonth,
                        expiryYear: expiryYear,
                        cvv: _cvvController.text,
                        propertyId: widget.id,
                      );

                      setState(() => _isProcessing = false);

                      if (isSuccess != null) {
                        _showPaymentSuccessDialog();
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: _isProcessing
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('ادفع واحذف العقار',
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

  void _showPaymentSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تم الحذف بنجاح'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.delete_forever, size: 60, color: Colors.red),
            const SizedBox(height: 16),
            Text('تم حذف العقار "${widget.propertyName}" بنجاح بعد الدفع.'),
            Text('الرسوم المدفوعة: \$${widget.deleteFee.toStringAsFixed(2)}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // إغلاق الحوار
              Navigator.pop(context); // رجوع للشاشة السابقة
            },
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
            const Icon(Icons.home, color: Colors.red, size: 40),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('العقار: ${widget.propertyName}',
                      style: const TextStyle(fontSize: 16)),
                  Text('رسوم الحذف: \$${widget.deleteFee}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
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
        if (value.replaceAll(' ', '').length < 16) {
          return 'رقم البطاقة يجب أن يكون 16 رقمًا';
        }
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
        if (value == null || value.isEmpty) {
          return 'الرجاء إدخال تاريخ الانتهاء';
        }
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
            _buildSummaryRow('العقار', widget.propertyName),
            _buildSummaryRow('رسوم الحذف', '\$${totalPrice.toStringAsFixed(2)}',
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

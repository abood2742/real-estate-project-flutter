import 'dart:io' as io;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:property_system/client/models/property_model.dart';

class CompleteReservationTransactionPage extends StatefulWidget {
  final PropertyModel propertyModel;
  const CompleteReservationTransactionPage(
      {super.key, required this.propertyModel});

  @override
  State<CompleteReservationTransactionPage> createState() =>
      _CompleteReservationTransactionPageState();
}

class _CompleteReservationTransactionPageState
    extends State<CompleteReservationTransactionPage> {
  final TextEditingController _sellerAccountController =
      TextEditingController();
  final TextEditingController _sellerIdController = TextEditingController();
  final TextEditingController _buyerAccountController = TextEditingController();
  final TextEditingController _buyerIdController = TextEditingController();

  Uint8List? _uploadedImageBytes; // للويب
  io.File? _uploadedImageFile; // للهاتف
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickDocument() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      if (kIsWeb) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _uploadedImageBytes = bytes;
          _uploadedImageFile = null;
        });
      } else {
        setState(() {
          _uploadedImageFile = io.File(pickedFile.path);
          _uploadedImageBytes = null;
        });
      }
    }
  }

  void _confirmTransaction() {
    if (_sellerAccountController.text.trim().isEmpty ||
        _sellerIdController.text.trim().isEmpty ||
        _buyerAccountController.text.trim().isEmpty ||
        _buyerIdController.text.trim().isEmpty ||
        (_uploadedImageBytes == null && _uploadedImageFile == null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("يرجى إدخال جميع البيانات ورفع الوثائق"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    String type =
        widget.propertyModel.typeOperation == "selling"
            ? "البيع"
            : "الإيجار";

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("تم تأكيد عملية $type بنجاح"),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String typeLabel;
    String ownerTextFieldHint;
    String clientTextFieldHint;

    if (widget.propertyModel.typeOperation == "selling") {
      typeLabel = "بيع العقار";
      ownerTextFieldHint = "البائع";
      clientTextFieldHint = "المشتري";
    } else {
      typeLabel = "الإيجار";
      ownerTextFieldHint = "المؤجر";
      clientTextFieldHint = "المستأجر";
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        backgroundColor: const Color.fromARGB(255, 63, 22, 97),
        title: Text(
          'تأكيد عملية $typeLabel',
          style: const TextStyle(color: Colors.white, fontFamily: 'Pacifico'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField("حساب $ownerTextFieldHint", _sellerAccountController),
            const SizedBox(height: 16),
            _buildTextField("رقم هوية $ownerTextFieldHint", _sellerIdController,
                isNumber: true),
            const SizedBox(height: 16),
            _buildTextField("حساب $clientTextFieldHint", _buyerAccountController),
            const SizedBox(height: 16),
            _buildTextField("رقم هوية $clientTextFieldHint", _buyerIdController,
                isNumber: true),
            const SizedBox(height: 24),

            // زر رفع الوثائق مثل صفحة إدخال البيانات
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton(
                    mini: true,
                    onPressed: _pickDocument,
                    backgroundColor: Colors.deepPurple,
                    child: const Icon(Icons.add),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'رفع وثيقة العملية',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            if (_uploadedImageBytes != null)
              Image.memory(_uploadedImageBytes!, height: 150, fit: BoxFit.cover)
            else if (_uploadedImageFile != null)
              Image.file(_uploadedImageFile!, height: 150, fit: BoxFit.cover)
            else
              const Text("لم يتم اختيار ملف"),

            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 12, 164, 164),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _confirmTransaction,
                    child: Text(
                      "تأكيد $typeLabel",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "رجوع",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool isNumber = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
    );
  }
}

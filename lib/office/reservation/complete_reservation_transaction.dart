import 'dart:io' as io;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:property_system/client/models/property_model.dart';
import 'package:property_system/client/services/property_request_service.dart';

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
  // Record DTO controllers
  final TextEditingController _ownerIdController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _clientIdController = TextEditingController();
  final TextEditingController _clientNameController = TextEditingController();

  DateTime? _sellDate;
  DateTime? _rentalStartDate;
  DateTime? _rentalEndDate;

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

  Future<void> _pickDate(BuildContext context, bool isSellDate,
      {bool isStart = false}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isSellDate) {
          _sellDate = picked;
        } else {
          if (isStart) {
            _rentalStartDate = picked;
          } else {
            _rentalEndDate = picked;
          }
        }
      });
    }
  }

  void _confirmTransaction(PropertyModel propertyModel) async {
    if (_ownerIdController.text.trim().isEmpty ||
        _ownerNameController.text.trim().isEmpty ||
        _clientIdController.text.trim().isEmpty ||
        _clientNameController.text.trim().isEmpty ||
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
        widget.propertyModel.typeOperation == "selling" ? "selling" : "renting";

    print(_sellDate);
    print(_rentalEndDate);
    print(_rentalStartDate);

    await PropertyRequestService().sendPropertyRequest(
        property_Number: propertyModel.propertyNumber,
        propertyType: propertyModel.propertyType.name,
        typeOfPropertyType: propertyModel.propertyType.type,
        space: propertyModel.space.toString(),
        location_Id: propertyModel.location.id,
        owner_personal_Identity_Number: int.parse(_ownerIdController.text),
        owner_name: _ownerNameController.text,
        client_personal_Identity_Number: int.parse(_clientIdController.text),
        client_name: _clientNameController.text,
        price: double.parse(propertyModel.price),
        type: type,
        sell_Date: _sellDate,
        rental_End_Date: _rentalEndDate,
        rental_Start_Date: _rentalStartDate);

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
    String ownerLabel;
    String clientLabel;

    if (widget.propertyModel.typeOperation == "selling") {
      typeLabel = "بيع العقار";
      ownerLabel = "البائع";
      clientLabel = "المشتري";
    } else {
      typeLabel = "الإيجار";
      ownerLabel = "المؤجر";
      clientLabel = "المستأجر";
    }

    final location = widget.propertyModel.location;

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
          children: [
            // --- Property Details Card ---
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("تفاصيل العقار",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const Divider(),
                    _buildInfoRow(
                        "رقم العقار", widget.propertyModel.propertyNumber),
                    _buildInfoRow(
                        "نوع العقار", widget.propertyModel.propertyType.name),
                    _buildInfoRow(
                        "تفصيل النوع", widget.propertyModel.propertyType.type),
                    _buildInfoRow(
                        "المساحة", widget.propertyModel.space.toString()),
                    _buildInfoRow("السعر", widget.propertyModel.price),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // --- Location Card ---
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("تفاصيل الموقع",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const Divider(),
                    _buildInfoRow("المحافظة", location.governorate),
                    _buildInfoRow("المنطقة", location.province),
                    _buildInfoRow("المدينة", location.city),
                    _buildInfoRow("الشارع", location.street),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // --- Record DTO inputs ---
            _buildInputField("رقم هوية $ownerLabel", _ownerIdController,
                isNumber: true),
            const SizedBox(height: 16),
            _buildInputField("اسم $ownerLabel", _ownerNameController),
            const SizedBox(height: 16),
            _buildInputField("رقم هوية $clientLabel", _clientIdController,
                isNumber: true),
            const SizedBox(height: 16),
            _buildInputField("اسم $clientLabel", _clientNameController),
            const SizedBox(height: 24),

            // --- Date pickers ---
            if (widget.propertyModel.typeOperation == "selling")
              ElevatedButton(
                onPressed: () => _pickDate(context, true),
                child: Text(_sellDate == null
                    ? "تحديد تاريخ البيع"
                    : "تاريخ البيع: ${_sellDate!.toLocal()}".split(' ')[0]),
              )
            else
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () => _pickDate(context, false, isStart: true),
                    child: Text(_rentalStartDate == null
                        ? "تحديد تاريخ بداية الإيجار"
                        : "بداية: ${_rentalStartDate!.toLocal()}"
                            .split(' ')[0]),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => _pickDate(context, false, isStart: false),
                    child: Text(_rentalEndDate == null
                        ? "تحديد تاريخ نهاية الإيجار"
                        : "نهاية: ${_rentalEndDate!.toLocal()}".split(' ')[0]),
                  ),
                ],
              ),

            const SizedBox(height: 24),

            // --- Document Upload ---
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
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

            // --- Action Buttons ---
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
                    onPressed: () {
                      _confirmTransaction(widget.propertyModel);
                    },
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

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Text(label,
                  style: const TextStyle(fontWeight: FontWeight.w600))),
          Expanded(
              flex: 3,
              child:
                  Text(value, style: const TextStyle(color: Colors.black87))),
        ],
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller,
      {bool isNumber = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
    );
  }
}

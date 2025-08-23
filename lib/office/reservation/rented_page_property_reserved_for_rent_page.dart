import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class RentedPagePropertyReservedForRentPage extends StatefulWidget {
  const RentedPagePropertyReservedForRentPage({super.key});

  @override
  State<RentedPagePropertyReservedForRentPage> createState() =>
      _PropertyReservedForSellPageState();
}

class _PropertyReservedForSellPageState
    extends State<RentedPagePropertyReservedForRentPage> {
  final TextEditingController _buyerAccountController = TextEditingController();
  final TextEditingController _buyerIdController = TextEditingController();
  String? uploadedFile;

  Future<void> _pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        uploadedFile = result.files.single.name;
      });
    }
  }

  void _confirmSale() {
    String account = _buyerAccountController.text.trim();
    String id = _buyerIdController.text.trim();

    if (account.isEmpty || id.isEmpty || uploadedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("يرجى إدخال جميع البيانات ورفع الوثائق"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("تم تأكيد بيع العقار للمشتري: $account"),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        backgroundColor: const Color.fromARGB(255, 63, 22, 97),
        title: const Text(
          ' تأكيد عملية الإيجار ',
          style: TextStyle(color: Colors.white, fontFamily: 'Pacifico'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _buyerAccountController,
              decoration: const InputDecoration(
                labelText: "حساب المؤجر",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _buyerIdController,
              decoration: const InputDecoration(
                labelText: "رقم هوية المؤجر",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _buyerAccountController,
              decoration: const InputDecoration(
                labelText: "حساب المستأجر",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _buyerIdController,
              decoration: const InputDecoration(
                labelText: "رقم هوية المستأجر",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _pickDocument,
              icon: const Icon(Icons.upload_file),
              label: const Text("رفع وثيقة الإيجار"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
            ),
            if (uploadedFile != null) ...[
              const SizedBox(height: 8),
              Text("تم رفع الملف: $uploadedFile",style: TextStyle(color: Colors.blue,fontFamily: 'Pacifico'),),
            ],
            SizedBox(height: 200,),
          
            Row(
  children: [
    Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 12, 164, 164),
          padding: const EdgeInsets.symmetric(vertical: 16), // عشان يكون أطول
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text(
          "تأكيد الإيجار",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text(
          "رجوع",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
}

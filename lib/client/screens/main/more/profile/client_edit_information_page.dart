
import 'dart:io' as io;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:property_system/client/components/Custom_textField.dart';
import 'package:property_system/client/components/custom_button.dart';
import 'package:property_system/client/models/client_info_model.dart';
import 'package:property_system/client/services/client_update_service.dart';

class ClientEditInformationPage extends StatefulWidget {
  final ClientInfoModel? clientInfo;

  const ClientEditInformationPage({super.key, this.clientInfo});

  @override
  State<ClientEditInformationPage> createState() =>
      _ClientEditInformationPageState();
}

class _ClientEditInformationPageState extends State<ClientEditInformationPage> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController receiverIdentifierController;

  Uint8List? _profileImageBytes; // للويب
  io.File? _profileImageFile; // للموبايل
  final ImagePicker _picker = ImagePicker();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    firstNameController =
        TextEditingController(text: widget.clientInfo?.firstName ?? '');
    lastNameController =
        TextEditingController(text: widget.clientInfo?.lastName ?? '');
    receiverIdentifierController =
        TextEditingController(text: widget.clientInfo?.receiverIdentifier ?? '');
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    receiverIdentifierController.dispose();
    super.dispose();
  }

  Future<void> _uploadProfilePhoto() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      if (kIsWeb) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _profileImageBytes = bytes;
          _profileImageFile = null;
        });
      } else {
        setState(() {
          _profileImageFile = io.File(pickedFile.path);
          _profileImageBytes = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        appBar: AppBar(
          elevation: 3,
          centerTitle: true,
          title: const Text(
            'تعديل البيانات',
            style: TextStyle(color: Colors.green, fontFamily: 'Pacifico'),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                CustomTextField(
                  controller: firstNameController,
                  hintText: 'الاسم الأول', suffixIcon: null,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: lastNameController,
                  hintText: 'الاسم الأخير', suffixIcon: null,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: receiverIdentifierController,
                  hintText: 'رقم المعرّف',
                  inputType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FloatingActionButton(
                      heroTag: 'btnProfile',
                      mini: true,
                      onPressed: _uploadProfilePhoto,
                      backgroundColor: Colors.blue,
                      child: const Icon(Icons.add_a_photo),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Upload Profile Photo',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                if (_profileImageBytes != null) // للويب
                  Image.memory(_profileImageBytes!, height: 150, fit: BoxFit.cover)
                else if (_profileImageFile != null) // للموبايل
                  Image.file(_profileImageFile!, height: 150, fit: BoxFit.cover)
                else
                  const Text('لم يتم اختيار صورة'),
                const SizedBox(height: 50),
                CustomButon(
                  text: 'تعديل',
                  onTap: () async {
                    if (firstNameController.text.trim().isEmpty &&
                        lastNameController.text.trim().isEmpty &&
                        receiverIdentifierController.text.trim().isEmpty &&
                        _profileImageBytes == null &&
                        _profileImageFile == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('الرجاء إدخال بيانات أو اختيار صورة للتعديل')),
                      );
                      return;
                    }

                    setState(() => isLoading = true);
                    try {
                      dynamic profilePhotoData;
                      if (!kIsWeb && _profileImageFile != null) {
                        profilePhotoData = _profileImageFile;
                      } else if (kIsWeb && _profileImageBytes != null) {
                        profilePhotoData = _profileImageBytes;
                      } else {
                        profilePhotoData = null;
                      }

                      final updatedModel =
                          await UpdateProductService().updateClientInfo(
                        firstName: firstNameController.text.trim().isEmpty
                            ? widget.clientInfo?.firstName ?? ''
                            : firstNameController.text.trim(),
                        lastName: lastNameController.text.trim().isEmpty
                            ? widget.clientInfo?.lastName ?? ''
                            : lastNameController.text.trim(),
                        receiverIdentifier:
                            receiverIdentifierController.text.trim().isEmpty
                                ? widget.clientInfo?.receiverIdentifier ?? ''
                                : receiverIdentifierController.text.trim(),
                        profilePhoto: profilePhotoData,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('تم تحديث البيانات بنجاح')),
                      );

                      Navigator.pop(context, updatedModel);
                    } catch (e) {
                      print('خطأ: $e');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('حدث خطأ: $e')),
                      );
                    } finally {
                      setState(() => isLoading = false);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

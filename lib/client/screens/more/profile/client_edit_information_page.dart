import 'dart:math';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:property_system/client/components/Custom_textField.dart';
import 'package:property_system/client/components/custom_button.dart';
import 'package:property_system/client/models/client_info_model.dart';
import 'package:property_system/client/services/client_update_service.dart';

class ClientEditInformationPage extends StatefulWidget {
  final ClientInfoModel? clientInfo; // جعلها اختيارية بإضافة ?

  const ClientEditInformationPage({super.key, this.clientInfo}); // إزالة required

  @override
  State<ClientEditInformationPage> createState() =>
      _ClientEditInformationPageState();
}

class _ClientEditInformationPageState extends State<ClientEditInformationPage> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController receiverIdentifierController;
  late TextEditingController profilePhotoController;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // تهيئة المتحكمات مع القيم الافتراضية إذا كانت clientInfo فارغة
    firstNameController = TextEditingController(
        text: widget.clientInfo?.firstName ?? '');
    lastNameController = TextEditingController(
        text: widget.clientInfo?.lastName ?? '');
    receiverIdentifierController = TextEditingController(
        text: widget.clientInfo?.receiverIdentifier ?? '');
    profilePhotoController = TextEditingController(
        text: widget.clientInfo?.profilePhoto ?? '');
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    receiverIdentifierController.dispose();
    profilePhotoController.dispose();
    super.dispose();
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
                const SizedBox(height: 100),
                CustomTextField(
                  controller: firstNameController,
                  hintText: 'الاسم الأول',
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: lastNameController,
                  hintText: 'الاسم الأخير',
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: receiverIdentifierController,
                  hintText: 'رقم المعرّف',
                  inputType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: profilePhotoController,
                  hintText: 'رابط الصورة',
                ),
                const SizedBox(height: 70),
                CustomButon(
                  text: 'تعديل',
                  onTap: () async {
                    if (widget.clientInfo == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('لا توجد بيانات للتعديل')),
                      );
                      return;
                    }

                    setState(() => isLoading = true);
                    try {
                      final updatedModel = await UpdateProductService().updateClientInfo(
                        firstName: firstNameController.text.trim().isEmpty
                            ? widget.clientInfo!.firstName
                            : firstNameController.text.trim(),
                        lastName: lastNameController.text.trim().isEmpty
                            ? widget.clientInfo!.lastName
                            : lastNameController.text.trim(),
                        receiverIdentifier:
                            receiverIdentifierController.text.trim().isEmpty
                                ? widget.clientInfo!.receiverIdentifier
                                : receiverIdentifierController.text.trim(),
                        profilePhoto: profilePhotoController.text.trim().isEmpty
                            ? widget.clientInfo!.profilePhoto
                            : profilePhotoController.text.trim(),
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
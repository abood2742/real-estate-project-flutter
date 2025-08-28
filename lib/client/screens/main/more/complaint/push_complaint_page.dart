
import 'dart:io' as io;
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:property_system/client/components/custom_button.dart';
import 'package:property_system/client/models/complaient/create_office_complainet_model.dart';
import 'package:property_system/client/services/complainet_office_service.dart';
import 'package:property_system/l10n/app_localizations.dart';

class PushComplaintPage extends StatefulWidget {
  final String officeId;

  const PushComplaintPage({Key? key, required this.officeId}) : super(key: key);


  @override
  _PushComplaintPageState createState() => _PushComplaintPageState();
}

class _PushComplaintPageState extends State<PushComplaintPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final ComplaintService _complaintService = ComplaintService();

  List<Uint8List> _webImages = [];
  List<io.File> _mobileImages = [];
  bool _isLoading = false;

  Future<void> _pickImages() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      for (var pickedFile in pickedFiles) {
        if (kIsWeb) {
          final bytes = await pickedFile.readAsBytes();
          setState(() {
            _webImages.add(bytes);
          });
        } else {
          setState(() {
            _mobileImages.add(io.File(pickedFile.path));
          });
        }
      }
    }
  }

  void _removeImage(int index, {bool isWeb = false}) {
    setState(() {
      if (isWeb) {
        _webImages.removeAt(index);
      } else {
        _mobileImages.removeAt(index);
      }
    });
  }

  Future<void> _submitComplaint() async {
    if (titleController.text.isEmpty) {
      _showSnack('يرجى إدخال عنوان للشكوى', const Color.fromARGB(255, 152, 54, 244));
      return;
    }

    if (descriptionController.text.isEmpty) {
      _showSnack('يرجى إدخال محتوى الشكوى', const Color.fromARGB(255, 152, 54, 244));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // TODO: رفع الصور للسيرفر أولاً ثم إضافة روابطها هنا
      List<String> mediaUrls = [];

      final complaint = CreateOfficeComplainetModel(
        officeId: widget.officeId,
        title: titleController.text,
        content: descriptionController.text,
        complaintMedia: mediaUrls,
      );
      print('1');

      await _complaintService.createComplaint(complaint);

      _showSnack('تم إرسال الشكوى بنجاح', Colors.green);

      Navigator.pop(context);
    } catch (e) {
      _showSnack('فشل إرسال الشكوى: $e', Colors.red);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showSnack(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Color.fromARGB(255, 121, 255, 224),
          title: Text(
            localizations.translate('submit_complaint'),
            style: const TextStyle(
                color: Colors.white, fontFamily: 'Pacifico', fontSize: 20),
          ),
          backgroundColor: const Color.fromARGB(255, 121, 255, 224),
          centerTitle: true,
          elevation: 2,
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      localizations.translate('complaint_reason'),
                      style: const TextStyle(
                          fontFamily: 'Pacifico',
                          fontSize: 20,
                          color: Color.fromARGB(255, 83, 54, 155)),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: titleController,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'أدخل سبب الشكوى',
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      localizations.translate('complaint_description'),
                      style: const TextStyle(
                          fontFamily: 'Pacifico', color: Colors.blueAccent),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: descriptionController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: localizations
                            .translate('write_complaint_details'),
                      ),
                    ),
                    const SizedBox(height: 24),

                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        for (int i = 0; i < _webImages.length; i++)
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.memory(
                                  _webImages[i],
                                  height: 110,
                                  width: 110,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 4,
                                right: 4,
                                child: GestureDetector(
                                  onTap: () => _removeImage(i, isWeb: true),
                                  child: _removeButton(),
                                ),
                              ),
                            ],
                          ),
                        for (int i = 0; i < _mobileImages.length; i++)
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.file(
                                  _mobileImages[i],
                                  height: 110,
                                  width: 110,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 4,
                                right: 4,
                                child: GestureDetector(
                                  onTap: () => _removeImage(i),
                                  child: _removeButton(),
                                ),
                              ),
                            ],
                          ),
                        GestureDetector(
                          onTap: _pickImages,
                          child: Container(
                            height: 110,
                            width: 110,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: theme.colorScheme.primary.withOpacity(.1),
                            ),
                            child: const Center(
                              child: Icon(Icons.add_photo_alternate_outlined,
                                  size: 32),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              height: 60,
                              child: const Center(
                                child: Text(
                                  'إلغاء الشكوى',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomButon(
                            text: 'إرسال الشكوى',
                            onTap: _submitComplaint,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _removeButton() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black45,
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(4),
      child: const Icon(
        Icons.close,
        size: 18,
        color: Colors.white,
      ),
    );
  }
}
// import 'dart:io' as io;
// import 'dart:typed_data';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:property_system/client/components/custom_button.dart';
// import 'package:property_system/client/models/complaient/create_office_complainet_model.dart';
// import 'package:property_system/client/services/complainet_office_service.dart';
// import 'package:property_system/l10n/app_localizations.dart';

// class PushComplaintPage extends StatefulWidget {
//   final String officeId;

//   const PushComplaintPage({Key? key, required this.officeId}) : super(key: key);

//   @override
//   _PushComplaintPageState createState() => _PushComplaintPageState();
// }

// class _PushComplaintPageState extends State<PushComplaintPage> {
//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   final ImagePicker _picker = ImagePicker();
//   final ComplaintService _complaintService = ComplaintService();

//   List<Uint8List> _webImages = [];
//   List<io.File> _mobileImages = [];
//   bool _isLoading = false;

//   // اختيار الصور
//   Future<void> _pickImages() async {
//     final List<XFile>? pickedFiles = await _picker.pickMultiImage();
//     if (pickedFiles != null && pickedFiles.isNotEmpty) {
//       if (kIsWeb) {
//         List<Uint8List> webImages = [];
//         for (var file in pickedFiles) {
//           final bytes = await file.readAsBytes();
//           webImages.add(bytes);
//         }
//         setState(() {
//           _webImages = webImages;
//           _mobileImages.clear();
//         });
//       } else {
//         List<io.File> mobileFiles =
//             pickedFiles.map((f) => io.File(f.path)).toList();
//         setState(() {
//           _mobileImages = mobileFiles;
//           _webImages.clear();
//         });
//       }
//     }
//   }

//   // إزالة الصور
//   void _removeImage(int index, {bool isWeb = false}) {
//     setState(() {
//       if (isWeb) {
//         _webImages.removeAt(index);
//       } else {
//         _mobileImages.removeAt(index);
//       }
//     });
//   }

//   Future<void> _submitComplaint() async {
//     if (titleController.text.isEmpty) {
//       _showSnack('يرجى إدخال عنوان للشكوى', const Color.fromARGB(255, 152, 54, 244));
//       return;
//     }

//     if (descriptionController.text.isEmpty) {
//       _showSnack('يرجى إدخال محتوى الشكوى', const Color.fromARGB(255, 152, 54, 244));
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       // TODO: رفع الصور للسيرفر أولاً ثم إضافة روابطها هنا
//       List<String> mediaUrls = [];

//       final complaint = CreateOfficeComplainetModel(
//         officeId: widget.officeId,
//         title: titleController.text,
//         content: descriptionController.text,
//         complaintMedia: mediaUrls,
//       );

//       await _complaintService.createComplaint(complaint);

//       _showSnack('تم إرسال الشكوى بنجاح', Colors.green);
//       Navigator.pop(context);
//     } catch (e) {
//       _showSnack('فشل إرسال الشكوى: $e', Colors.red);
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   void _showSnack(String message, Color color) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message), backgroundColor: color),
//     );
//   }

//   Widget _removeButton() {
//     return Container(
//       decoration: const BoxDecoration(
//         color: Colors.black45,
//         shape: BoxShape.circle,
//       ),
//       padding: const EdgeInsets.all(4),
//       child: const Icon(
//         Icons.close,
//         size: 18,
//         color: Colors.white,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final localizations = AppLocalizations.of(context)!;
//     final theme = Theme.of(context);

//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         appBar: AppBar(
//           shadowColor: const Color.fromARGB(255, 121, 255, 224),
//           title: Text(
//             localizations.translate('submit_complaint'),
//             style: const TextStyle(
//                 color: Colors.white, fontFamily: 'Pacifico', fontSize: 20),
//           ),
//           backgroundColor: const Color.fromARGB(255, 121, 255, 224),
//           centerTitle: true,
//           elevation: 2,
//         ),
//         body: _isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: ListView(
//                   children: [
//                     const SizedBox(height: 16),
//                     Text(
//                       localizations.translate('complaint_reason'),
//                       style: const TextStyle(
//                           fontFamily: 'Pacifico',
//                           fontSize: 20,
//                           color: Color.fromARGB(255, 83, 54, 155)),
//                     ),
//                     const SizedBox(height: 24),
//                     TextField(
//                       controller: titleController,
//                       style: const TextStyle(color: Colors.black),
//                       decoration: InputDecoration(
//                         hintText: 'أدخل سبب الشكوى',
//                         hintStyle: const TextStyle(color: Colors.grey),
//                         filled: true,
//                         fillColor: Colors.grey[200],
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Text(
//                       localizations.translate('complaint_description'),
//                       style: const TextStyle(
//                           fontFamily: 'Pacifico', color: Colors.blueAccent),
//                     ),
//                     const SizedBox(height: 16),
//                     TextField(
//                       controller: descriptionController,
//                       maxLines: 4,
//                       decoration: InputDecoration(
//                         border: const OutlineInputBorder(),
//                         hintText: localizations
//                             .translate('write_complaint_details'),
//                       ),
//                     ),
//                     const SizedBox(height: 24),
//                     // عرض الصور
//                     Wrap(
//                       spacing: 12,
//                       runSpacing: 12,
//                       children: [
//                         if (_webImages.isNotEmpty)
//                           for (int i = 0; i < _webImages.length; i++)
//                             Stack(
//                               children: [
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(16),
//                                   child: Image.memory(
//                                     _webImages[i],
//                                     height: 110,
//                                     width: 110,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                                 Positioned(
//                                   top: 4,
//                                   right: 4,
//                                   child: GestureDetector(
//                                     onTap: () => _removeImage(i, isWeb: true),
//                                     child: _removeButton(),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                         if (_mobileImages.isNotEmpty)
//                           for (int i = 0; i < _mobileImages.length; i++)
//                             Stack(
//                               children: [
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(16),
//                                   child: Image.file(
//                                     _mobileImages[i],
//                                     height: 110,
//                                     width: 110,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                                 Positioned(
//                                   top: 4,
//                                   right: 4,
//                                   child: GestureDetector(
//                                     onTap: () => _removeImage(i),
//                                     child: _removeButton(),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                         GestureDetector(
//                           onTap: _pickImages,
//                           child: Container(
//                             height: 110,
//                             width: 110,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(16),
//                               color: theme.colorScheme.primary.withOpacity(.1),
//                             ),
//                             child: const Center(
//                               child: Icon(Icons.add_photo_alternate_outlined,
//                                   size: 32),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 24),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: GestureDetector(
//                             onTap: () => Navigator.pop(context),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.grey,
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               height: 60,
//                               child: const Center(
//                                 child: Text(
//                                   'إلغاء الشكوى',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: CustomButon(
//                             text: 'إرسال الشكوى',
//                             onTap: _submitComplaint,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//       ),
//     );
//   }
// }

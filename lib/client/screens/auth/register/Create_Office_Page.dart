// import 'dart:io' as io;

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:property_system/client/screens/auth/login/login_page.dart';
// import 'package:property_system/client/screens/auth/register/waiting_office_creation_aproval_Page.dart';
// import 'package:property_system/client/services/register_service.dart';

// class CreateOfficePage extends StatefulWidget {
//   const CreateOfficePage({super.key});

//   @override
//   State<CreateOfficePage> createState() => _CreateOfficePageState();
// }

// class _CreateOfficePageState extends State<CreateOfficePage> {
//   final _formKey = GlobalKey<FormState>(); // مفتاح الفورم

//   final TextEditingController _OfficeNameController = TextEditingController();
//   final TextEditingController _Office_Email_Controller = TextEditingController();
//   final TextEditingController _OfficePhoneController = TextEditingController();
//   final TextEditingController _LicenseNumberController = TextEditingController();
//   final TextEditingController _Personal_Identity_Number_Controller = TextEditingController();

//   Uint8List? _OfficeImageBytes; // للويب
//   io.File? _OfficeImageFile; // للهاتف

//   Uint8List? _LicenseImageBytes; // للويب
//   io.File? _LicenseImageFile; // للهاتف

//   final ImagePicker _picker = ImagePicker();

//   bool _isLoading = false; // حالة التحميل

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white, // خلفية بيضاء ناعمة
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: const Text(
//           'تسجيل كمكتب عقاري',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//         elevation: 2,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Form(  // تغليف الحقول داخل Form
//             key: _formKey,
//             child: Column(
//               children: [
//                 const SizedBox(height: 30),
//                 const Center(
//                   child: Text(
//                     'Enter this information',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.blueGrey,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 _buildTextFormField(
//                   'Office Name', 
//                   TextInputType.name, 
//                   _OfficeNameController,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'الرجاء إدخال اسم المكتب';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 _buildTextFormField(
//                   'Email', 
//                   TextInputType.emailAddress, 
//                   _Office_Email_Controller,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'الرجاء إدخال البريد الإلكتروني';
//                     }
//                     // تحقق بسيط من صيغة الإيميل
//                     if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
//                       return 'صيغة البريد الإلكتروني غير صحيحة';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 _buildTextFormField(
//                   'Phone Number', 
//                   TextInputType.phone, 
//                   _OfficePhoneController,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'الرجاء إدخال رقم الهاتف';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 _buildTextFormField(
//                   'Personal Identity Number', 
//                   TextInputType.text, 
//                   _Personal_Identity_Number_Controller,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'الرجاء إدخال رقم الهوية الشخصية';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 _buildTextFormField(
//                   'License Number', 
//                   TextInputType.number, 
//                   _LicenseNumberController,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'الرجاء إدخال رقم الرخصة';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 20),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           FloatingActionButton(
//                             heroTag: 'btn1',
//                             mini: true,
//                             onPressed: _UploadOfficePhoto,
//                             backgroundColor: Colors.blue,
//                             child: const Icon(Icons.add),
//                           ),
//                           const SizedBox(width: 8),
//                           Text(
//                             'Upload Office Photo',
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.blueGrey[800],
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 16),
//                       if (_OfficeImageBytes != null) // على الويب
//                         Image.memory(
//                           _OfficeImageBytes!,
//                           height: 150,
//                           fit: BoxFit.cover,
//                         )
//                       else if (_OfficeImageFile != null) // على الهاتف
//                         Image.file(
//                           _OfficeImageFile!,
//                           height: 150,
//                           fit: BoxFit.cover,
//                         )
//                       else
//                         const Text('لم يتم اختيار صورة'),
//                       const SizedBox(height: 16),
//                       Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           FloatingActionButton(
//                             heroTag: 'btn2',
//                             mini: true,
//                             onPressed: _UploadLicensePhoto,
//                             backgroundColor: Colors.blue,
//                             child: const Icon(Icons.add),
//                           ),
//                           const SizedBox(width: 8),
//                           Text(
//                             'Upload License Photo',
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.blueGrey[800],
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ],
//                       ),
//                       if (_LicenseImageBytes != null) // على الويب
//                         Image.memory(
//                           _LicenseImageBytes!,
//                           height: 150,
//                           fit: BoxFit.cover,
//                         )
//                       else if (_LicenseImageFile != null) // على الهاتف
//                         Image.file(
//                           _LicenseImageFile!,
//                           height: 150,
//                           fit: BoxFit.cover,
//                         )
//                       else
//                         const Text('لم يتم اختيار صورة'),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 Center(
//                   child: ElevatedButton(
//                     onPressed: _isLoading ? null : () async {
//                       // تحقق من صحة الفورم أولاً
//                       if (!_formKey.currentState!.validate()) return;

//                       setState(() {
//                         _isLoading = true;
//                       });

//                       CreateOfficeResponce? status = await createOffice();

//                       setState(() {
//                         _isLoading = false;
//                       });

//                       if (status != null && status.statusCode) {
//                         // الانتقال لصفحة انتظار الموافقة مع الرسالة
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) => WaitingApprovalPage(message: status.message),
//                           ),
//                         );
//                       } else {
//                         final errorMsg = status?.message ?? 'حدث خطأ ما، حاول مجدداً';
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text(errorMsg)),
//                         );
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       backgroundColor: Colors.blue,
//                       elevation: 4,
//                     ),
//                     child: _isLoading
//                         ? const SizedBox(
//                             height: 20,
//                             width: 20,
//                             child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
//                           )
//                         : const Text(
//                             'Sign Up',
//                             style: TextStyle(
//                               fontSize: 18,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               letterSpacing: 1.2,
//                             ),
//                           ),
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       'You already have an account?',
//                       style: TextStyle(fontFamily: 'Pacifico'),
//                     ),
//                     const SizedBox(width: 10),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) {
//                           return LoginPage();
//                         }));
//                       },
//                       child: const Text(
//                         'Sign in',
//                         style: TextStyle(
//                           fontFamily: 'Pacifico',
//                           color: Color.fromARGB(255, 14, 18, 95),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 40),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // بديل TextField مع دعم validator للفورم
//   Widget _buildTextFormField(String label, TextInputType keyboardType,
//       TextEditingController controller,
//       {bool obscureText = false, String? Function(String?)? validator}) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       obscureText: obscureText,
//       validator: validator,
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: TextStyle(color: Colors.blueGrey[700]),
//         filled: true,
//         fillColor: Colors.grey[200],
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(color: Colors.blueGrey.shade200),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: const BorderSide(color: Colors.blue, width: 2),
//         ),
//       ),
//       cursorColor: Colors.blue,
//       style: TextStyle(color: Colors.blueGrey[900]),
//     );
//   }

//   Future<void> _UploadOfficePhoto() async {
//     final XFile? pickedFile =
//         await _picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       if (kIsWeb) {
//         final bytes = await pickedFile.readAsBytes();
//         setState(() {
//           _OfficeImageBytes = bytes;
//           _OfficeImageFile = null;
//         });
//       } else {
//         setState(() {
//           _OfficeImageFile = io.File(pickedFile.path);
//           _OfficeImageBytes = null;
//         });
//       }
//     }
//   }

//   Future<void> _UploadLicensePhoto() async {
//     final XFile? pickedFile =
//         await _picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       if (kIsWeb) {
//         final bytes = await pickedFile.readAsBytes();
//         setState(() {
//           _LicenseImageBytes = bytes;
//           _LicenseImageFile = null;
//         });
//       } else {
//         setState(() {
//           _LicenseImageFile = io.File(pickedFile.path);
//           _LicenseImageBytes = null;
//         });
//       }
//     }
//   }

//   Future<CreateOfficeResponce?> createOffice() async {
//     dynamic officePhotoData;
//     dynamic licensePhotoData;

//     if (!kIsWeb && _OfficeImageFile != null) {
//       officePhotoData = _OfficeImageFile;
//     } else if (kIsWeb && _OfficeImageBytes != null) {
//       officePhotoData = _OfficeImageBytes;
//     } else {
//       officePhotoData = null;
//     }

//     if (!kIsWeb && _LicenseImageFile != null) {
//       licensePhotoData = _LicenseImageFile;
//     } else if (kIsWeb && _LicenseImageBytes != null) {
//       licensePhotoData = _LicenseImageBytes;
//     } else {
//       licensePhotoData = null;
//     }

//     CreateOfficeResponce? status = await RegisterService().createOfficePost(
//       officeName: _OfficeNameController.text,
//       officeEmail: _Office_Email_Controller.text,
//       officePhone: _OfficePhoneController.text,
//       personalIdentityNumber: _Personal_Identity_Number_Controller.text,
//       licenseNumber: _LicenseNumberController.text,
//       officePhoto: officePhotoData,
//       licensePhoto: licensePhotoData,
//     );

//     return status;
//   }
// }
import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:property_system/client/screens/auth/login/login_page.dart';
import 'package:property_system/client/screens/auth/register/waiting_office_creation_aproval_Page.dart';
import 'package:property_system/client/services/register_service.dart';
import 'package:property_system/l10n/app_localizations.dart';

class CreateOfficePage extends StatefulWidget {
  const CreateOfficePage({super.key});

  @override
  State<CreateOfficePage> createState() => _CreateOfficePageState();
}

class _CreateOfficePageState extends State<CreateOfficePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _OfficeNameController = TextEditingController();
  final TextEditingController _Office_Email_Controller = TextEditingController();
  final TextEditingController _OfficePhoneController = TextEditingController();
  final TextEditingController _LicenseNumberController = TextEditingController();
  final TextEditingController _Personal_Identity_Number_Controller = TextEditingController();

  Uint8List? _OfficeImageBytes;
  io.File? _OfficeImageFile;

  Uint8List? _LicenseImageBytes;
  io.File? _LicenseImageFile;

  final ImagePicker _picker = ImagePicker();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          localizations.translate('register_as_office'),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 30),
                Center(
                  child: Text(
                    localizations.translate('enter_information'),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                _buildTextFormField(
                  localizations.translate('office_name'),
                  TextInputType.name,
                  _OfficeNameController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return localizations.translate('please_enter_office_name');
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextFormField(
                  localizations.translate('email'),
                  TextInputType.emailAddress,
                  _Office_Email_Controller,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return localizations.translate('please_enter_email');
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return localizations.translate('invalid_email_format');
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextFormField(
                  localizations.translate('phone_number'),
                  TextInputType.phone,
                  _OfficePhoneController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return localizations.translate('please_enter_phone_number');
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextFormField(
                  localizations.translate('personal_identity_number'),
                  TextInputType.text,
                  _Personal_Identity_Number_Controller,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return localizations.translate('please_enter_personal_identity_number');
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextFormField(
                  localizations.translate('license_number'),
                  TextInputType.number,
                  _LicenseNumberController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return localizations.translate('please_enter_license_number');
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FloatingActionButton(
                            heroTag: 'btn1',
                            mini: true,
                            onPressed: _UploadOfficePhoto,
                            backgroundColor: Colors.blue,
                            child: const Icon(Icons.add),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            localizations.translate('upload_office_photo'),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blueGrey[800],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      if (_OfficeImageBytes != null)
                        Image.memory(
                          _OfficeImageBytes!,
                          height: 150,
                          fit: BoxFit.cover,
                        )
                      else if (_OfficeImageFile != null)
                        Image.file(
                          _OfficeImageFile!,
                          height: 150,
                          fit: BoxFit.cover,
                        )
                      else
                        Text(localizations.translate('no_picture_selected')),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FloatingActionButton(
                            heroTag: 'btn2',
                            mini: true,
                            onPressed: _UploadLicensePhoto,
                            backgroundColor: Colors.blue,
                            child: const Icon(Icons.add),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            localizations.translate('upload_license_photo'),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blueGrey[800],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      if (_LicenseImageBytes != null)
                        Image.memory(
                          _LicenseImageBytes!,
                          height: 150,
                          fit: BoxFit.cover,
                        )
                      else if (_LicenseImageFile != null)
                        Image.file(
                          _LicenseImageFile!,
                          height: 150,
                          fit: BoxFit.cover,
                        )
                      else
                        Text(localizations.translate('no_picture_selected')),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () async {
                            if (!_formKey.currentState!.validate()) return;

                            setState(() {
                              _isLoading = true;
                            });

                            CreateOfficeResponce? status = await createOffice();

                            setState(() {
                              _isLoading = false;
                            });

                            if (status != null && status.statusCode) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => WaitingApprovalPage(message: status.message),
                                ),
                              );
                            } else {
                              final errorMsg = status?.message ??
                                  localizations.translate('generic_error_try_again');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(errorMsg)),
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.blue,
                      elevation: 4,
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          )
                        : Text(
                            localizations.translate('signup'),
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      localizations.translate('have_another_account'),
                      style: const TextStyle(fontFamily: 'Pacifico'),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const LoginPage();
                        }));
                      },
                      child: Text(
                        localizations.translate('login'),
                        style: const TextStyle(
                          fontFamily: 'Pacifico',
                          color: Color.fromARGB(255, 14, 18, 95),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(String label, TextInputType keyboardType,
      TextEditingController controller,
      {bool obscureText = false, String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.blueGrey[700]),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.blueGrey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
      ),
      cursorColor: Colors.blue,
      style: TextStyle(color: Colors.blueGrey[900]),
    );
  }

  Future<void> _UploadOfficePhoto() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      if (kIsWeb) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _OfficeImageBytes = bytes;
          _OfficeImageFile = null;
        });
      } else {
        setState(() {
          _OfficeImageFile = io.File(pickedFile.path);
          _OfficeImageBytes = null;
        });
      }
    }
  }

  Future<void> _UploadLicensePhoto() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      if (kIsWeb) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _LicenseImageBytes = bytes;
          _LicenseImageFile = null;
        });
      } else {
        setState(() {
          _LicenseImageFile = io.File(pickedFile.path);
          _LicenseImageBytes = null;
        });
      }
    }
  }

  Future<CreateOfficeResponce?> createOffice() async {
    dynamic officePhotoData;
    dynamic licensePhotoData;

    if (!kIsWeb && _OfficeImageFile != null) {
      officePhotoData = _OfficeImageFile;
    } else if (kIsWeb && _OfficeImageBytes != null) {
      officePhotoData = _OfficeImageBytes;
    } else {
      officePhotoData = null;
    }

    if (!kIsWeb && _LicenseImageFile != null) {
      licensePhotoData = _LicenseImageFile;
    } else if (kIsWeb && _LicenseImageBytes != null) {
      licensePhotoData = _LicenseImageBytes;
    } else {
      licensePhotoData = null;
    }

    CreateOfficeResponce? status = await RegisterService().createOfficePost(
      officeName: _OfficeNameController.text,
      officeEmail: _Office_Email_Controller.text,
      officePhone: _OfficePhoneController.text,
      personalIdentityNumber: _Personal_Identity_Number_Controller.text,
      licenseNumber: _LicenseNumberController.text,
      officePhoto: officePhotoData,
      licensePhoto: licensePhotoData,
    );

    return status;
  }
}
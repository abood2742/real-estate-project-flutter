// import 'dart:io' as io;

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// import 'package:property_system/client/screens/auth/login/login_page.dart';
// import 'package:property_system/client/screens/main/main_page.dart';
// import 'package:property_system/client/services/register_service.dart';

// class UserInfoEnterPage extends StatefulWidget {
//   const UserInfoEnterPage({super.key});

//   @override
//   _UserInfoEnterPageState createState() => _UserInfoEnterPageState();
// }

// class _UserInfoEnterPageState extends State<UserInfoEnterPage> {
//   // كود كتبه عمرclass _UserInfoEnterPageState extends State<UserInfoEnterPage> {
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _nationalNumberController =
//       TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _receiverIdentifierController =
//       TextEditingController();

//   Uint8List? _ProfileImageBytes; // للويب
//   io.File? _ProfileImageFile; // للهاتف

//   final ImagePicker _picker = ImagePicker();
//   bool isLoading = false; // ✅ أضفنا متغير التحميل

//   Future<void> _pickProfileImage() async {
//     final XFile? pickedFile =
//         await _picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       if (kIsWeb) {
//         // على الويب نقرأ الصورة كـ Uint8List
//         final bytes = await pickedFile.readAsBytes();
//         setState(() {
//           _ProfileImageBytes = bytes;
//           _ProfileImageFile = null;
//         });
//       } else {
//         // على الهاتف نستخدم File عادي
//         setState(() {
//           _ProfileImageFile = io.File(pickedFile.path);
//           _ProfileImageBytes = null;
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: const Text(
//           ' إدخال بيانتك ',
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
//           child: Column(
//             children: [
//               const SizedBox(height: 30),
//               const Center(
//                 child: Text(
//                   'أدخل معلوماتك',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.blueGrey,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 30),
//               _buildTextField(
//                   'First Name', TextInputType.name, _firstNameController),
//               const SizedBox(height: 30),
//               _buildTextField(
//                   'Last Name', TextInputType.name, _lastNameController),
//               const SizedBox(height: 16),
//               _buildTextField('National Number', TextInputType.text,
//                   _nationalNumberController),
//               const SizedBox(height: 30),
//               _buildTextField('receiver identifier', TextInputType.text,
//                   _receiverIdentifierController),
//               const SizedBox(height: 16),
//               _buildTextField(
//                   'Password', TextInputType.text, _passwordController,
//                   obscureText: true),
//               const SizedBox(height: 16),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     FloatingActionButton(
//                       mini: true,
//                       onPressed: _pickProfileImage,
//                       backgroundColor: Colors.blue,
//                       child: const Icon(Icons.add),
//                     ),
//                     const SizedBox(width: 8),
//                     Text(
//                       'رفع صورة لملفك الشخصي',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.blueGrey[800],
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 16),
//               if (_ProfileImageBytes != null) // على الويب
//                 Image.memory(
//                   _ProfileImageBytes!,
//                   height: 150,
//                   fit: BoxFit.cover,
//                 )
//               else if (_ProfileImageFile != null) // على الهاتف
//                 Image.file(
//                   _ProfileImageFile!,
//                   height: 150,
//                   fit: BoxFit.cover,
//                 )
//               else
//                 const Text('لم يتم اختيار صورة'),
//               const SizedBox(height: 30),
//               Center(
//                 child: isLoading
//                     ? const CircularProgressIndicator() // ✅ عند التحميل
//                     : ElevatedButton(
//                         onPressed: () async {
//                           setState(() {
//                             isLoading = true;
//                           });

//                           try {
//                             await enterInfo();
//                             Navigator.push(context,
//                                 MaterialPageRoute(builder: (context) {
//                               return MainPage();
//                             }));
//                           } catch (e) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(content: Text("حدث خطأ أثناء التسجيل")),
//                             );
//                           }

//                           setState(() {
//                             isLoading = false;
//                           });

//                           print('تم الضغط على Sign Up');
//                         },
//                         style: ElevatedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 70, vertical: 16),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           backgroundColor: Colors.blue,
//                           elevation: 4,
//                         ),
//                         child: const Text(
//                           'Sign Up',
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             letterSpacing: 1.2,
//                           ),
//                         ),
//                       ),
//               ),
//               const SizedBox(height: 30),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     'You already have an account?',
//                     style: TextStyle(fontFamily: 'Pacifico'),
//                   ),
//                   const SizedBox(width: 10),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) {
//                         return LoginPage();
//                       }));
//                     },
//                     child: const Text(
//                       'Sign in',
//                       style: TextStyle(
//                         fontFamily: 'Pacifico',
//                         color: Color.fromARGB(255, 14, 18, 95),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 40),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(String label, TextInputType keyboardType,
//       TextEditingController controller,
//       {bool obscureText = false}) {
//     return TextField(
//       controller: controller,
//       keyboardType: keyboardType,
//       obscureText: obscureText,
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

//   Future<void> enterInfo() async {
//     dynamic imageData;

//     if (!kIsWeb && _ProfileImageFile != null) {
//       imageData = _ProfileImageFile;
//     } else if (kIsWeb && _ProfileImageBytes != null) {
//       imageData = _ProfileImageBytes;
//     } else {
//       imageData = null;
//     }

//     await RegisterService().enterInfoPost(
//       firstName: _firstNameController.text,
//       lastName: _lastNameController.text,
//       nationalNumber: _nationalNumberController.text,
//       receiverIdentifier: _receiverIdentifierController.text,
//       password: _passwordController.text,
//       image: imageData, // هنا تمرر الصورة المختارة
//     );
//   }
// }
import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:property_system/client/screens/auth/login/login_page.dart';
import 'package:property_system/client/screens/main/main_page.dart';
import 'package:property_system/client/services/register_service.dart';
import 'package:property_system/l10n/app_localizations.dart';

class UserInfoEnterPage extends StatefulWidget {
  const UserInfoEnterPage({super.key});

  @override
  _UserInfoEnterPageState createState() => _UserInfoEnterPageState();
}

class _UserInfoEnterPageState extends State<UserInfoEnterPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _nationalNumberController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _receiverIdentifierController =
      TextEditingController();

  Uint8List? _ProfileImageBytes; // للويب
  io.File? _ProfileImageFile; // للهاتف

  final ImagePicker _picker = ImagePicker();
  bool isLoading = false;

  Future<void> _pickProfileImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      if (kIsWeb) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _ProfileImageBytes = bytes;
          _ProfileImageFile = null;
        });
      } else {
        setState(() {
          _ProfileImageFile = io.File(pickedFile.path);
          _ProfileImageBytes = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          localizations.translate('enter_your_data'),
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
          child: Column(
            children: [
              const SizedBox(height: 30),
              Center(
                child: Text(
                  localizations.translate('enter_your_info'),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              _buildTextField(
                  localizations.translate('first_name'),
                  TextInputType.name,
                  _firstNameController),
              const SizedBox(height: 30),
              _buildTextField(
                  localizations.translate('last_name'),
                  TextInputType.name,
                  _lastNameController),
              const SizedBox(height: 16),
              _buildTextField(localizations.translate('national_id'),
                  TextInputType.text, _nationalNumberController),
              const SizedBox(height: 30),
              _buildTextField(localizations.translate('receiver_identifier'),
                  TextInputType.text, _receiverIdentifierController),
              const SizedBox(height: 16),
              _buildTextField(localizations.translate('password'),
                  TextInputType.text, _passwordController,
                  obscureText: true),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FloatingActionButton(
                      mini: true,
                      onPressed: _pickProfileImage,
                      backgroundColor: Colors.blue,
                      child: const Icon(Icons.add),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      localizations.translate('upload_profile_picture'),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueGrey[800],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              if (_ProfileImageBytes != null)
                Image.memory(
                  _ProfileImageBytes!,
                  height: 150,
                  fit: BoxFit.cover,
                )
              else if (_ProfileImageFile != null)
                Image.file(
                  _ProfileImageFile!,
                  height: 150,
                  fit: BoxFit.cover,
                )
              else
                Text(localizations.translate('no_picture_selected')),
              const SizedBox(height: 30),
              Center(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });

                          try {
                            await enterInfo();
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const MainPage();
                            }));
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      localizations.translate('registration_error'))),
                            );
                          }

                          setState(() {
                            isLoading = false;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 70, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.blue,
                          elevation: 4,
                        ),
                        child: Text(
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
    );
  }

  Widget _buildTextField(String label, TextInputType keyboardType,
      TextEditingController controller,
      {bool obscureText = false}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
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

  Future<void> enterInfo() async {
    dynamic imageData;

    if (!kIsWeb && _ProfileImageFile != null) {
      imageData = _ProfileImageFile;
    } else if (kIsWeb && _ProfileImageBytes != null) {
      imageData = _ProfileImageBytes;
    } else {
      imageData = null;
    }

    await RegisterService().enterInfoPost(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      nationalNumber: _nationalNumberController.text,
      receiverIdentifier: _receiverIdentifierController.text,
      password: _passwordController.text,
      image: imageData,
    );
  }
}
/*

import 'package:flutter/material.dart';
import 'package:property_system/client/models/profile.model.dart';
import 'package:property_system/client/services/profile_service_done.dart';
import 'package:property_system/client/screens/main/more/profile/ching_password_profile_page.dart';
import 'package:property_system/client/screens/main/more/profile/client_edit_information_page.dart';
import 'package:property_system/l10n/app_localizations.dart';

class ClientProfile extends StatefulWidget {
  const ClientProfile({super.key});

  @override
  State<ClientProfile> createState() => _ClientProfileState();
}

class _ClientProfileState extends State<ClientProfile> {
  late ProfileModel? profileModel;
  var isLoading;
  var hasError;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });
    try {
      profileModel = await ProfileService().getProfile();
    } catch (e) {
      hasError = true;
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text(localizations.translate('profile'))),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (hasError || profileModel == null) {
      return Scaffold(
        appBar: AppBar(title: Text(localizations.translate('profile'))),
        body: Center(
          child: Column(
            children: [
              Text(
                localizations.translate('profile_load_error'),
                style: const TextStyle(fontSize: 18, color: Colors.red),
              ),
            ],
          ),
        ),
      );
    }

    final imageUrl = profileModel?.profilePhoto?.url;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 41, 47, 100),
        title: Row(
          children: [
            Text(
              localizations.translate('profile'),
              style:
                  const TextStyle(color: Colors.white, fontFamily: 'Pacifico'),
            ),
            const SizedBox(width: 40),
            const Text('🧾'),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: GestureDetector(
              onTap: () {
                if (imageUrl != null && imageUrl.isNotEmpty) {
                  showDialog(
                    context: context,
                    builder: (_) => Dialog(
                      backgroundColor: Colors.transparent,
                      insetPadding: const EdgeInsets.all(10),
                      child: InteractiveViewer(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/default_avatar.png',
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
              child: CircleAvatar(
                radius: 65,
                backgroundImage: imageUrl != null && imageUrl.isNotEmpty
                    ? NetworkImage(imageUrl)
                    : const AssetImage('assets/images/default_avatar.png')
                        as ImageProvider,
              ),
            ),
          ),
          const SizedBox(height: 24),
          _infoCard(
              title: localizations.translate('first_name'),
              value: profileModel!.firstName),
          _infoCard(
              title: localizations.translate('last_name'),
              value: profileModel!.lastName),
          _infoCard(
              title: localizations.translate('email'),
              value: profileModel!.email),
          _infoCard(
              title: localizations.translate('phone_number'),
              value: profileModel!.phone),
          _infoCard(
              title: localizations.translate('national_id'),
              value: profileModel!.nationalNumber),
          const SizedBox(height: 30),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const ClientEditInformationPage();
                  }));
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                label: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    localizations.translate('edit_data'),
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 41, 47, 100),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const ChingPasswordProfilePage();
                  }));
                },
                icon: const Icon(
                  Icons.key,
                  color: Colors.white,
                ),
                label: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  child: Text(
                    localizations.translate('change_password'),
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 75, 137, 163),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _infoCard({required String title, required String value}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Pacifico',
              color: Colors.blueAccent),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.black87,
              fontFamily: 'Pacifico',
            ),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}

*/
import 'package:flutter/material.dart';
import 'package:property_system/client/models/profile.model.dart';
import 'package:property_system/client/services/profile_service_done.dart';
import 'package:property_system/client/screens/main/more/profile/ching_password_profile_page.dart';
import 'package:property_system/client/screens/main/more/profile/client_edit_information_page.dart';
import 'package:property_system/l10n/app_localizations.dart';

class ClientProfile extends StatefulWidget {
  const ClientProfile({super.key});

  @override
  State<ClientProfile> createState() => _ClientProfileState();
}

class _ClientProfileState extends State<ClientProfile> {
  ProfileModel? profileModel;
  bool isLoading = false;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });
    try {
      profileModel = await ProfileService().getProfile();
    } catch (e) {
      setState(() {
        hasError = true;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            localizations.translate('profile'),
            style: const TextStyle(
              fontFamily: 'Pacifico',
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 41, 47, 100),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (hasError || profileModel == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            localizations.translate('profile'),
            style: const TextStyle(
              fontFamily: 'Pacifico',
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 41, 47, 100),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                localizations.translate('profile_load_error'),
                style: const TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 18,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: loadProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 41, 47, 100),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  localizations.translate('try_again'),
                  style: const TextStyle(
                    fontFamily: 'Pacifico',
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    final imageUrl = profileModel?.profilePhoto?.url;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 41, 47, 100),
        title: Row(
          children: [
            Text(
              localizations.translate('profile'),
              style: const TextStyle(
                fontFamily: 'Pacifico',
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            const SizedBox(width: 40),
            const Text('🧾'),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: GestureDetector(
              onTap: () {
                if (imageUrl != null && imageUrl.isNotEmpty) {
                  showDialog(
                    context: context,
                    builder: (_) => Dialog(
                      backgroundColor: Colors.transparent,
                      insetPadding: const EdgeInsets.all(10),
                      child: InteractiveViewer(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/default_avatar.png',
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
              child: CircleAvatar(
                radius: 65,
                backgroundImage: imageUrl != null && imageUrl.isNotEmpty
                    ? NetworkImage(imageUrl)
                    : const AssetImage('assets/images/default_avatar.png')
                        as ImageProvider,
              ),
            ),
          ),
          const SizedBox(height: 24),
          _infoCard(
            title: localizations.translate('first_name'),
            value: profileModel!.firstName,
          ),
          _infoCard(
            title: localizations.translate('last_name'),
            value: profileModel!.lastName,
          ),
          _infoCard(
            title: localizations.translate('email'),
            value: profileModel!.email,
          ),
          _infoCard(
            title: localizations.translate('phone_number'),
            value: profileModel!.phone,
          ),
          _infoCard(
            title: localizations.translate('national_id'),
            value: profileModel!.nationalNumber,
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ClientEditInformationPage(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                label: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    localizations.translate('edit_data'),
                    style: const TextStyle(
                      fontFamily: 'Pacifico',
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 41, 47, 100),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChingPasswordProfilePage(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.key,
                  color: Colors.white,
                ),
                label: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  child: Text(
                    localizations.translate('change_password'),
                    style: const TextStyle(
                      fontFamily: 'Pacifico',
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 75, 137, 163),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _infoCard({required String title, required String value}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Pacifico',
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            value,
            style: const TextStyle(
              fontFamily: 'Pacifico',
              color: Colors.black87,
            ),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}

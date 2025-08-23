import 'package:flutter/material.dart';
import 'package:property_system/client/models/profile.model.dart';
import 'package:property_system/client/services/user_profile.service.dart';
import 'package:property_system/l10n/app_localizations.dart';


class ClientReserverProfilePage extends StatefulWidget {
  final String userId;
  const ClientReserverProfilePage({super.key, required this.userId});

  @override
  State<ClientReserverProfilePage> createState() =>
      _ClientReserverProfilePageState();
}

class _ClientReserverProfilePageState extends State<ClientReserverProfilePage> {
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
      profileModel = await ProfileService().getUserById(userId: widget.userId);
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

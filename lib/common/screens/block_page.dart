import 'package:flutter/material.dart';
import 'package:property_system/client/screens/auth/login/login_page.dart';
import 'package:property_system/l10n/app_localizations.dart';

class BlockPage extends StatelessWidget {
  const BlockPage({
    super.key,
    required this.blockReason,
    required this.blockDate,
  });

  final String blockReason;
  final String blockDate;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 40),
            Text(
              localizations.translate('account_blocked_message'),
              style: const TextStyle(
                color: Color.fromARGB(255, 37, 33, 148),
                fontFamily: 'Pacifico',
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 100),
            Card(
              child: Container(
                height: 50,
                width: 110,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          Text(
                            localizations.translate('block_reason'),
                            style: const TextStyle(
                              color: Color.fromARGB(255, 42, 46, 42),
                              fontFamily: 'Pacifico',
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            blockReason,
                            style: const TextStyle(
                              color: Color.fromARGB(66, 5, 134, 63),
                              fontFamily: 'Pacifico',
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            Card(
              child: Container(
                height: 50,
                width: 300,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          Text(
                            localizations.translate('block_date'),
                            style: const TextStyle(
                              color: Color.fromARGB(255, 42, 46, 42),
                              fontFamily: 'Pacifico',
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            blockDate,
                            style: const TextStyle(
                              color: Color.fromARGB(66, 5, 134, 63),
                              fontFamily: 'Pacifico',
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 200),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 80, 86, 200),
                  borderRadius: BorderRadius.circular(16),
                ),
                height: 50,
                width: 300,
                child: Center(
                  child: Text(
                    localizations.translate('login_with_another_account'),
                    style: const TextStyle(
                      fontFamily: 'Pacifico',
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

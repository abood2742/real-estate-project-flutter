
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:property_system/client/screens/main/more/complaint/cloused_compailent_page.dart';
import 'package:property_system/client/screens/main/more/complaint/existing_compailent_page.dart';
import 'package:property_system/l10n/app_localizations.dart';

class ComplaintPage extends StatelessWidget {
  const ComplaintPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF3D60C6),
          toolbarHeight: 40,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                localizations.translate('submit_complaint'),
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontFamily: 'Pacifico',
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                height: 50,
                width: 50,
                child: Lottie.asset(
                  'assets/complaint.json',
                  repeat: true,
                  animate: true,
                ),
              ),
            ],
          ),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(
                icon: const Icon(Icons.report_problem),
                text: localizations.translate('existing_complaints'),
              ),
              Tab(
                icon: const Icon(Icons.done),
                text: localizations.translate('closed_complaints'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ExistingCompailentPage(),
            ClousedCompailentPage(),
          ],
        ),
      ),
    );
  }
}
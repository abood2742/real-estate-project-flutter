import 'package:flutter/material.dart';
import 'package:property_system/client_user/components/reserved_propert_components.dart';

class ClientReservedPropertyForSellPage extends StatelessWidget {
  const ClientReservedPropertyForSellPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ListView(
        children: const [
          ReservedPropertComponents(),
          ReservedPropertComponents(),
          ReservedPropertComponents(),
        ],
      ),
    );
  }
}

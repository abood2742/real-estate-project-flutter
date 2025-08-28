
import 'package:flutter/material.dart';
import 'package:property_system/client/components/subscripions_card.dart';
import 'package:property_system/client/services/subscription_service_done.dart';
import 'package:property_system/office/screens/subscriptions_next_page.dart';
import 'package:property_system/client/models/all_subscription_model.dart';

class SubscriptionsOfficePage extends StatefulWidget {
  const SubscriptionsOfficePage({super.key});

  @override
  State<SubscriptionsOfficePage> createState() =>
      _SubscriptionsOfficePaeState();
}

class _SubscriptionsOfficePaeState extends State<SubscriptionsOfficePage> {
  int selectedPlan = -1; // -1 = no plan
  final SubscriptionService _service = SubscriptionService();
  List<AllSubscriptionModel> subscriptions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSubscriptions();
  }

  Future<void> fetchSubscriptions() async {
    final result = await _service.getAllSubscriptions();
    setState(() {
      subscriptions = result;
      isLoading = false;
    });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 54, 36, 88),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'خطة الدفع',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: subscriptions.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        final sub = subscriptions[index];
                        return SubscriptionCard(
                          title: sub.name,
                          price: '\$${sub.price}',
                          features: sub.description,
                          icon: Icons.star_outline,
                          isSelected: selectedPlan == index,
                          onTap: () {
                            setState(() {
                              selectedPlan = index;
                            });
                          },
                          numberOfProperty: sub.maxProperties.toString(),
                          numberOfPromotions: sub.maxPromotions.toString(),
                          period: sub.period,
                        );
                      },
                    ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: selectedPlan == -1
                    ? null
                    : () {
                        final selected = subscriptions[selectedPlan];
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SubscriptionsNextPage(
                              planName: selected.name,
                              planPrice: selected.price, 
                              id: selected.id,
                          
                            ),
                          ),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'إستمرار',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

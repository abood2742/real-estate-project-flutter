import 'package:flutter/material.dart';

class SubscriptionCard extends StatelessWidget {
  final String title;
  final String price;
  final String features;
  final String numberOfProperty;
  final String numberOfPromotions; //عدد العروض الترويجية
  final String period;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const SubscriptionCard({
    super.key,
    required this.title,
    required this.price,
    required this.features,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.numberOfProperty,
    required this.numberOfPromotions,
    required this.period,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 210,
        height: 800,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color.fromARGB(255, 13, 168, 171) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 60,
              color: isSelected ? Colors.white : const Color.fromARGB(255, 28, 173, 186),
            ),
            SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : const Color.fromARGB(255, 60, 60, 190),
              ),
            ),
            SizedBox(height: 10),
            Text(
              price,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : const Color.fromARGB(255, 11, 106, 154),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'العقارات المسموح نشرها',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : const Color.fromARGB(255, 39, 123, 176),
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  numberOfProperty,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : const Color.fromARGB(255, 39, 82, 176),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'عدد العروض الترويجية',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : const Color.fromARGB(255, 39, 105, 176),
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  numberOfPromotions,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : const Color.fromARGB(255, 39, 108, 176),
                  ),
                ),
              ],
            ),
                SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'المدة',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : const Color.fromARGB(255, 39, 105, 176),
                  ),
                ),
                SizedBox(width: 18),
                Text(
                  period,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : const Color.fromARGB(255, 39, 119, 176),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              features,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Pacifico',
                color: isSelected ? Colors.white70 : const Color.fromARGB(255, 37, 132, 124),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

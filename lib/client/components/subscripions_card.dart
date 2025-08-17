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
          color: isSelected ? Colors.purple[300] : Colors.white,
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
              color: isSelected ? Colors.white : Colors.purple,
            ),
            SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              price,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.purple,
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
                    color: isSelected ? Colors.white : Colors.purple,
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  numberOfProperty,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : Colors.purple,
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
                    color: isSelected ? Colors.white : Colors.purple,
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  numberOfPromotions,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : Colors.purple,
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
                    color: isSelected ? Colors.white : Colors.purple,
                  ),
                ),
                SizedBox(width: 18),
                Text(
                  period,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : Colors.purple,
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
                color: isSelected ? Colors.white70 : Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*

import 'package:flutter/material.dart';

class SubscriptionCard extends StatelessWidget {
  final String title;
  final String price;
  final String features;
  final String numberOfProperty;
  final String numberOfPromotions;
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
        constraints: BoxConstraints(
          minHeight: 380, // ارتفاع أدنى للحاوية
        ),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.purple[300] : Colors.white,
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
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 60,
              color: isSelected ? Colors.white : Colors.purple,
            ),
            SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              price,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.purple,
              ),
            ),
            SizedBox(height: 12),
            _buildFeatureRow(
              'العقارات المسموح نشرها',
              numberOfProperty,
            ),
            SizedBox(height: 12),
            _buildFeatureRow(
              'عدد العروض',
              numberOfPromotions,
            ),
            SizedBox(height: 12),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                features,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: isSelected ? Colors.white70 : Colors.grey[700],
                ),
              ),
            ),
            SizedBox(height: 12),
            _buildFeatureRow(
              'المدة',
              period,
              isSmall: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureRow(String label, String value, {bool isSmall = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isSmall ? 10 : 12,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.purple,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isSmall ? 11 : 14,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.purple,
            ),
          ),
        ],
      ),
    );
  }
}
*/ 
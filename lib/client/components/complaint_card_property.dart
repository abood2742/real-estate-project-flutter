import 'package:flutter/material.dart';

/// بطاقة شكوى عقار
class PropertyComplaintCard extends StatelessWidget {
  final VoidCallback onTap;
  final String date;
  final String title;
  final String city;
  final String propertyNumber;
  final String type;



  const PropertyComplaintCard({
    super.key,
    required this.onTap, 
    required this.date, 
    required this.title, 
    required this.city, 
    required this.propertyNumber, 
    required this.type,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.home, color: Colors.green),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "$type - $propertyNumber - $city",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    date.split('T')[0],
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

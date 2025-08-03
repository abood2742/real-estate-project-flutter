import 'package:flutter/material.dart';
import 'package:property_system/client/components/property_card.dart';



class SavedPropertiesPage extends StatelessWidget {
  const SavedPropertiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        PropertyCard(
  imageUrl: 'assets/images/card.jpg',
  title: 'Apartment',
  location: 'Mazzah',
  price: '30,000 \$',
  area: '100 m²',
),

 PropertyCard(
  imageUrl: 'assets/images/card.jpg',
  title: 'Apartment',
  location: 'Mazzah',
  price: '30,000 \$',
  area: '100 m²',
),

 PropertyCard(
  imageUrl: 'assets/images/card.jpg',
  title: 'Apartment',
  location: 'Mazzah',
  price: '30,000 \$',
  area: '100 m²',
),

 PropertyCard(
  imageUrl: 'assets/images/card.jpg',
  title: 'Apartment',
  location: 'Mazzah',
  price: '30,000 \$',
  area: '100 m²',
),


 PropertyCard(
  imageUrl: 'assets/images/card.jpg',
  title: 'Apartment',
  location: 'Mazzah',
  price: '30,000 \$',
  area: '100 m²',
),

      ],),
      
    );
  }
}
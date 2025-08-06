import 'package:flutter/material.dart';

class RatingStarsWidget extends StatelessWidget {
  final double rating; // مثال: 3.5
  final double iconSize;

  const RatingStarsWidget({
    super.key,
    required this.rating,
    this.iconSize = 18,
  });

  Widget _buildStar(double starPosition) {
    if (rating >= starPosition) {
      return Icon(Icons.star, color: Colors.amber, size: iconSize);
    } else if (rating + 0.5 >= starPosition) {
      return Icon(Icons.star_half, color: Colors.amber, size: iconSize);
    } else {
      return Icon(Icons.star_border, color: Colors.amber, size: iconSize);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) => _buildStar(index + 1.0)),
    );
  }
}

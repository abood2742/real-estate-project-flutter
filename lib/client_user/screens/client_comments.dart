import 'package:flutter/material.dart';

class Review {
  final String name;
  final int rating;
  final DateTime date;
  final String comment;

  Review({
    required this.name,
    required this.rating,
    required this.date,
    required this.comment,
  });
}

class ClientComments extends StatelessWidget {
  final List<Review> reviews;

  const ClientComments({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF3D60C6),
          title: const Text(
            'تقييمات العملاء',
            style: TextStyle(color: Colors.white, fontFamily: 'Pacifico'),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: reviews.isEmpty
              ? const Center(
                  child: Text(
                    'لا توجد تقييمات حتى الآن.',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Pacifico',
                      color: Colors.grey,
                    ),
                  ),
                )
              : ListView.separated(
                  itemCount: reviews.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final review = reviews[index];
                    return _buildReviewCard(review);
                  },
                ),
        ),
      ),
    );
  }

  Widget _buildReviewCard(Review review) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.person, color: Color(0xFF3D60C6)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    review.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pacifico',
                      color: Color(0xFF3D60C6),
                    ),
                  ),
                ),
                Text(
                  '${review.date.year}-${review.date.month.toString().padLeft(2, '0')}-${review.date.day.toString().padLeft(2, '0')}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildStarRow(review.rating),
            const SizedBox(height: 6),
            Text(
              review.comment,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStarRow(int rating) {
    return Row(
      children: List.generate(
        5,
        (index) => Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 20,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:property_system/client/models/comment_and_rating_model.dart';
import 'package:property_system/client/screens/search/comments/comments_page.dart';
import 'package:property_system/client/services/Comment_And_Rating_service.dart';

class AddCommentAndRatingPage extends StatefulWidget {
  final String officeId;
  const AddCommentAndRatingPage({super.key, required this.officeId});

  @override
  State<AddCommentAndRatingPage> createState() =>
      _AddCommentAndRatingPageState();
}

class _AddCommentAndRatingPageState extends State<AddCommentAndRatingPage> {
  int _userRating = 0;
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF3D60C6),
          title: const Text(
            'التعليق والتقييم',
            style: TextStyle(color: Colors.white, fontFamily: 'Pacifico'),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                ' شاركنا رأيك :',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Pacifico',
                  color: Color.fromARGB(255, 48, 66, 102),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                '⭐ تقييمك:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Pacifico',
                  color: Color.fromARGB(255, 48, 66, 102),
                ),
              ),
              StarRating(
                rating: _userRating,
                onRatingChanged: (rating) {
                  setState(() => _userRating = rating);
                },
              ),
              const SizedBox(height: 12),
              const Text(
                '📝 تعليقك:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Pacifico',
                  color: Color.fromARGB(255, 48, 66, 102),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _commentController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'صف تجربتك ',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: _onSendPressed,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Color(0xFF1565C0)),
                  child: const Center(
                    child: Text(
                      'إرسال',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontFamily: 'Pacifico',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '💬 سيتم عرض تعليقك بعد مراجعته حسب شروط الاستخدام',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Pacifico',
                  color: Color.fromARGB(255, 48, 66, 102),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSendPressed() {
    if (_userRating < 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('⚠️ الرجاء إدخال تقييم لا يقل عن نجمة واحدة.'),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('تأكيد الإرسال'),
        content: const Text('هل أنت متأكد من إرسال التعليق؟'),
        actions: [
          TextButton(
            child: const Text('إلغاء'),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: const Text('نعم، إرسال'),
            onPressed: () {
              Navigator.pop(context); // إغلاق الـ dialog
              _submitReview(); // تنفيذ الإرسال
            },
          ),
        ],
      ),
    );
  }

  void _submitReview() async {
    final comment = _commentController.text.trim();

    final Rating? rating = await CommentAndRatingService()
        .rateOffice(officeId: widget.officeId, rating: _userRating);

    if (comment.isNotEmpty) {
      //final bool? commentSubmited =
      await CommentAndRatingService().addCommentToOffice(
          officeId: widget.officeId, comment: comment, ratingId: rating!.id!);
    }
    _commentController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✅ تم إرسال التعليق بنجاح'),
        duration: Duration(seconds: 2),
      ),
    );

    // Future.delayed(const Duration(seconds: 2), () {
    //   Navigator.pop(context, commentSubmited);
    // });

    Future.delayed(const Duration(seconds: 0), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => CommentsPage(
                  officeId: widget.officeId,
                )),
      );
    });
  }
}

class StarRating extends StatelessWidget {
  final int rating;
  final ValueChanged<int> onRatingChanged;
  const StarRating({
    super.key,
    required this.rating,
    required this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        final icon = index < rating ? Icons.star : Icons.star_border;
        return IconButton(
          icon: Icon(icon, size: 32, color: Colors.amber),
          padding: EdgeInsets.zero,
          onPressed: () => onRatingChanged(index + 1),
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:property_system/client/models/comment_and_rating_model.dart';
import 'package:property_system/client/services/Comment_And_Rating_service.dart';
import 'package:property_system/utils/Office_Page_State_enum.dart';


class CommentsPage extends StatefulWidget {
  final String officeId;

  const CommentsPage({super.key, required this.officeId});

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  List<CommentAndRatingModel> commentAndRatingModel = [];
  PagesState pageState = PagesState.loading;

  @override
  void initState() {
    super.initState();
    getComments();
  }

  Future<void> getComments() async {
    setState(() => pageState = PagesState.loading);
    try {
      final result = await CommentAndRatingService()
          .getCommentsOnOffice(officeId: widget.officeId);

      commentAndRatingModel = result ?? [];
      setState(() => pageState = PagesState.success);
    } catch (e) {
      setState(() => pageState = PagesState.error);
    }
  }

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
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    switch (pageState) {
      case PagesState.loading:
        return const Center(child: CircularProgressIndicator());

      case PagesState.error:
        return const Center(
          child: Text(
            'حدث خطأ أثناء تحميل التقييمات.',
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Pacifico',
              color: Colors.red,
            ),
          ),
        );

      case PagesState.success:
        if (commentAndRatingModel.isEmpty) {
          return const Center(
            child: Text(
              'لا توجد تقييمات حتى الآن.',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Pacifico',
                color: Colors.grey,
              ),
            ),
          );
        }

        return ListView.separated(
          itemCount: commentAndRatingModel.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final review = commentAndRatingModel[index];
            return _buildReviewCard(review);
          },
        );
    }
  }

  Widget _buildReviewCard(CommentAndRatingModel comment) {
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
              CircleAvatar(
                radius: 20,
                backgroundColor: const Color(0xFF3D60C6),
                backgroundImage: comment.user.profilePhoto != null
                    ? NetworkImage(comment.user.profilePhoto!.url) // رابط الصورة
                    : const AssetImage('assets/images/default_avatar.png')
                        as ImageProvider,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${comment.user.firstName} ${comment.user.lastName}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Pacifico',
                    color: Color(0xFF3D60C6),
                  ),
                ),
              ),
              Text(
                '${comment.date}',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildStarRow(comment.rate.rating),
          const SizedBox(height: 6),
          Text(
            comment.content,
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

import 'package:flutter/material.dart';
import 'package:property_system/client/models/comment_and_rating_model.dart';
import 'package:property_system/client/services/Comment_And_Rating_service_done.dart';
import 'package:property_system/utils/Office_Page_State_enum.dart';

class CommentsPage extends StatefulWidget {
  final bool type;
  final String id;

  const CommentsPage({super.key, required this.id, required this.type});

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  List<CommentModel> commentModel = [];
  PagesState pageState = PagesState.loading;

  @override
  void initState() {
    super.initState();
    getComments();
  }

  Future<void> getComments() async {
    setState(() => pageState = PagesState.loading);
    try {
      var result;
      if (widget.type) {
        result = await CommentAndRatingService()
            .getCommentsOnOffice(officeId: widget.id);
      } else {
        result = await CommentAndRatingService()
            .getCommentsOnProperty(propertyId: widget.id);
      }

      commentModel = result ?? [];
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
        if (commentModel.isEmpty) {
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
          itemCount: commentModel.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final review = commentModel[index];
            return _buildReviewCard(review);
          },
        );
    }
  }

  Widget _buildReviewCard(CommentModel comment) {
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
                      ? NetworkImage(
                          comment.user.profilePhoto!.url) // رابط الصورة
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
                  DateTime.parse(comment.date)
                      .toLocal()
                      .toIso8601String()
                      .split('T')[0],
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 8),
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
}

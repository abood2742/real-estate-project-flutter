import 'package:flutter/material.dart';
import 'package:property_system/client/components/custom_button.dart';
import 'package:property_system/client/components/custom_buttons/build_stars.dart';
import 'package:property_system/client/models/office_details_model.dart';
import 'package:property_system/client/screens/search/comments/Comments_Page.dart';
import 'package:property_system/client/services/Comment_And_Rating_service_done.dart';
import 'package:property_system/client/services/favorite_service_done.dart';
import 'package:property_system/client/services/search_service.dart';
import 'package:property_system/utils/office_page_state_enum.dart';

class OfficeDetailsPage extends StatefulWidget {
  final String officeId;
  const OfficeDetailsPage({super.key, required this.officeId});

  @override
  State<OfficeDetailsPage> createState() => _OfficeDetailsPageState();
}

class _OfficeDetailsPageState extends State<OfficeDetailsPage> {
  PagesState pageState = PagesState.loading;
  OfficeDetailsModel? officeDetailsModel;

  final ScrollController _scrollController = ScrollController();
  final GlobalKey _commentBoxKey = GlobalKey();

  // متغيرات صندوق التعليق
  bool _showCommentBox = false;
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getOneOffice();
  }

  Future<void> getOneOffice() async {
    try {
      officeDetailsModel =
          await SearchService().getOneOffice(officeId: widget.officeId);
      if (officeDetailsModel != null) {
        setState(() => pageState = PagesState.success);
      } else {
        setState(() => pageState = PagesState.error);
      }
    } catch (e) {
      setState(() => pageState = PagesState.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'معلومات المكتب',
          style: TextStyle(color: Colors.white, fontFamily: 'Pacifico'),
        ),
        actions: [
          if (pageState == PagesState.success)
            IconButton(
              icon: Icon(
                officeDetailsModel!.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: officeDetailsModel!.isFavorite
                    ? const Color(0xFF1565C0)
                    : Colors.grey,
              ),
              onPressed: () async {
                final newStatus = !officeDetailsModel!.isFavorite;
                setState(() => officeDetailsModel!.isFavorite = newStatus);
                if (newStatus) {
                  await FavoriteService()
                      .addOfficeToFavorite(officeId: officeDetailsModel!.id);
                } else {
                  await FavoriteService().removeOfficeFromFavorite(
                      officeId: officeDetailsModel!.id);
                }
              },
            )
        ],
      ),
      body: Builder(
        builder: (_) {
          switch (pageState) {
            case PagesState.loading:
              return const Center(child: CircularProgressIndicator());
            case PagesState.error:
              return _buildError();
            case PagesState.success:
              return _buildOfficeDetails();
          }
        },
      ),
    );
  }

  Widget _buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, color: Colors.red, size: 48),
          const SizedBox(height: 8),
          const Text('حدث خطأ أثناء تحميل البيانات'),
          const SizedBox(height: 16),
          ElevatedButton(
              onPressed: getOneOffice, child: const Text('إعادة المحاولة')),
        ],
      ),
    );
  }

  Widget _buildOfficeDetails() {
    return SingleChildScrollView(
      controller: _scrollController, // هنا

      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              officeDetailsModel!.officePhoto!.url,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            officeDetailsModel!.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Pacifico',
              color: Color.fromARGB(255, 8, 164, 182),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),

          // صف النجوم
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RatingStarsWidget(rating: officeDetailsModel!.ratings ?? 0),
              const SizedBox(width: 8),
              Text(
                (officeDetailsModel!.ratings ?? 0).toStringAsFixed(1),
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.rate_review, color: Colors.blue),
                onPressed: () {
                  _showRatingDialog(context);
                },
              ),
            ],
          ),
          const SizedBox(height: 16),

          _buildInfoCard(
              Icons.web, 'البريد الإلكتروني', officeDetailsModel!.officeEmail),
          _buildInfoCard(
              Icons.phone, 'رقم الهاتف', officeDetailsModel!.officePhone),
          _buildInfoCard(Icons.description, 'رقم الرخصة',
              officeDetailsModel!.licenseNumber),
          _buildInfoCard(Icons.badge, 'الرقم الوطني',
              officeDetailsModel!.personalIdentityNumber),

          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => Dialog(
                  child: Image.network(officeDetailsModel!.licensePhoto!.url),
                ),
              );
            },
            icon: const Icon(Icons.image),
            label: const Text('عرض صورة الترخيص'),
          ),
          const SizedBox(height: 10),

          // زر إضافة تعليق وتقييم
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: CustomButton(
              text: 'إضافة تعليق وتقييم',
              onTap: () {
                setState(() {
                  _showCommentBox = !_showCommentBox; // إظهار/إخفاء
                });

                if (_showCommentBox) {
                  // انتظر انتهاء بناء الصندوق
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    final RenderBox? box = _commentBoxKey.currentContext
                        ?.findRenderObject() as RenderBox?;
                    if (box != null) {
                      // موقع الصندوق من أعلى القائمة + ارتفاعه
                      final position =
                          box.localToGlobal(Offset.zero, ancestor: null).dy;
                      final height = box.size.height;
                      final scrollOffset = _scrollController.offset +
                          position +
                          height -
                          MediaQuery.of(context).size.height +
                          20;

                      _scrollController.animateTo(
                        scrollOffset > 0 ? scrollOffset : 0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  });
                }
              },
            ),
          ),

          // صندوق التعليق يظهر بانسيابية أسفل الزر
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: _showCommentBox
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            firstChild: Container(
              key: _commentBoxKey, // هنا
              child: _buildCommentBox(),
            ), // نفس تصميم AddCommentPage
            secondChild: const SizedBox.shrink(),
          ),

          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: CustomButton(
              text: 'عرض كل التعليقات',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CommentsPage(id:  officeDetailsModel!.id, type: true,),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showRatingDialog(BuildContext context) {
    int selectedRating = 0;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'قيّم المكتب:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      final isSelected = index < selectedRating;
                      return IconButton(
                        icon: Icon(
                          isSelected ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                          size: 32,
                        ),
                        onPressed: () {
                          setState(() => selectedRating = index + 1);
                        },
                      );
                    }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // إغلاق النافذة
                        },
                        child: const Text('رجوع',
                            style: TextStyle(color: Colors.red)),
                      ),
                      ElevatedButton(
                        onPressed: selectedRating > 0
                            ? () async {
                                await CommentAndRatingService().rateOffice(
                                    officeId: officeDetailsModel!.id,
                                    rating: selectedRating);
                                Navigator.pop(context);
                              }
                            : null,
                        child: const Text('إرسال'),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildCommentBox() {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'شاركنا رأيك:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Pacifico',
              color: Color.fromARGB(255, 48, 66, 102),
            ),
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
              hintText: 'صف تجربتك',
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
                  color: const Color(0xFF1565C0)),
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
          // const Text(
          //   '💬 سيتم عرض تعليقك بعد مراجعته حسب شروط الاستخدام',
          //   style: TextStyle(
          //     fontSize: 14,
          //     fontWeight: FontWeight.bold,
          //     fontFamily: 'Pacifico',
          //     color: Color.fromARGB(255, 48, 66, 102),
          //   ),
          // ),
        ],
      ),
    );
  }

  void _onSendPressed() {
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
              Navigator.pop(context);
              _submitReview();
            },
          ),
        ],
      ),
    );
  }

  void _submitReview() async {
    final comment = _commentController.text.trim();
    if (comment.isNotEmpty) {
      await CommentAndRatingService().addCommentToOffice(
        officeId: widget.officeId,
        comment: comment,
      );
    }
    _commentController.clear();
    setState(() => _showCommentBox = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ تم إرسال التعليق بنجاح')),
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String subtitle) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.green),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Pacifico',
            color: Color.fromARGB(255, 64, 41, 195),
          ),
        ),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey)),
      ),
    );
  }
}

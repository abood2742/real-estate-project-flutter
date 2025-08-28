import 'package:flutter/material.dart';
import 'package:property_system/client/components/custom_button.dart';
import 'package:property_system/client/models/property_model.dart';
import 'package:property_system/client/reservation%20_for_client/client_create_reservation_page.dart';
import 'package:property_system/client/screens/search/comments/Comments_Page.dart';
import 'package:property_system/client/screens/search/resault/office/Office_Details_Page.dart';
import 'package:property_system/client/screens/search/map/map_page.dart';
import 'package:property_system/client/screens/report/report_post_page.dart';
import 'package:property_system/client/services/Comment_And_Rating_service_done.dart';
import 'package:property_system/client/services/favorite_service_done.dart';

class PropertyDetailsPage extends StatefulWidget {
  final PropertyModel propertyModel;
  const PropertyDetailsPage({super.key, required this.propertyModel});

  @override
  State<PropertyDetailsPage> createState() => _PropertyDetailsPageState();
}

class _PropertyDetailsPageState extends State<PropertyDetailsPage>
    with TickerProviderStateMixin {
  bool _showCommentBox = false;
  final TextEditingController _commentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _commentBoxKey = GlobalKey();
  bool _isLoadingFavorite = true;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    try {
      final result = await FavoriteService()
          .chechIfPropertyIsFavorite(propertyId: widget.propertyModel.id);
      setState(() {
        widget.propertyModel.isFavorite = result;
        _isLoadingFavorite = false;
      });
    } catch (e) {
      print('Exception in property page: $e');
      setState(() => _isLoadingFavorite = false);
    }
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
              _submitComment();
            },
          ),
        ],
      ),
    );
  }

  void _submitComment() async {
    final comment = _commentController.text.trim();
    if (comment.isNotEmpty) {
      await CommentAndRatingService().addCommentToProperty(
        propertyId: widget.propertyModel.id,
        comment: comment,
      );
    }
    _commentController.clear();
    setState(() => _showCommentBox = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ تم إرسال التعليق بنجاح')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final property = widget.propertyModel;

    // return Directionality(
    //   textDirection: TextDirection.rtl,
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'تفاصيل العقار',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Pacifico',
            color: Color.fromARGB(255, 48, 66, 102),
          ),
        ),
        actions: [
          _isLoadingFavorite
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
              : IconButton(
                  icon: Icon(
                    property.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: property.isFavorite ? Colors.blue : Colors.grey,
                  ),
                  onPressed: () async {
                    final newStatus = !property.isFavorite;
                    setState(() => property.isFavorite = newStatus);
                    if (newStatus) {
                      await FavoriteService()
                          .addPropertyToFavorite(propertyId: property.id);
                    } else {
                      await FavoriteService()
                          .removePropertyFromFavorite(propertyId: property.id);
                    }
                  },
                ),
        ],
      ),
      body: Builder(builder: (_) {
        return _buildPropertyDetails();
      }),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ClientCreateReservationPage(
                                propertyId: property.id,
                              )));
                },
                icon: const Icon(Icons.book_online),
                label: const Text('حجز العقار'),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ReportPostPage()));
              },
              icon: const Icon(Icons.report, color: Colors.red),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OfficeDetailsPage(
                officeId: property.office.officeId,
              ),
            ),
          );
        },
        icon: property.office.officePhoto != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  property.office.officePhoto!.url,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              )
            : const Icon(Icons.business),
        label: Text(property.office.officeName),
      ),
    );
    // );
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

  Widget _buildPropertyDetails() {
    final property = widget.propertyModel;

    return SingleChildScrollView(
      controller: _scrollController,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // صور العقار
          PropertyImagesGallery(
            mainImage: property.photos.isNotEmpty
                ? property.photos.first.url
                : 'assets/images/pic3.jpg',
            extraImages: property.photos.length > 1
                ? property.photos.skip(1).map((e) => e.url).toList()
                : [],
          ),
          const SizedBox(height: 12),

          // السعر والموقع
          Row(
            children: [
              Text(
                '${property.price} \$',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              const Icon(Icons.location_pin, color: Colors.blue),
              const SizedBox(width: 4),
              Expanded(
                flex: 0,
                child: Text(
                  property.location.city,
                  style: const TextStyle(fontFamily: 'Pacifico'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // زر عرض على الخريطة
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              icon: const Icon(Icons.map, color: Colors.white),
              label: const Text(
                'عرض على الخريطة',
                style: TextStyle(
                    fontSize: 14, color: Colors.white, fontFamily: 'Pacifico'),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => MapPage()),
                );
              },
            ),
          ),
          const SizedBox(height: 16),

          // وصف العقار
          const Text(
            'الوصف',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
              fontFamily: 'Pacifico',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            property.description,
            textAlign: TextAlign.right,
            style: const TextStyle(height: 1.6),
          ),
          const SizedBox(height: 24),

          // معلومات العقار
          const Text(
            'معلومات العقار',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
              fontFamily: 'Pacifico',
            ),
          ),
          const SizedBox(height: 8),
          Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.numbers),
                  title: const Text('رقم العقار'),
                  subtitle: Text(property.propertyNumber),
                ),
                ListTile(
                  leading: const Icon(Icons.category),
                  title: const Text('نوع العقار'),
                  subtitle: Text(property.propertyType.name),
                ),
                ListTile(
                  leading: const Icon(Icons.swap_horiz),
                  title: const Text('نوع العملية'),
                  subtitle: Text(property.typeOperation),
                ),
                ListTile(
                  leading: const Icon(Icons.straighten),
                  title: const Text('المساحة'),
                  subtitle: Text('${property.space} م²'),
                ),
                ListTile(
                  leading: const Icon(Icons.date_range),
                  title: const Text('تاريخ النشر'),
                  subtitle: Text(
                    '${property.publishDate.toLocal()}'.split(' ')[0],
                  ),
                ),
              ],
            ),
          ),

          // تفاصيل الترخيص
          const SizedBox(height: 16),
          const Text(
            'تفاصيل الترخيص',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
              fontFamily: 'Pacifico',
            ),
          ),
          const SizedBox(height: 8),
          Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.badge),
                  title: const Text('رقم الترخيص'),
                  subtitle: Text(property.licenseDetails.licenseNumber),
                ),
                ListTile(
                  leading: const Icon(Icons.business),
                  title: const Text('اسم المكتب'),
                  subtitle: Text(property.office.officeName),
                ),
                ListTile(
                  leading: const Icon(Icons.date_range),
                  title: const Text('تاريخ الترخيص'),
                  subtitle: Text(
                    '${property.licenseDetails.date.toLocal()}'.split(' ')[0],
                  ),
                ),
              ],
            ),
          ),

          // خصائص العقار
          const SizedBox(height: 16),
          const Text(
            'خصائص العقار',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
              fontFamily: 'Pacifico',
            ),
          ),
          const SizedBox(height: 8),
          if (property.propertyAttributes.isNotEmpty)
            Card(
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: Column(
                children: property.propertyAttributes.map((attr) {
                  return ListTile(
                    leading: const Icon(Icons.check_circle_outline),
                    title: Text(attr.attribute.name),
                    subtitle: Text(attr.value),
                  );
                }).toList(),
              ),
            )
          else
            const Text('لا توجد خصائص مسجلة'),

          const SizedBox(height: 16),

          // زر التعليق مع تأثير الانسياب
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: CustomButton(
              text: 'إضافة تعليق وتقييم',
              onTap: () {
                setState(() {
                  _showCommentBox = !_showCommentBox; // إظهار/إخفاء
                });

                if (_showCommentBox) {
                  // تأكد من أن التمرير يحدث بعد بناء الصندوق
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    final RenderBox? box = _commentBoxKey.currentContext
                        ?.findRenderObject() as RenderBox?;
                    if (box != null) {
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

          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: _showCommentBox
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            firstChild: Container(
              key: _commentBoxKey, // هنا
              margin: const EdgeInsets.only(bottom: 50),
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
                    builder: (_) => CommentsPage(
                      id: property.id,
                      type: false,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Scroll أفقي للصور
class PropertyImagesGallery extends StatelessWidget {
  final String mainImage;
  final List<String> extraImages;

  const PropertyImagesGallery({
    super.key,
    required this.mainImage,
    required this.extraImages,
  });

  @override
  Widget build(BuildContext context) {
    final allImages = [mainImage, ...extraImages];

    return SizedBox(
      height: 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: allImages.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => FullImageView(imageUrl: allImages[index])),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                allImages[index],
                width: 300,
                height: 220,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}

/// عرض الصورة بالحجم الكامل
class FullImageView extends StatelessWidget {
  final String imageUrl;
  const FullImageView({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: InteractiveViewer(
            child: Image.network(imageUrl),
          ),
        ),
      ),
    );
  }
}

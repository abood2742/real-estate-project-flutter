import 'package:flutter/material.dart';
import 'package:property_system/client/models/client_done_Properties.dart';

class ExpiredComponents extends StatefulWidget {
  final ClientDoneProperties property;
  final VoidCallback? onTap;

  const ExpiredComponents({
    super.key,
    required this.property,
    this.onTap,
  });

  @override
  State<ExpiredComponents> createState() => _ExpiredComponentsState();
}

class _ExpiredComponentsState extends State<ExpiredComponents> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) {
        setState(() => isPressed = false);
        if (widget.onTap != null) widget.onTap!();
      },
      onTapCancel: () => setState(() => isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        transform: Matrix4.identity()..scale(isPressed ? 0.97 : 1.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8), // padding أصغر حول البطاقة
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // يقلل الفراغ أسفل البطاقة
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: widget.property.propertyModel.photos.isNotEmpty
                      ? Image.network(
                          widget.property.propertyModel.photos[0].url,
                          fit: BoxFit.cover,
                          height: 180, // تكبير الصورة قليلاً
                          width: double.infinity,
                        )
                      : Image.asset(
                          'assets/images/init.png',
                          fit: BoxFit.cover,
                          height: 180,
                          width: double.infinity,
                        ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text(
                      'العقار:',
                      style: TextStyle(color: Colors.grey, fontFamily: 'Pacifico'),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        widget.property.propertyModel.propertyType.name,
                        style: const TextStyle(color: Colors.blue, fontFamily: 'Pacifico'),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6), // تقليل المسافة بين الصفوف
                Row(
                  children: [
                    const Text(
                      'الموقع:',
                      style: TextStyle(color: Colors.grey, fontFamily: 'Pacifico'),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        widget.property.propertyModel.location.city,
                        style: const TextStyle(color: Colors.blue, fontFamily: 'Pacifico'),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6), // تقليل المسافة
                Row(
                  children: [
                    const Text(
                      'تاريخ الانتهاء:',
                      style: TextStyle(color: Colors.grey, fontFamily: 'Pacifico'),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      widget.property.date,
                      style: const TextStyle(color: Colors.blue, fontFamily: 'Pacifico'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

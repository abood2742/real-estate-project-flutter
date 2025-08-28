import 'package:flutter/material.dart';

class CancelCustomButton extends StatelessWidget {
  final Future<void> Function() onConfirm; // الدالة التي تنفذ عند التأكيد
  final String title; // النص في نافذة التأكيد
  final String cancelText; // نص زر الإلغاء في الديالوج
  final String confirmText; // نص زر التأكيد في الديالوج
  final String buttonLabel; // نص الزر نفسه
  final String snackBarMessage; // نص الرسالة في SnackBar
  final Color buttonColor; // لون الزر الرئيسي
  final Color confirmButtonColor; // لون زر التأكيد
  final IconData icon; // أيقونة الزر

  const CancelCustomButton({
    super.key,
    required this.onConfirm,
    this.title = 'هل تريد إلغاء حجز العقار؟',
    this.cancelText = 'إلغاء',
    this.confirmText = 'تأكيد',
    this.buttonLabel = 'إلغاء الحجز',
    this.snackBarMessage = 'تم إلغاء الحجز',
    this.buttonColor = Colors.red,
    this.confirmButtonColor = Colors.redAccent,
    this.icon = Icons.cancel,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
        onPressed: () async {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              actionsAlignment: MainAxisAlignment.spaceEvenly,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    cancelText,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Pacifico',
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: confirmButtonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    await onConfirm();
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(snackBarMessage)),
                    );
                  },
                  child: Text(
                    confirmText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Pacifico',
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        icon: Icon(icon, color: Colors.white),
        label: Text(
          buttonLabel,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

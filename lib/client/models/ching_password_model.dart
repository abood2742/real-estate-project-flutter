class ChingPasswordModel {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;
  final String? accessToken;

  ChingPasswordModel({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword,
    this.accessToken,
  });

  // ✏️ تستخدمها إذا كنت تبغى ترسل البيانات
  Map<String, dynamic> toJson() => {
        'current_password': currentPassword,
        'new_password': newPassword,
        'confirm_password': confirmPassword,
      };

  // ✏️ تستخدمها إذا الـ backend رجّع التوكن بعد التغيير
  factory ChingPasswordModel.fromJson(Map<String, dynamic> json) {
    return ChingPasswordModel(
      currentPassword: json['current_password'] ?? '',
      newPassword: json['new_password'] ?? '',
      confirmPassword: json['confirm_password'] ?? '',
      accessToken: json['access_token'],
    );
  }

  // --------------------------
  // طرق تخزين / جلب التوكن
  // --------------------------
  static Future<void> saveAccessToken(String? token) async {
    //  هنا تستخدم SharedPreferences أو أي وسيلة تخزين
  }

  static Future<String?> getAccessToken() async {
    // ترجع التوكن من التخزين
    return null;
  }
}

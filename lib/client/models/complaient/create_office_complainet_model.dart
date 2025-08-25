class CreateOfficeComplainetModel {
  final String officeId;
  final String title;
  final String content;
  final List<String> complaintMedia;

  CreateOfficeComplainetModel({
    required this.officeId,
    required this.title,
    required this.content,
    required this.complaintMedia,
  });

  Map<String, dynamic> toJson() {
    return {
      'officeId': officeId,
      'title': title,
      'content': content,
      'complaint_media': complaintMedia,
    };
  }
  
}
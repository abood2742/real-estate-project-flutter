class CreateOfficeComplaintModel {
  final String officeId;
  final String title;
  final String content;




  CreateOfficeComplaintModel({
    required this.officeId,
    required this.title,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      'officeId': officeId,
      'title': title,
      'content': content,
      //'complaint_media': complaintMedia,
    };
  }
  
}
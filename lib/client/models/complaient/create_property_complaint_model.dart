class CreatePropertyComplaintModel {
  final String propertyId;
  final String title;
  final String content;




  CreatePropertyComplaintModel({
    required this.propertyId,
    required this.title,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      'officeId': propertyId,
      'title': title,
      'content': content,
      //'complaint_media': complaintMedia,
    };
  }
  
}
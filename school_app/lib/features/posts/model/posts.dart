import 'package:cloud_firestore/cloud_firestore.dart';

class PostData {
  String id;
  String studentId;
  String? studentName;
  String? studentLogo;
  String? studentPromotion;
  String description;
  String image;
  List<String>? likes;
  Timestamp? date = Timestamp.now();
  String? latestCommentUsername;
  String? latestCommentDescription;

  PostData({
    required this.id,
    required this.studentId,
    this.studentName,
    this.studentLogo,
    this.studentPromotion,
    required this.description,
    required this.image,
    this.date,
    this.latestCommentUsername,
    this.latestCommentDescription,
  });

  Map<String, dynamic> toPostService() {
    return {
      'post id': id,
      'student id': studentId,
      'student name': studentName,
      'student logo': studentLogo,
      'student promotion': studentPromotion,
      'description': description,
      'image': image,
      'likes': likes,
      'creation date': date,
      'latest comment username': latestCommentUsername,
      'latest comment description': latestCommentDescription
    };
  }
}

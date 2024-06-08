import 'package:cloud_firestore/cloud_firestore.dart';

class CommentData {
  String id;
  String postId;
  String content;
  String studentId;
  Timestamp? date = Timestamp.now();
  String? studentName;
  String? studentLogo;
  List<String>? likes;

  CommentData(
      {required this.id,
      required this.postId,
      required this.content,
      required this.studentId,
      this.date,
      this.studentName,
      this.studentLogo});

  Map<String, dynamic> toCommentService() {
    return {
      'comment id': id,
      'post id': postId,
      'comment': content,
      'student id': studentId,
      'student name': studentName,
      'student logo': studentLogo,
      'creation date': date,
      'likes': likes,
    };
  }
}

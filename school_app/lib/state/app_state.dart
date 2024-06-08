import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:school_app/features/auth/model/student.dart';
import 'package:school_app/features/auth/services/student_service.dart';
import 'package:school_app/services/firebase_services.dart';

class ApplicationState extends ChangeNotifier {
  bool isSwitched = false;
  int currentIndex = 0;
  // bool isPostLiked = false;
  // bool isCommentLiked = false;
  // int totalPostLike = 0;
  // int totalCommentLike = 0;
  Map<String, bool> isPostLiked = {};
  Map<String, int> totalPostLikes = {};
  Map<String, bool> isCommentLiked = {};
  Map<String, int> totalCommentLikes = {};
  StudentData? _student;
  final StudentService _studService = StudentService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseServices _services = FirebaseServices();

  StudentData? get getStudent => _student;

  Future<void> refreshUser() async {
    try {
      StudentData student = await _studService.getUserDetails();
      _student = student;
      // print("logo is : ${student.logo}");
    } catch (error) {
    } finally {
      notifyListeners();
    }
  }

  // Future<void> fetchTotalPostLikes() async {
  //   QuerySnapshot querySnapshot =
  //       await _services.posts.get();
  //   for (var doc in querySnapshot.docs) {
  //     String postId = doc.id;
  //     int likes = doc['likes'] ?? 0;
  //     totalPostLikes[postId] = likes;
  //   }
  //   notifyListeners();
  // }

  Future<bool> checkPostLikeStatus(String postId) async {
    try {
      User currentUser = _auth.currentUser!;
      DocumentSnapshot postSnapshot = await _services.posts.doc(postId).get();

      if (postSnapshot.exists) {
        List<String> likes = List<String>.from(postSnapshot['likes']);
        isPostLiked[postId] = likes.contains(currentUser.uid);

        notifyListeners();
        return isPostLiked[postId]!;
      }
    } catch (err) {
      print('Error checking like status: $err');
    }
    return false;
  }

  Future<bool> checkCommentLikeStatus(String commentId) async {
    try {
      User currentUser = _auth.currentUser!;
      DocumentSnapshot commentSnapshot =
          await _services.comments.doc(commentId).get();

      if (commentSnapshot.exists) {
        List<String> likes = List<String>.from(commentSnapshot['likes']);
        isCommentLiked[commentId] = likes.contains(currentUser.uid);

        notifyListeners();
        return isCommentLiked[commentId]!;
      }
    } catch (err) {
      print('Error checking like status: $err');
    }
    return false;
  }

  Future<int> totalPostLikesCount(String postId) async {
    try {
      DocumentSnapshot postSnapshot = await _services.posts.doc(postId).get();

      if (postSnapshot.exists) {
        List<String> likes = List<String>.from(postSnapshot['likes']);
        totalPostLikes[postId] = likes.length;

        notifyListeners();
        return totalPostLikes[postId]!;
      }
    } catch (err) {
      print('Error getting the number of likes: $err');
    }
    return 0;
  }

  Future<int> totalCommentLikesCount(String commentId) async {
    try {
      DocumentSnapshot commentSnapshot =
          await _services.comments.doc(commentId).get();

      if (commentSnapshot.exists) {
        List<String> likes = List<String>.from(commentSnapshot['likes']);
        totalCommentLikes[commentId] = likes.length;

        notifyListeners();
        return totalCommentLikes[commentId]!;
      }
    } catch (err) {
      print('Error getting the number of likes: $err');
    }
    return 0;
  }

  Future<void> logoutUser(BuildContext context) async {
    _student = null;
    notifyListeners();
  }
}

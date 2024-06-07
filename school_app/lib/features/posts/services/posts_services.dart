import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:school_app/features/posts/model/posts.dart';
import 'package:school_app/services/firebase_services.dart';
import 'package:school_app/state/app_state.dart';

class PostService {
  final FirebaseServices _services = FirebaseServices();
  ApplicationState appState = ApplicationState();
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> createPost({
    required String description,
    required File image,
  }) async {
    String resp = 'Some Error occured';

    try {
      if (description.isNotEmpty) {
        String imageUrl =
            await _services.uploadImageToStorage('PostImages', image);

        DocumentSnapshot studentSnapshot =
            await _services.users.doc(_services.user!.uid).get();
        String? studentName = studentSnapshot['Full Name'];
        String? studentLogo = studentSnapshot['Logolink'];
        String? studentPromotion = studentSnapshot['Promotion'];
        DocumentReference newPostRef = _services.posts.doc();
        String newPostId = newPostRef.id;

        PostData postData = PostData(
            id: newPostId,
            studentId: _services.user!.uid,
            description: description,
            image: imageUrl);

        postData.studentName = studentName;
        postData.studentLogo = studentLogo;
        postData.studentPromotion = studentPromotion;
        postData.likes = [];
        postData.date = Timestamp.now();
        postData.latestCommentDescription = "";
        postData.latestCommentUsername = "";

        await newPostRef.set(postData.toPostService());

        resp = 'success';
      }
    } catch (e) {
      resp = e.toString();
    }
    return resp;
  }

  Future<void> togglePostLike(String postId) async {
    try {
      User currentUser = _auth.currentUser!;
      DocumentSnapshot postSnapshot = await _services.posts.doc(postId).get();

      if (postSnapshot.exists) {
        List<String> likes = List<String>.from(postSnapshot['likes']);

        if (likes.contains(currentUser.uid)) {
          likes.remove(currentUser.uid);
        } else {
          likes.add(currentUser.uid);
        }

        await _services.posts.doc(postId).update({'likes': likes});

        // await appState.checkPostLikeStatus(postId);
        // await appState.totalPostLikesCount(postId);
      }
    } catch (err) {
      print('Error toggling like/dislike: $err');
    }
  }

  Future<List<DocumentSnapshot>> getLikedPosts() async {
    User currentUser = _auth.currentUser!;
    QuerySnapshot querySnapshot = await _services.posts.get();

    List<DocumentSnapshot> likedPosts = querySnapshot.docs.where((doc) {
      List<dynamic> likes = doc['likes'];
      return likes.contains(currentUser.uid);
    }).toList();

    return likedPosts;
  }
}

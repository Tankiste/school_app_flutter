import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:school_app/features/posts/model/posts.dart';
import 'package:school_app/services/firebase_services.dart';
import 'package:school_app/state/app_state.dart';

class PostService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseServices _services = FirebaseServices();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  ApplicationState appState = ApplicationState();

  String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

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
}

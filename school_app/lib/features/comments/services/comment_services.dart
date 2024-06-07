import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:school_app/features/comments/model/comments.dart';
import 'package:school_app/services/firebase_services.dart';
import 'package:school_app/state/app_state.dart';

class CommentService {
  final FirebaseServices _services = FirebaseServices();
  ApplicationState _appState = ApplicationState();
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> addComment(String postId, String content) async {
    String resp = "Some Error occured";

    try {
      if (content.isNotEmpty) {
        DocumentSnapshot studentSnapshot =
            await _services.users.doc(_services.user!.uid).get();
        String? studentName = studentSnapshot['Full Name'];
        String? studentLogo = studentSnapshot['Logolink'];
        DocumentReference newCommentRef = _services.comments.doc();
        String newCommentId = newCommentRef.id;

        CommentData commentData = CommentData(
            id: newCommentId,
            postId: postId,
            content: content,
            studentId: _services.user!.uid);

        commentData.likes = [];
        commentData.date = Timestamp.now();
        commentData.studentName = studentName;
        commentData.studentLogo = studentLogo;

        await newCommentRef.set(commentData.toCommentService());

        DocumentSnapshot commentDoc = await _services.posts.doc(postId).get();

        if (commentDoc.exists) {
          await _services.posts.doc(postId).update({
            'latest comment username': studentName,
            'latest comment description': content,
          });
        }

        resp = 'success';
      }
    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }

  Stream<QuerySnapshot> getCommentsByPost(String postId) {
    return _services.comments.where('post id', isEqualTo: postId).snapshots();
  }

  Future<void> toggleCommentLike(String commentId) async {
    try {
      User currentUser = _auth.currentUser!;
      DocumentSnapshot commentSnapshot =
          await _services.comments.doc(commentId).get();

      if (commentSnapshot.exists) {
        List<String> likes = List<String>.from(commentSnapshot['likes']);

        if (likes.contains(currentUser.uid)) {
          likes.remove(currentUser.uid);
        } else {
          likes.add(currentUser.uid);
        }

        await _services.comments.doc(commentId).update({'likes': likes});

        // await _appState.checkCommentLikeStatus(commentId);
        // await _appState.totalCommentLikesCount(commentId);
      }
    } catch (err) {
      print('Error toggling like/dislike: $err');
    }
  }
}

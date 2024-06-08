import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:school_app/features/comments/services/comment_services.dart';
import 'package:school_app/services/firebase_services.dart';
import 'package:school_app/state/app_state.dart';
import 'package:school_app/widgets/widgets.dart';

class CommentListView extends StatefulWidget {
  final DocumentSnapshot post;
  const CommentListView({super.key, required this.post});

  @override
  State<CommentListView> createState() => _CommentListViewState();
}

class _CommentListViewState extends State<CommentListView> {
  CommentService _commentService = CommentService();
  bool isLiked = false;
  late List<bool> isFavoriteList;
  FirebaseServices _services = FirebaseServices();
  ApplicationState appState = ApplicationState();
  Map<String, int> _commentLikeCounts = {};

  Future<void> _fetchData() async {
    QuerySnapshot querySnapshot = await _services.comments.get();
    List<DocumentSnapshot> documents = querySnapshot.docs;
    isFavoriteList = List.generate(documents.length, (index) => false);
    _commentLikeCounts = {};

    for (int i = 0; i < documents.length; i++) {
      bool isFavorite = await appState.checkCommentLikeStatus(documents[i].id);
      int totalLikes = await appState.totalCommentLikesCount(documents[i].id);
      setState(() {
        isFavoriteList[i] = isFavorite;
        _commentLikeCounts[documents[i].id] = totalLikes;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  // void likePost() {
  //   setState(() {
  //     isLiked = !isLiked;
  //   });
  // }

  Widget commentServiceWidget(String name, String logo, String text,
      String formattedDate, String commentId) {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: ht * 0.067,
              width: ht * 0.067,
              decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade400,
                    offset: Offset(1, 3),
                    blurRadius: 5)
              ]),
              child: ClipOval(
                child: logo == ""
                    ? Image.asset(
                        "assets/images/avatar1.png",
                        fit: BoxFit.cover,
                      )
                    : logo != null
                        ? CachedNetworkImage(
                            imageUrl: logo,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          )
                        : Image.asset(
                            "assets/images/avatar1.png",
                            fit: BoxFit.cover,
                          ),
              ),
            ),
            const SizedBox(width: 17),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer<ApplicationState>(builder: (context, appState, _) {
                  int totalLikes = appState.totalCommentLikes[commentId] ?? 0;
                  return SizedBox(
                    width: wd * 0.68,
                    child: Row(children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: wd * 0.32,
                              child: Text(
                                name,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.openSans(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              formattedDate,
                              style: GoogleFonts.openSans(
                                  color: Colors.grey.shade500,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600),
                            ),
                          ]),
                      Spacer(),
                      LikeTotalComment(
                          commentId: commentId,
                          totalLikes: _commentLikeCounts[commentId] ?? 0)
                    ]),
                  );
                }),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: ht * 0.14,
                  width: wd * 0.67,
                  child: Text(
                    text,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.openSans(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Divider(
          height: 35,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _commentService.getCommentsByPost(widget.post.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error in retrieving reviews: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No comment yet'),
            );
          } else {
            List<DocumentSnapshot> comments = snapshot.data!.docs;
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: comments.length,
              itemBuilder: (context, index) {
                DocumentSnapshot comment = comments[index];
                String commentId = comment.id;
                String name = comment['student name'];
                String logo = comment['student logo'];
                String text = comment['comment'];
                Timestamp timestamp = comment['creation date'];
                DateTime dateTime = timestamp.toDate();
                String formattedDate =
                    DateFormat('dd MMM, yyyy').format(dateTime);
                return commentServiceWidget(
                    name, logo, text, formattedDate, commentId);
              },
            );
          }
        });
  }
}

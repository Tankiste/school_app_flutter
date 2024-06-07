import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:school_app/features/auth/model/student.dart';
import 'package:school_app/features/comments/services/comment_services.dart';
import 'package:school_app/features/comments/views/comment_screen.dart';
import 'package:school_app/services/firebase_services.dart';
import 'package:school_app/state/app_state.dart';
import 'package:school_app/widgets/widgets.dart';

class PostListView extends StatefulWidget {
  const PostListView({super.key});

  @override
  State<PostListView> createState() => _PostListViewState();
}

class _PostListViewState extends State<PostListView> {
  bool isLiked = false;
  TextEditingController _commentController = TextEditingController();
  FirebaseServices _services = FirebaseServices();
  late List<bool> isFavoriteList;
  ApplicationState appState = ApplicationState();
  Map<String, int> _postLikeCounts = {};

  Future<void> _fetchData() async {
    QuerySnapshot querySnapshot = await _services.posts.get();
    List<DocumentSnapshot> documents = querySnapshot.docs;
    isFavoriteList = List.generate(documents.length, (index) => false);
    _postLikeCounts = {};

    for (int i = 0; i < documents.length; i++) {
      bool isFavorite = await appState.checkPostLikeStatus(documents[i].id);
      // appState.totalPostLikes[documents[i].id] =
      //     await appState.totalPostLikesCount(documents[i].id);
      int totalLikes = await appState.totalPostLikesCount(documents[i].id);
      // appState.fetchTotalPostLikes(documents[i].id);
      setState(() async {
        isFavoriteList[i] = isFavorite;
        _postLikeCounts[documents[i].id] = totalLikes;
      });
    }
  }

  // FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    // updateData();
    super.initState();
    _fetchData();
  }

  // void likePost() {
  //   setState(() {
  //     isLiked = !isLiked;
  //   });
  // }

  // @override
  // void dispose() {
  //   _focusNode.dispose();
  //   super.dispose();
  // }

  // updateData() async {
  //   ApplicationState appState = Provider.of(context, listen: false);
  //   await appState.refreshUser();
  // }

  void addComment(DocumentSnapshot post) async {
    if (_commentController.text.isNotEmpty) {
      String resp =
          await CommentService().addComment(post.id, _commentController.text);
      if (resp == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Comment published !'),
        ));
        _commentController.clear();
      }
    }
    // FocusScope.of(context).requestFocus(_focusNode);
  }

  String getTimeDifference(Timestamp timestamp) {
    DateTime now = DateTime.now();
    DateTime postDateTime = timestamp.toDate();

    Duration diff = now.difference(postDateTime);

    int hours = diff.inHours;
    int mins = diff.inMinutes.remainder(60);

    if (hours == 0) {
      return '${mins}min';
    } else {
      return '${hours}h ${mins}m';
    }
  }

  Widget serviceWidget(int index, DocumentSnapshot post) {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;
    StudentData? studentData =
        Provider.of<ApplicationState>(context, listen: false).getStudent;
    String? currentStudentLogo = studentData?.logo;

    String name = post['student name'];
    String promotion = post['student promotion'];
    String logo = post['student logo'];
    String description = post['description'];
    String image = post['image'];
    String latestComment = post['latest comment description'];
    String latestStudent = post['latest comment username'];
    Timestamp timestamp = post['creation date'];

    String timeDiff = getTimeDifference(timestamp);
    LikePost _likePost = LikePost(
      postId: post.id,
    );

    // void addComment() async {
    //   if (_commentController.text.isNotEmpty) {
    //     String resp =
    //         await CommentService().addComment(post.id, _commentController.text);
    //     if (resp == 'success') {
    //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //         content: Text('Comment published !'),
    //       ));
    //     }
    //   }
    // }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: ht * 0.32,
              width: wd,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  )),
            ),
            Positioned(
                left: 10,
                top: 7,
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: ht * 0.05,
                      width: wd * 0.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: logo != null
                            ? logo == ""
                                ? Image.asset(
                                    "assets/images/avatar1.png",
                                    fit: BoxFit.cover,
                                  )
                                : CachedNetworkImage(
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
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      height: ht * 0.056,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black26),
                      padding: EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: ht * 0.022,
                            width: wd * 0.18,
                            child: Text(
                              name,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.openSans(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: ht * 0.02,
                            width: wd * 0.2,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  promotion,
                                  style: GoogleFonts.openSans(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  timeDiff,
                                  overflow: TextOverflow.clip,
                                  style: GoogleFonts.openSans(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )),
            Positioned(
                top: 7,
                right: 10,
                child: SizedBox(
                  height: ht * 0.06,
                  width: wd * 0.09,
                  child: FloatingActionButton(
                    onPressed: () {},
                    heroTag: null,
                    backgroundColor: Colors.white38,
                    child: Icon(
                      FontAwesomeIcons.ellipsisVertical,
                      color: Colors.white,
                    ),
                  ),
                )),
            Positioned(
                right: 10,
                bottom: 7,
                child: Container(
                  height: ht * 0.052,
                  width: wd * 0.39,
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black26),
                  child: Consumer<ApplicationState>(
                      builder: (context, appState, _) {
                    // int totalLikes = appState.totalPostLikes[post.id] ?? 0;
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LikeTotalPost(
                            postId: post.id,
                            totalLikes: _postLikeCounts[post.id] ?? 0),
                        // LikePost(postId: post.id),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 2),
                        //   child: Text(
                        //     totalLikes.toString(),
                        //     style: GoogleFonts.openSans(
                        //         fontSize: 16,
                        //         color: Colors.white,
                        //         fontWeight: FontWeight.bold),
                        //   ),
                        // ),
                        SizedBox(
                          width: wd * 0.07,
                        ),
                        Icon(
                          FontAwesomeIcons.comment,
                          color: Colors.white,
                          size: 25,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            '57',
                            style: GoogleFonts.openSans(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    );
                  }),
                )),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 35,
          width: wd,
          child: RichText(
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              text: TextSpan(children: [
                TextSpan(
                    text: name,
                    style: GoogleFonts.openSans(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                TextSpan(
                  text: " $description",
                  style: GoogleFonts.openSans(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ])),
        ),
        SizedBox(
          height: 5,
        ),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => CommentScreen(
                          post: post,
                        )));
          },
          child: Text('View all comments',
              style: GoogleFonts.openSans(
                fontSize: 13,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w600,
              )),
        ),
        SizedBox(
          height: 3,
        ),
        SizedBox(
          height: 20,
          width: wd,
          child: RichText(
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              text: TextSpan(children: [
                TextSpan(
                    text: latestStudent,
                    style: GoogleFonts.openSans(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                TextSpan(
                  text: ' ${latestComment}',
                  style: GoogleFonts.openSans(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ])),
        ),
        SizedBox(
          height: 3,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: ClipOval(
                child: currentStudentLogo != null
                    ? currentStudentLogo == ""
                        ? Image.asset(
                            "assets/images/avatar1.png",
                            fit: BoxFit.cover,
                          )
                        : CachedNetworkImage(
                            imageUrl: currentStudentLogo,
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
            SizedBox(width: 10),
            Container(
              height: ht * 0.04,
              width: wd * 0.7,
              // decoration: BoxDecoration(
              //     shape: BoxShape.rectangle,
              //     borderRadius: BorderRadius.circular(10),
              //     border: Border.all(
              //       color: Colors.grey.shade300,
              //     )),
              child: TextField(
                controller: _commentController,
                // focusNode: _focusNode,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    hintText: 'Add a comment...',
                    // contentPadding:
                    //     EdgeInsets.only(left: 10, top: 5),
                    hintStyle: GoogleFonts.openSans(
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.w400,
                        fontSize: 13),
                    border: InputBorder.none),
                onSubmitted: (value) {
                  addComment(post);
                },
              ),
            ),
          ],
        ),
        Divider(
          height: 40,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder<QuerySnapshot>(
          stream: _services.posts.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('Something went wrong'),
              );
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text('No posts available'),
              );
            }

            final posts = snapshot.data!.docs;

            return ListView.builder(
              itemCount: posts.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                DocumentSnapshot post = posts[index];

                return serviceWidget(index, post);
              },
            );
          }),
    );
  }
}

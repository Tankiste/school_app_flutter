import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:school_app/features/comments/views/comment_screen.dart';
import 'package:school_app/services/firebase_services.dart';
import 'package:school_app/state/app_state.dart';
import 'package:school_app/widgets/widgets.dart';

class ResultPostSearch extends StatefulWidget {
  final DocumentSnapshot document;
  const ResultPostSearch({super.key, required this.document});

  @override
  State<ResultPostSearch> createState() => _ResultPostSearchState();
}

class _ResultPostSearchState extends State<ResultPostSearch> {
  bool isLiked = false;
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
      int totalLikes = await appState.totalPostLikesCount(documents[i].id);
      setState(() async {
        isFavoriteList[i] = isFavorite;
        _postLikeCounts[documents[i].id] = totalLikes;
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

  @override
  Widget build(BuildContext context) {
    var wd = MediaQuery.of(context).size.width;
    var ht = MediaQuery.of(context).size.height;
    String description = widget.document['description'];
    String image = widget.document['image'];
    String name = widget.document['student name'];
    String logo = widget.document['student logo'];
    String promotion = widget.document['student promotion'];
    Timestamp timestamp = widget.document['creation date'];
    String timeDiff = getTimeDifference(timestamp);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                    height: ht * 0.4,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      child: image != null
                          ? CachedNetworkImage(
                              imageUrl: image,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            )
                          : Image.asset(
                              'assets/images/brainstorming.jpg',
                              fit: BoxFit.cover,
                            ),
                    )),
                Positioned(
                    left: 15,
                    top: ht * 0.065,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: SizedBox(
                          height: ht * 0.045,
                          width: wd * 0.09,
                          child: ReturnButton()),
                    ))
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: ht * 0.05,
                            width: ht * 0.05,
                            decoration: BoxDecoration(shape: BoxShape.circle),
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
                          SizedBox(
                            width: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: ht * 0.026,
                                width: wd * 0.25,
                                child: Text(
                                  name,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.openSans(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: ht * 0.02,
                                width: wd * 0.1,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      promotion,
                                      style: GoogleFonts.openSans(
                                          fontSize: 13,
                                          color: Colors.grey.shade500,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Spacer(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LikeTotalPost(
                              postId: widget.document.id,
                              color: Colors.black,
                              favColor: Colors.black,
                              totalLikes:
                                  _postLikeCounts[widget.document.id] ?? 0),
                          SizedBox(
                            width: wd * 0.03,
                          ),
                          Icon(
                            FontAwesomeIcons.comment,
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
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: wd * 0.03,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: GestureDetector(
                                onTap: () {},
                                child: Icon(
                                    FontAwesomeIcons.solidShareFromSquare,
                                    size: 20)),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    timeDiff,
                    style: GoogleFonts.openSans(
                        fontSize: 15,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => CommentScreen(
                                    post: widget.document,
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
                    height: 10,
                  ),
                  Text(
                    'Description',
                    style: GoogleFonts.openSans(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(description,
                      style: GoogleFonts.openSans(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w400,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

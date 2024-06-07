import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_app/constants/constants.dart';
import 'package:school_app/features/posts/services/posts_services.dart';
import 'package:school_app/features/search/views/result_post_search.dart';
import 'package:school_app/state/app_state.dart';
import 'package:school_app/widgets/widgets.dart';

class SearchPostListView extends StatefulWidget {
  final bool showText;

  const SearchPostListView({super.key, required this.showText});

  @override
  State<SearchPostListView> createState() => _SearchPostListViewState();
}

class _SearchPostListViewState extends State<SearchPostListView> {
  bool isLiked = false;
  late List<DocumentSnapshot> documents;
  late List<bool> isFavoriteList;
  PostService _posts = PostService();
  ApplicationState appState = ApplicationState();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    documents = await _posts.getLikedPosts();
    isFavoriteList = List.generate(documents.length, (index) => false);

    for (int i = 0; i < documents.length; i++) {
      bool isLiked = await appState.checkPostLikeStatus(documents[i].id);
      setState(() {
        isFavoriteList[i] = isLiked;
      });
    }
  }

  // void likePost() {
  //   setState(() {
  //     isLiked = !isLiked;
  //   });
  // }

  Widget serviceWidget(DocumentSnapshot document) {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;
    String description = document['description'];
    String image = document['image'];
    String name = document['student name'];
    String logo = document['student logo'];
    String promotion = document['student promotion'];
    return Padding(
      padding: EdgeInsets.only(bottom: ht * 0.036),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) =>
                                ResultPostSearch(document: document))));
                  },
                  child: Container(
                    height: ht * 0.28,
                    width: wd,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
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
                              "assets/images/concept-cloud-ai.png",
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
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
                                width: wd * 0.2,
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
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )),
                Positioned(
                    right: 10,
                    bottom: 7,
                    child: Container(
                        height: ht * 0.05,
                        width: ht * 0.05,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.black38),
                        child: LikePost(postId: document.id))),
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
                      text: ' $description',
                      style: GoogleFonts.openSans(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                      ),
                    )
                  ])),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.showText)
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recently Liked Posts',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'Edit',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: buttonColor),
                    ))
              ],
            ),
          ),
        FutureBuilder<List<DocumentSnapshot>>(
            future: _posts.getLikedPosts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: Container(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator()));
              } else if (snapshot.hasError) {
                return Text('Error while loading data : ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No Liked Posts'));
              } else {
                List<DocumentSnapshot> documents = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: ListView.builder(
                    itemCount: documents.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      DocumentSnapshot document = documents[index];
                      return serviceWidget(document);
                    },
                  ),
                );
              }
            }),
      ],
    );
  }
}

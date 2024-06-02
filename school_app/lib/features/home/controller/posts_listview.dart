import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class PostListView extends StatefulWidget {
  const PostListView({super.key});

  @override
  State<PostListView> createState() => _PostListViewState();
}

class _PostListViewState extends State<PostListView> {
  bool isLiked = false;
  TextEditingController _commentController = TextEditingController();

  void likePost() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
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
                  child: Image.asset(
                    "assets/images/brainstorming.jpg",
                    fit: BoxFit.cover,
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
                          child: Image.asset("assets/images/supplier.png",
                              fit: BoxFit.cover),
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
                                "Davis Bryan",
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.openSans(
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: ht * 0.02,
                              width: wd * 0.18,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'O3',
                                    style: GoogleFonts.openSans(
                                        fontSize: 13,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    '11h',
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: likePost,
                          child: Icon(
                            isLiked
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                            color: isLiked ? Colors.red : Colors.white,
                            size: 28,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            '120',
                            style: GoogleFonts.openSans(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
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
                    ),
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
                      text: 'Davis Bryan',
                      style: GoogleFonts.openSans(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      )),
                  TextSpan(
                    text:
                        ' Wonderful experience with the upcoming technologies we tested',
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
            onTap: () {},
            child: Text('View all comments',
                style: GoogleFonts.openSans(
                  fontSize: 13,
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.w400,
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
                      text: 'Anthony James',
                      style: GoogleFonts.openSans(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      )),
                  TextSpan(
                    text: ' I appreciate the initiative, big up!',
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
                  child: Image.asset(
                    'assets/images/onboard.png',
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
                ),
              ),
            ],
          ),
          Divider(
            height: 40,
          )
        ],
      ),
    );
  }
}

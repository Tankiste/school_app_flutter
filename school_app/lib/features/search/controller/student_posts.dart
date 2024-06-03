import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_app/features/search/controller/search_post_listview.dart';
// import 'package:school_app/features/search/views/result_post_search.dart';

class StudentPosts extends StatefulWidget {
  const StudentPosts({super.key});

  @override
  State<StudentPosts> createState() => _StudentPostsState();
}

class _StudentPostsState extends State<StudentPosts> {
  bool isLiked = false;

  void likePost() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  Widget serviceWidget() {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;
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
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: ((context) => ResultPostSearch())));
                  },
                  child: Container(
                    height: ht * 0.28,
                    width: wd,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
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
                            child: Image.asset(
                              "assets/images/supplier.png",
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
                                width: wd * 0.1,
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
                      child: GestureDetector(
                        onTap: likePost,
                        child: Icon(
                          isLiked
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                          color: isLiked ? Colors.red : Colors.white,
                          size: 28,
                        ),
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
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 20),
      child: ListView.builder(
        itemCount: 3,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return serviceWidget();
        },
      ),
    );
  }
}

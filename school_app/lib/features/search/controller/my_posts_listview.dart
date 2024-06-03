import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_app/features/search/views/result_post_search.dart';

class StudentPostListView extends StatefulWidget {
  const StudentPostListView({super.key});

  @override
  State<StudentPostListView> createState() => _StudentPostListViewState();
}

class _StudentPostListViewState extends State<StudentPostListView> {
  bool isLiked = false;

  void likePost() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => ResultPostSearch())));
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
                    right: 10,
                    top: 10,
                    child: Container(
                      height: ht * 0.052,
                      width: ht * 0.052,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black38),
                      child: GestureDetector(
                        onTap: () {},
                        child: Icon(
                          FontAwesomeIcons.penToSquare,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    )),
                Positioned(
                    right: 10,
                    bottom: 7,
                    child: Container(
                      height: ht * 0.052,
                      width: ht * 0.052,
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
}

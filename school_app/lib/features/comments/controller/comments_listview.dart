import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:school_app/constants/constants.dart';

class CommentListView extends StatefulWidget {
  const CommentListView({super.key});

  @override
  State<CommentListView> createState() => _CommentListViewState();
}

class _CommentListViewState extends State<CommentListView> {
  bool isLiked = false;

  void likePost() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  Widget commentServiceWidget() {
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
                child: Image.asset(
                  "assets/images/supplier.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 17),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: wd * 0.68,
                  child: Row(children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: wd * 0.32,
                            child: Text(
                              "Arnold Ronald",
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
                            DateFormat("dd MMM, y").format(
                              DateTime.now(),
                            ),
                            style: GoogleFonts.openSans(
                                color: Colors.grey.shade500,
                                fontSize: 13,
                                fontWeight: FontWeight.w600),
                          ),
                        ]),
                    Spacer(),
                    GestureDetector(
                      onTap: likePost,
                      child: Icon(
                        isLiked
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color: isLiked ? Colors.red : Colors.grey.shade300,
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '120',
                      style: GoogleFonts.openSans(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: ht * 0.14,
                  width: wd * 0.67,
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean sed dolor non turpis euismod convallis. qsdf qs m qsdf mqsldkf msldjfqsldf jqsld jqsmdlfjqsdlfmjsqdlfsqdl f dsf",
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
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 6,
      itemBuilder: (context, index) {
        return commentServiceWidget();
      },
    );
  }
}

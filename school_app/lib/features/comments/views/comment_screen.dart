import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:school_app/constants/constants.dart';
import 'package:school_app/features/auth/model/student.dart';
import 'package:school_app/features/comments/controller/comments_listview.dart';
import 'package:school_app/features/comments/services/comment_services.dart';
import 'package:school_app/state/app_state.dart';
import 'package:school_app/widgets/widgets.dart';

class CommentScreen extends StatefulWidget {
  final DocumentSnapshot post;
  const CommentScreen({super.key, required this.post});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  TextEditingController _newCommentController = TextEditingController();
  bool isLoading = false;

  void addComment() async {
    if (_newCommentController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      String resp = await CommentService()
          .addComment(widget.post.id, _newCommentController.text);
      if (resp == 'success') {
        _newCommentController.clear();
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Comment published !'),
        ));
      }
    }
  }

  @override
  void initState() {
    updateData();
    super.initState();
  }

  updateData() async {
    ApplicationState appState = Provider.of(context, listen: false);
    await appState.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;
    StudentData? studentData =
        Provider.of<ApplicationState>(context, listen: false).getStudent;
    String? logo = studentData?.logo;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(25, ht * 0.07, 25, ht * 0.15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: ht * 0.045,
                        width: wd * 0.09,
                        child: ReturnButton()),
                    SizedBox(
                      height: ht * 0.06,
                    ),
                    Text(
                      'Comments',
                      style: GoogleFonts.openSans(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    CommentListView(
                      post: widget.post,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade300)),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Container(
                              height: ht * 0.056,
                              width: ht * 0.056,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
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
                                            placeholder: (context, url) =>
                                                Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          )
                                    : Image.asset(
                                        "assets/images/avatar1.png",
                                        fit: BoxFit.cover,
                                      ),
                              )),
                          SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                            width: wd * 0.65,
                            child: TextField(
                              minLines: 1,
                              maxLines: 10,
                              textAlign: TextAlign.left,
                              controller: _newCommentController,
                              decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  onTap: addComment,
                                  child: isLoading
                                      ? CircularProgressIndicator()
                                      : Icon(
                                          FontAwesomeIcons.solidPaperPlane,
                                          color: buttonColor,
                                          size: 25,
                                        ),
                                ),
                                // contentPadding: EdgeInsets.all(12),
                                hintText: 'Type your message...',
                                hintStyle: GoogleFonts.openSans(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade500,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(bottom: 10, left: 15, right: 15, child: FloatingBar())
        ],
      ),
    );
  }
}

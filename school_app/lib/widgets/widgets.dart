import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:school_app/constants/constants.dart';
import 'package:school_app/features/comments/services/comment_services.dart';
import 'package:school_app/features/posts/services/posts_services.dart';
import 'package:school_app/features/search/views/search_page.dart';
import 'package:school_app/pages/home_page.dart';
import 'package:school_app/state/app_state.dart';

class ReturnButton extends StatelessWidget {
  const ReturnButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: returnColor,
          padding: EdgeInsets.zero,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 20,
          color: Colors.black,
        ));
  }
}

class MainButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final double leftPadding;
  final double rightPadding;

  const MainButton(
      {super.key,
      required this.onPressed,
      required this.leftPadding,
      required this.rightPadding,
      required this.child});

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
        child: Padding(
            padding: EdgeInsets.only(
                left: leftPadding,
                right: rightPadding,
                top: ht * 0.02,
                bottom: ht * 0.02),
            child: child));
  }
}

class SearchBarItem extends StatelessWidget {
  const SearchBarItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 2,
              )
            ]),
        child: Padding(
          padding: EdgeInsets.only(top: 10, left: 18, bottom: 10, right: 15),
          child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        SearchPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      Animation<Offset> offsetAnimation = Tween<Offset>(
                        begin: const Offset(0.0, 1.0),
                        end: Offset.zero,
                      ).animate(CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeInOut,
                      ));
                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Search',
                    style: GoogleFonts.openSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Icon(
                    Icons.search,
                    color: Colors.grey.shade400,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

class Message {
  final String text;
  final DateTime date;
  final bool isSentByMe;

  const Message(
      {required this.text, required this.date, required this.isSentByMe});
}

class LikePost extends StatefulWidget {
  final String postId;

  const LikePost({Key? key, required this.postId}) : super(key: key);

  @override
  _LikePostState createState() => _LikePostState();
}

class _LikePostState extends State<LikePost> {
  ApplicationState appState = ApplicationState();
  PostService _postService = PostService();
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    _initLikeStatus();
  }

  Future<void> _initLikeStatus() async {
    bool liked = await appState.checkPostLikeStatus(widget.postId);
    setState(() {
      isLiked = liked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(builder: (context, appState, _) {
      // int totalLikes = appState.totalLike;

      return GestureDetector(
        onTap: () async {
          setState(() {
            isLiked = !isLiked;
          });
          await _postService.togglePostLike(widget.postId);
          await appState.checkPostLikeStatus(widget.postId);
          await appState.totalPostLikesCount(widget.postId);
        },
        child: Icon(
          isLiked ? Icons.favorite : Icons.favorite_border_outlined,
          color: isLiked ? Colors.red : Colors.white,
          size: 28,
        ),
      );
    });
  }
}

class LikeTotalPost extends StatefulWidget {
  final String postId;
  int totalLikes;

  LikeTotalPost({Key? key, required this.postId, required this.totalLikes})
      : super(key: key);

  @override
  _LikeTotalPostState createState() => _LikeTotalPostState();
}

class _LikeTotalPostState extends State<LikeTotalPost> {
  ApplicationState appState = ApplicationState();
  PostService _postService = PostService();
  bool isLiked = false;
  // int totalLikes = 0;

  @override
  void initState() {
    super.initState();
    _initLikeStatus();
  }

  Future<void> _initLikeStatus() async {
    bool liked = await appState.checkPostLikeStatus(widget.postId);
    int likesCount = await appState.totalPostLikesCount(widget.postId);
    setState(() {
      isLiked = liked;
      widget.totalLikes = likesCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(builder: (context, appState, _) {
      // int totalLikes = appState.totalLike;

      return GestureDetector(
        onTap: () async {
          setState(() {
            isLiked = !isLiked;
          });
          if (isLiked) {
            widget.totalLikes++;
          } else {
            widget.totalLikes--;
          }

          await _postService.togglePostLike(widget.postId);
          await appState.checkPostLikeStatus(widget.postId);
          await appState.totalPostLikesCount(widget.postId);
        },
        child: Row(
          children: [
            Icon(
              isLiked ? Icons.favorite : Icons.favorite_border_outlined,
              color: isLiked ? Colors.red : Colors.white,
              size: 28,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                widget.totalLikes.toString(),
                style: GoogleFonts.openSans(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class LikeComment extends StatefulWidget {
  final String commentId;

  const LikeComment({Key? key, required this.commentId}) : super(key: key);

  @override
  _LikeCommentState createState() => _LikeCommentState();
}

class _LikeCommentState extends State<LikeComment> {
  ApplicationState appState = ApplicationState();
  CommentService _commentService = CommentService();
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    _initLikeStatus();
  }

  Future<void> _initLikeStatus() async {
    bool liked = await appState.checkCommentLikeStatus(widget.commentId);
    setState(() {
      isLiked = liked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(builder: (context, appState, _) {
      // int totalLikes = appState.totalLike;

      return GestureDetector(
        onTap: () async {
          setState(() {
            isLiked = !isLiked;
          });
          await _commentService.toggleCommentLike(widget.commentId);
          await appState.checkCommentLikeStatus(widget.commentId);
          await appState.totalCommentLikesCount(widget.commentId);
        },
        child: Icon(
          isLiked ? Icons.favorite : Icons.favorite_border_outlined,
          color: isLiked ? Colors.red : Colors.grey.shade300,
          size: 28,
        ),
      );
    });
  }
}

class LikeTotalComment extends StatefulWidget {
  final String commentId;
  int totalLikes;

  LikeTotalComment(
      {Key? key, required this.commentId, required this.totalLikes})
      : super(key: key);

  @override
  _LikeTotalCommentState createState() => _LikeTotalCommentState();
}

class _LikeTotalCommentState extends State<LikeTotalComment> {
  ApplicationState appState = ApplicationState();
  CommentService _commentService = CommentService();
  bool isLiked = false;
  // int totalLikes = 0;

  @override
  void initState() {
    super.initState();
    _initLikeStatus();
  }

  Future<void> _initLikeStatus() async {
    bool liked = await appState.checkCommentLikeStatus(widget.commentId);
    int likesCount = await appState.totalCommentLikesCount(widget.commentId);
    setState(() {
      isLiked = liked;
      widget.totalLikes = likesCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(builder: (context, appState, _) {
      // int totalLikes = appState.totalLike;

      return GestureDetector(
        onTap: () async {
          setState(() {
            isLiked = !isLiked;
          });
          if (isLiked) {
            widget.totalLikes++;
          } else {
            widget.totalLikes--;
          }

          await _commentService.toggleCommentLike(widget.commentId);
          await appState.checkCommentLikeStatus(widget.commentId);
          await appState.totalCommentLikesCount(widget.commentId);
        },
        child: Row(
          children: [
            Icon(
              isLiked ? Icons.favorite : Icons.favorite_border_outlined,
              color: isLiked ? Colors.red : Colors.grey.shade300,
              size: 28,
            ),
            SizedBox(
              width: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                widget.totalLikes.toString(),
                style: GoogleFonts.openSans(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class FloatingBar extends StatefulWidget {
  const FloatingBar({super.key});

  @override
  State<FloatingBar> createState() => _FloatingBarState();
}

class _FloatingBarState extends State<FloatingBar> {
  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    return Consumer<ApplicationState>(builder: (context, appState, _) {
      return Container(
        height: ht * 0.097,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: GNav(
                color: buttonColor,
                selectedIndex: appState.currentIndex,
                activeColor: buttonColor,
                tabBackgroundColor: onboardColor,
                backgroundColor: Colors.white,
                gap: 10,
                textStyle: GoogleFonts.openSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: buttonColor),
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                tabBorderRadius: 15,
                // padding: EdgeInsets.all(10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                onTabChange: (index) {
                  appState.currentIndex = index;
                  switch (appState.currentIndex) {
                    case 0:
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
                      break;
                    case 1:
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
                      break;
                    case 2:
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
                      break;
                    default:
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
                      break;
                  }
                },
                tabs: [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: FontAwesomeIcons.solidMessage,
                    text: 'Chat',
                  ),
                  GButton(
                    icon: Icons.person,
                    text: 'Profile',
                  )
                ])),
      );
    });
  }
}

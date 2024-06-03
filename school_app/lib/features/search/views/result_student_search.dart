import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_app/constants/constants.dart';
import 'package:school_app/features/search/controller/about_student.dart';
import 'package:school_app/features/search/controller/student_comments.dart';
import 'package:school_app/features/search/controller/student_posts.dart';
import 'package:school_app/widgets/widgets.dart';

class ResultStudentSearch extends StatefulWidget {
  const ResultStudentSearch({super.key});

  @override
  State<ResultStudentSearch> createState() => _ResultStudentSearchState();
}

class _ResultStudentSearchState extends State<ResultStudentSearch>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  String selectedOption = 'About';
  String previousOption = 'About';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateSelectedOption(String option) {
    setState(() {
      selectedOption = option;
      if (option == 'About') {
        _animation = Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: const Offset(0.0, 0.0),
        ).animate(_controller);
      } else if (option == 'Posts') {
        _animation = Tween<Offset>(
          begin: previousOption == 'About'
              ? const Offset(0.0, 0.0)
              : const Offset(2.0, 0.0),
          end: const Offset(1.0, 0.0),
        ).animate(_controller);
      } else if (option == 'Comments') {
        _animation = Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: const Offset(2.0, 0.0),
        ).animate(_controller);
      }
      previousOption = option;
      _controller.forward(from: 0.0);
    });
  }

  Widget buildDivider() {
    return SlideTransition(
      position: _animation,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        child: Divider(
          height: 0,
          thickness: 2.0,
          color: buttonColor,
        ),
      ),
    );
  }

  Widget buildContent() {
    if (selectedOption == 'About') {
      return AboutStudent();
    } else if (selectedOption == 'Posts') {
      return StudentPosts();
    } else if (selectedOption == 'Comments') {
      return StudentComments();
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.only(
                    top: ht * 0.06, left: 10, bottom: ht * 0.15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: SizedBox(
                          height: ht * 0.045,
                          width: wd * 0.09,
                          child: ReturnButton()),
                    ),
                    SizedBox(
                      height: ht * 0.03,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Container(
                            width: ht * 0.14,
                            height: ht * 0.14,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                "assets/images/supplier.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text('Binho d.',
                              style: GoogleFonts.openSans(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ht * 0.035,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () => _updateSelectedOption('About'),
                          child: Text(
                            'About',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: selectedOption == 'About'
                                  ? buttonColor
                                  : Colors.black,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => _updateSelectedOption('Posts'),
                          child: Text(
                            'Posts',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: selectedOption == 'Posts'
                                  ? buttonColor
                                  : Colors.black,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => _updateSelectedOption('Comments'),
                          child: Text(
                            'Comments',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: selectedOption == 'Comments'
                                  ? buttonColor
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    buildDivider(),
                    const SizedBox(
                      height: 20,
                    ),
                    buildContent(),
                  ],
                ),
              )),
              Positioned(
                bottom: 15,
                right: 30,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: onboardColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.commentDots,
                        color: buttonColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Chat',
                        style: GoogleFonts.openSans(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: buttonColor),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}

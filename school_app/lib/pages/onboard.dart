import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_app/constants/constants.dart';
import 'package:school_app/features/auth/views/registration.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({super.key});

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.animateToPage(_currentPage + 1,
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      Navigator.push(context,
          CupertinoPageRoute(builder: ((context) => RegistrationPage())));
    }
  }

  List<Widget> _buildPageIndicators() {
    List<Widget> indicators = [];
    for (int i = 0; i < 3; i++) {
      indicators.add(
        i == _currentPage ? _indicator(true) : _indicator(false),
      );
    }
    return indicators;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 2),
      height: 5,
      width: isActive ? 40 : 12.0,
      decoration: BoxDecoration(
        color: isActive ? buttonColor : Colors.grey.shade300,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: onboardColor,
      body: Column(
        children: [
          Expanded(
              flex: 15,
              child: PageView(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                children: [
                  OnboardingPage(
                      image: 'assets/images/garcon1.png',
                      firstText: 'Keep In Touch With Your Student Entourage',
                      secondText:
                          'Engage in meaningful conversations and build connections with your colleagues.'),
                  OnboardingPage(
                      image: 'assets/images/garcon2.png',
                      firstText: 'Stay Updated with News on campus',
                      secondText:
                          'Stay informed with the latest news and announcements from the university.'),
                  OnboardingPage(
                      image: 'assets/images/fille.png',
                      firstText: 'Join University Events',
                      secondText:
                          'Participate in various events and activities organized by the university.'),
                ],
              )),
          Expanded(
            child: Container(
              height: ht * 0.02,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicators(),
              ),
            ),
          ),
          // SizedBox(
          //   height: ht * 0.004,
          // ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: wd * 0.1, vertical: ht * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: Row(
                    children: [
                      Text(
                        'Next',
                        style: GoogleFonts.openSans(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      // SizedBox(
                      //   width: wd * 0.001,
                      // ),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String image;
  final String firstText;
  final String secondText;

  const OnboardingPage(
      {super.key,
      required this.image,
      required this.firstText,
      required this.secondText});

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image,
            height: ht * 0.4, width: wd * 0.5, fit: BoxFit.contain),
        SizedBox(
          height: ht * 0.03,
        ),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ht * 0.04),
              child: Text(
                firstText,
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                    fontSize: 24, fontWeight: FontWeight.w900),
              ),
            ),
            SizedBox(
              height: ht * 0.01,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ht * 0.05),
              child: Text(
                secondText,
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                    fontSize: 14, fontWeight: FontWeight.w300),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

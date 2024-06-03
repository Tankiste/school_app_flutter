import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:school_app/constants/constants.dart';
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

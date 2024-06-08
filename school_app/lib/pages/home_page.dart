import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:school_app/constants/constants.dart';
import 'package:school_app/features/chats/views/inbox_page.dart';
import 'package:school_app/features/home/views/landing_page.dart';
import 'package:school_app/features/profile/views/profile.dart';
import 'package:school_app/state/app_state.dart';
import 'package:school_app/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<ApplicationState>(context);
    var ht = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          IndexedStack(
            index: appState.currentIndex,
            children: [
              LandingPage(),
              InboxPage(),
              ProfileScreen(),
            ],
          ),
          Positioned(
              bottom: 10,
              left: 15,
              right: 15,
              child: Container(
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        onTabChange: (index) {
                          setState(() {
                            appState.currentIndex = index;
                          });
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
              ))
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_app/constants/constants.dart';
import 'package:school_app/features/likes/views/favorite.dart';
import 'package:school_app/features/notifications/views/notifications.dart';
import 'package:school_app/features/profile/views/user_account.dart';
import 'package:school_app/pages/user_settings.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                top: ht * 0.065, left: 25, right: 25, bottom: ht * 0.16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      NotificationScreen())));
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: returnColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Icon(FontAwesomeIcons.solidBell,
                              size: 23, color: buttonColor),
                        ),
                      )),
                ),
                SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Container(
                        height: ht * 0.15,
                        width: ht * 0.15,
                        decoration:
                            BoxDecoration(shape: BoxShape.circle, boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            blurRadius: 5,
                            offset: Offset(2, 4),
                          ),
                        ]),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/supplier.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'John Doe',
                        style: GoogleFonts.openSans(
                            fontSize: 25, fontWeight: FontWeight.w800),
                      ),
                      // const SizedBox(
                      //   height: 5,
                      // ),
                      Text(
                        'johndoe@gmail.com',
                        style: GoogleFonts.openSans(
                            color: Colors.grey.shade500,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => FavoriteScreen())));
                  },
                  child: Row(
                    children: [
                      Container(
                        height: ht * 0.06,
                        width: ht * 0.063,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: returnColor),
                        child: Icon(
                          FontAwesomeIcons.solidHeart,
                          size: 20,
                          color: buttonColor,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        'Interests',
                        style: GoogleFonts.openSans(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Icon(
                        Icons.keyboard_arrow_right_rounded,
                        size: 30,
                        color: buttonColor,
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => UserAccount())));
                  },
                  child: Row(
                    children: [
                      Container(
                        height: ht * 0.06,
                        width: ht * 0.063,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: returnColor),
                        child: Icon(
                          FontAwesomeIcons.bookBookmark,
                          size: 20,
                          color: buttonColor,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        'My Posts',
                        style: GoogleFonts.openSans(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Icon(
                        Icons.keyboard_arrow_right_rounded,
                        size: 30,
                        color: buttonColor,
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => FavoriteScreen())));
                  },
                  child: Row(
                    children: [
                      Container(
                        height: ht * 0.06,
                        width: ht * 0.063,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: returnColor),
                        child: Icon(
                          FontAwesomeIcons.userGear,
                          size: 20,
                          color: buttonColor,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        'Account',
                        style: GoogleFonts.openSans(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Icon(
                        Icons.keyboard_arrow_right_rounded,
                        size: 30,
                        color: buttonColor,
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => FavoriteScreen())));
                  },
                  child: Row(
                    children: [
                      Container(
                        height: ht * 0.06,
                        width: ht * 0.063,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: returnColor),
                        child: Icon(
                          FontAwesomeIcons.gear,
                          size: 20,
                          color: buttonColor,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        'Settings',
                        style: GoogleFonts.openSans(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Icon(
                        Icons.keyboard_arrow_right_rounded,
                        size: 30,
                        color: buttonColor,
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => FavoriteScreen())));
                  },
                  child: Row(
                    children: [
                      Container(
                        height: ht * 0.06,
                        width: ht * 0.063,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: returnColor),
                        child: Icon(
                          FontAwesomeIcons.users,
                          size: 20,
                          color: buttonColor,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        'About Us',
                        style: GoogleFonts.openSans(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Icon(
                        Icons.keyboard_arrow_right_rounded,
                        size: 30,
                        color: buttonColor,
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => FavoriteScreen())));
                  },
                  child: Row(
                    children: [
                      Container(
                        height: ht * 0.06,
                        width: ht * 0.063,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFFFFE5E5)),
                        child: Icon(
                          Icons.logout_outlined,
                          size: 20,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        'Logout',
                        style: GoogleFonts.openSans(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      '1.0.0',
                      style: GoogleFonts.openSans(
                          fontSize: 12,
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

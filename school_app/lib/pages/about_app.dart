import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_app/constants/constants.dart';
import 'package:school_app/pages/policy.dart';
import 'package:school_app/pages/terms.dart';
import 'package:school_app/widgets/widgets.dart';

class AboutApp extends StatefulWidget {
  const AboutApp({super.key});

  @override
  State<AboutApp> createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
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
                      'About Us',
                      style: GoogleFonts.openSans(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: ht * 0.05,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: ((context) => TermsAndConditions())));
                      },
                      child: Row(
                        children: [
                          Text(
                            'Terms & Conditions',
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
                      height: 40,
                      color: Colors.grey.shade300,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: ((context) => PrivacyPolicy())));
                      },
                      child: Row(
                        children: [
                          Text(
                            'Privacy Policy',
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
                      height: 40,
                      color: Colors.grey.shade300,
                    ),
                  ]),
            ),
          ),
          Positioned(bottom: 10, left: 15, right: 15, child: FloatingBar())
        ],
      ),
    );
  }
}

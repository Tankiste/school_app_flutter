import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_app/features/posts/views/student_posts.dart';
import 'package:school_app/widgets/widgets.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  bool _hasFavorite = false;

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
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: ht * 0.07, bottom: ht * 0.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 25,
                        right: 25,
                      ),
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
                            'Interests',
                            style: GoogleFonts.openSans(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    _hasFavorite
                        ? StudentPosts()
                        : Padding(
                            padding: EdgeInsets.only(top: ht * 0.08),
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  'assets/svgs/undraw_different_love_a-3-rg.svg',
                                  width: wd * 0.58,
                                ),
                                SizedBox(
                                  height: ht * 0.05,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: wd * 0.15),
                                  child: Text(
                                    'Find all of your favorites posts here.',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.openSans(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: wd * 0.15),
                                  child: Text(
                                    'Explore the different posts published and like what most attracts you.',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.openSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                )
                              ],
                            ),
                          ),
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

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutStudent extends StatefulWidget {
  const AboutStudent({super.key});

  @override
  State<AboutStudent> createState() => _AboutStudentState();
}

class _AboutStudentState extends State<AboutStudent> {
  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(left: 7, right: 20),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(17, 15, 15, 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 5,
                    offset: Offset(0, 4))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bio',
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean sed dolor non turpis euismod convallis. Pellentesque lacinia mattis aliquet. Phasellus vitae dolor in ipsumt. Aliquam et elit auctor, semper justo vel, sagittis massa',
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.clip,
                  style: GoogleFonts.openSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: ht * 0.04,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(17, 17, 15, 18),
            width: 700,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 5,
                    offset: Offset(0, 4))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.solidUser,
                      size: 27,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Full Name',
                          style: GoogleFonts.openSans(
                              fontSize: 12,
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Binho de Brétagne',
                          style: GoogleFonts.openSans(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 23,
                ),
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.solidEnvelope,
                      size: 27,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email',
                          style: GoogleFonts.openSans(
                              fontSize: 12,
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'binho@2025.ucac-icam.com',
                          style: GoogleFonts.openSans(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 23,
                ),
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.venusMars,
                      size: 25,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Gender',
                          style: GoogleFonts.openSans(
                              fontSize: 12,
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Male',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.openSans(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 23,
                ),
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.solidFlag,
                      size: 25,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nationality',
                          style: GoogleFonts.openSans(
                              fontSize: 12,
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Cameroonian',
                          style: GoogleFonts.openSans(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 23,
                ),
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.peopleGroup,
                      size: 27,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Promotion',
                          style: GoogleFonts.openSans(
                              fontSize: 12,
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'X4',
                          style: GoogleFonts.openSans(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

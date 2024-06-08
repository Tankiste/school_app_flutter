import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentComments extends StatefulWidget {
  const StudentComments({super.key});

  @override
  State<StudentComments> createState() => _StudentCommentsState();
}

class _StudentCommentsState extends State<StudentComments> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 7, right: 20),
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 10, 15, 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 5,
                offset: Offset(1, 4))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total comments',
              style: GoogleFonts.openSans(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Icon(
                  FontAwesomeIcons.solidComment,
                  color: Colors.grey.shade600,
                  size: 20,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Has 47 comments',
                  style: GoogleFonts.openSans(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

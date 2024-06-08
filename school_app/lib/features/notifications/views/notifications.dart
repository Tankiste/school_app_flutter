import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_app/features/notifications/controller/notifications_listview.dart';
import 'package:school_app/widgets/widgets.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
                      'Notifications',
                      style: GoogleFonts.openSans(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    NotificationListView(),
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

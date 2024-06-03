import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:school_app/constants/constants.dart';
import 'package:school_app/features/chats/views/chat_screen.dart';

class InboxPage extends StatefulWidget {
  const InboxPage({super.key});

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  bool _hasMessages = false;

  Widget messageServiceWidget() {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: InkWell(
        onTap: () {
          setState(() {
            Navigator.push(context,
                CupertinoPageRoute(builder: (context) => ChatScreen()));
          });
        },
        child: Container(
          width: wd * 0.7,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  blurRadius: 3,
                  offset: Offset(1, 2),
                ),
              ]),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 17),
          child: Row(
            children: [
              Container(
                width: ht * 0.057,
                height: ht * 0.057,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    "assets/images/onboard.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 13,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Fonkou Thovin",
                    style: GoogleFonts.openSans(
                        fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  SizedBox(
                    height: ht * 0.025,
                    width: wd * 0.56,
                    child: Text(
                      "When can we meet up for an interview?",
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.openSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  )
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    DateFormat('HH:mm').format(DateTime.now()),
                    style: GoogleFonts.openSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade400),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Container(
                    height: ht * 0.019,
                    width: ht * 0.019,
                    decoration: BoxDecoration(
                      color: buttonColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(top: ht * 0.07, left: 20, right: 20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  'assets/images/logo.png',
                  scale: 1.6,
                ),
              ),
              SizedBox(
                height: ht * 0.05,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Chat Box',
                  style: GoogleFonts.lexend(
                      fontSize: 30, fontWeight: FontWeight.w600),
                ),
              ),
              Divider(),
              _hasMessages
                  ? Padding(
                      padding: EdgeInsets.only(top: ht * 0.09),
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            'assets/svgs/undraw_writer_q06d.svg',
                            width: wd * 0.65,
                          ),
                          SizedBox(
                            height: ht * 0.06,
                          ),
                          Text(
                            'No messages yet',
                            style: GoogleFonts.openSans(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: wd * 0.1),
                            child: Text(
                              'You will find your various exchange with your camarades here. Send your first message.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: 3,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: ((context, index) {
                        return messageServiceWidget();
                      }))
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:school_app/constants/constants.dart';
import 'package:school_app/features/auth/model/student.dart';
import 'package:school_app/features/auth/services/student_service.dart';
import 'package:school_app/features/chats/model/chat_service.dart';
import 'package:school_app/features/chats/views/chat_screen.dart';
import 'package:school_app/features/posts/services/posts_services.dart';
import 'package:school_app/widgets/widgets.dart';

class InboxPage extends StatefulWidget {
  const InboxPage({super.key});

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  bool _hasMessages = false;
  Chats _chats = Chats();
  PostService _postService = PostService();
  StudentService _studentService = StudentService();

  Widget messageServiceWidget(int index, StudentData senderData,
      DocumentSnapshot document, Message latestMessage) {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;
    String? logoUrl = senderData.logo;

    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: InkWell(
        onTap: () {
          setState(() {
            // Navigator.push(context,
            //     CupertinoPageRoute(builder: (context) => ChatScreen()));
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
                  child: logoUrl != null
                      ? logoUrl == ""
                          ? Image.asset(
                              "assets/images/avatar1.png",
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
                              imageUrl: logoUrl,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            )
                      : Image.asset(
                          "assets/images/avatar1.png",
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
                    senderData.name,
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
                      latestMessage.text,
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
      backgroundColor: Colors.white,
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
                  : FutureBuilder<List<DocumentSnapshot>>(
                      future: _chats.getStudentChats(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: Container(
                              height: 50,
                              width: 50,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Padding(
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
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: wd * 0.1),
                                  child: Text(
                                    'You will find your various exchange with your camarades here. Send your first message.',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.openSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                )
                              ],
                            ),
                          );
                        } else if (snapshot.hasData) {
                          List<DocumentSnapshot> documents = snapshot.data!;
                          return Padding(
                            padding: const EdgeInsets.only(
                                bottom: 100, left: 20, top: 15),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: documents.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        DocumentSnapshot document =
                                            documents[index];
                                        String senderId = document['sender id'];
                                        String chatId = document['chat id'];
                                        return FutureBuilder<StudentData?>(
                                            future: _studentService
                                                .getStudent(senderId),
                                            builder: (context, userSnapshot) {
                                              if (userSnapshot
                                                      .connectionState ==
                                                  ConnectionState.waiting) {
                                                return Center(
                                                  child: Container(
                                                    height: 50,
                                                    width: 50,
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                );
                                              } else if (userSnapshot.hasData) {
                                                StudentData clientData =
                                                    userSnapshot.data!;
                                                return FutureBuilder<
                                                        List<Message>>(
                                                    future:
                                                        _chats.getLatestMessage(
                                                            chatId),
                                                    builder: (context,
                                                        messageSnapshot) {
                                                      if (messageSnapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting) {
                                                        return Center(
                                                          child: Container(
                                                            height: 50,
                                                            width: 50,
                                                            child:
                                                                CircularProgressIndicator(),
                                                          ),
                                                        );
                                                      } else if (messageSnapshot
                                                          .hasData) {
                                                        Message latestMessage =
                                                            messageSnapshot
                                                                .data![0];
                                                        return messageServiceWidget(
                                                            index,
                                                            clientData,
                                                            document,
                                                            latestMessage);
                                                      } else {
                                                        return Container();
                                                      }
                                                    });
                                              } else {
                                                return Container();
                                              }
                                            });
                                      }),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      })
            ],
          ),
        ),
      ),
    );
  }
}

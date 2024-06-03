import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:school_app/constants/constants.dart';
import 'package:school_app/widgets/widgets.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Message> messages = [
    Message(
        text: 'Hi',
        date: DateTime.now().subtract(Duration(days: 3, minutes: 2)),
        isSentByMe: false),
    Message(
        text: 'Yeah',
        date: DateTime.now().subtract(Duration(days: 3, minutes: 3)),
        isSentByMe: true),
    Message(
        text: 'You good?',
        date: DateTime.now().subtract(Duration(days: 2, minutes: 4)),
        isSentByMe: false),
    Message(
        text: 'Yes',
        date: DateTime.now().subtract(Duration(minutes: 3)),
        isSentByMe: true),
    Message(
        text: 'What about you?',
        date: DateTime.now().subtract(Duration(minutes: 1)),
        isSentByMe: true),
    Message(
        text: 'I\'m doing great pam.',
        date: DateTime.now().subtract(Duration(minutes: 1)),
        isSentByMe: false),
  ].reversed.toList();
  final TextEditingController _messagecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: ht * 0.058),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: SizedBox(
                  height: ht * 0.045, width: wd * 0.09, child: ReturnButton()),
            ),
            SizedBox(
              height: ht * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 17, vertical: 12),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 5,
                          offset: Offset(0, 3))
                    ]),
                child: Row(
                  children: [
                    Container(
                      width: ht * 0.06,
                      height: ht * 0.06,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          "assets/images/supplier.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 17),
                    SizedBox(
                      height: ht * 0.029,
                      width: wd * 0.3,
                      child: Text("Binho De Brétagne",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.openSans(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: ht * 0.045,
                            width: ht * 0.045,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: returnColor),
                            child: Icon(
                              Icons.phone,
                              color: buttonColor,
                              size: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: ht * 0.045,
                            width: ht * 0.045,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: returnColor),
                            child: Icon(
                              Icons.videocam_rounded,
                              color: buttonColor,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                child: GroupedListView<Message, DateTime>(
              padding: const EdgeInsets.all(8),
              reverse: true,
              order: GroupedListOrder.DESC,
              useStickyGroupSeparators: true,
              floatingHeader: true,
              elements: messages,
              groupBy: (message) => DateTime(
                message.date.year,
                message.date.month,
                message.date.day,
              ),
              groupHeaderBuilder: (Message message) => SizedBox(
                  height: ht * 0.054,
                  child: Center(
                      child: Card(
                          shape: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade200)),
                          elevation: 0,
                          color: Colors.white,
                          child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                DateFormat.yMMMd().format(message.date),
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade600),
                              ))))),
              itemBuilder: (context, Message message) => Align(
                alignment: message.isSentByMe
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Padding(
                  padding: message.isSentByMe
                      ? EdgeInsets.fromLTRB(100, 5, 20, 5)
                      : EdgeInsets.fromLTRB(20, 5, 100, 5),
                  child: Column(
                    crossAxisAlignment: message.isSentByMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Card(
                          color: message.isSentByMe
                              ? messageColor
                              : Color(0xFFF2F2F2),
                          shadowColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: message.isSentByMe
                                  ? BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.zero,
                                      bottomLeft: Radius.circular(12),
                                      bottomRight: Radius.circular(12))
                                  : BorderRadius.only(
                                      topLeft: Radius.zero,
                                      topRight: Radius.circular(12),
                                      bottomLeft: Radius.circular(12),
                                      bottomRight: Radius.circular(12))),
                          elevation: 8,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              message.text,
                              style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.w500, fontSize: 15),
                            ),
                          )),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        DateFormat("hh:mm").format(DateTime.now()),
                        style: GoogleFonts.openSans(
                            color: Colors.grey.shade400,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: ht * 0.065,
                      width: ht * 0.065,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade200)),
                      child: Center(
                        child: Icon(
                          Icons.add,
                          color: buttonColor,
                          size: 37,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: ht * 0.065,
                      width: ht * 0.065,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade200)),
                      child: Center(
                        child: Icon(
                          Icons.mic,
                          color: buttonColor,
                          size: 33,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Container(
                      height: ht * 0.065,
                      width: wd * 0.6,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade200),
                          borderRadius: BorderRadius.circular(8)),
                      child: TextField(
                        minLines: 1,
                        maxLines: 10,
                        textAlign: TextAlign.left,
                        controller: _messagecontroller,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              final message = Message(
                                  text: _messagecontroller.text,
                                  date: DateTime.now(),
                                  isSentByMe: true);

                              setState(() {
                                messages.add(message);
                                _messagecontroller.clear();
                              });
                            },
                            child: Icon(
                              FontAwesomeIcons.solidPaperPlane,
                              color: buttonColor,
                              size: 25,
                            ),
                          ),
                          contentPadding: EdgeInsets.all(12),
                          hintText: 'Type your message...',
                          hintStyle: GoogleFonts.openSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade500,
                          ),
                          border: InputBorder.none,
                        ),
                      )),
                  // Container(
                  //   padding: EdgeInsets.all(3),
                  //   decoration: BoxDecoration(
                  //     color: Colors.black,
                  //     shape: BoxShape.circle,
                  //   ),
                  //   child: IconButton(
                  //       onPressed: () async {
                  //         final message = Message(
                  //             text: _messagecontroller.text,
                  //             date: DateTime.now(),
                  //             isSentByMe: true);

                  //         setState(() {
                  //           messages.add(message);
                  //           _messagecontroller.clear();
                  //         });
                  //       },
                  //       icon: Icon(
                  //         FontAwesomeIcons.solidPaperPlane,
                  //         color: Colors.white,
                  //         size: 30,
                  //       )),
                  // )
                ],
              ),
            ),
            const SizedBox(height: 15)
          ],
        ),
      ),
    );
  }
}

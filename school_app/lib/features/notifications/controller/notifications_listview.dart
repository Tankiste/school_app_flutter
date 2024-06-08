import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationListView extends StatefulWidget {
  const NotificationListView({super.key});

  @override
  State<NotificationListView> createState() => _NotificationListViewState();
}

class _NotificationListViewState extends State<NotificationListView> {
  Widget serviceNotificationWidget() {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: ht * 0.075,
                height: ht * 0.075,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey, blurRadius: 5, offset: Offset(0, 4))
                  ],
                ),
                child: ClipOval(
                    child: Image.asset(
                  'assets/images/supplier.png',
                  fit: BoxFit.cover,
                )),
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: ht * 0.05,
                    width: wd * 0.67,
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: 'Arnold Ronald',
                          style: GoogleFonts.openSans(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          )),
                      TextSpan(
                        text: ' Commented on your post',
                        style: GoogleFonts.openSans(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ])),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Just Now',
                    style: GoogleFonts.openSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Divider(
            height: 40,
            indent: 60,
            endIndent: 15,
            color: Colors.grey.shade300,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (context, index) {
        return serviceNotificationWidget();
      },
    );
  }
}

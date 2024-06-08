import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:school_app/constants/constants.dart';
import 'package:school_app/features/search/views/result_post_search.dart';
import 'package:school_app/widgets/widgets.dart';

class StudentPostListView extends StatefulWidget {
  const StudentPostListView({super.key});

  @override
  State<StudentPostListView> createState() => _StudentPostListViewState();
}

class _StudentPostListViewState extends State<StudentPostListView> {
  bool isLiked = false;
  File? image;
  String? fileName;

  void likePost() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  Future<bool> requestGalleryPermission() async {
    final status = await Permission.storage.status;
    debugPrint("storage permission $status");
    if (status.isDenied) {
      debugPrint("storage permission === $status");
      final granted = await Permission.storage.request();
      return granted.isGranted;
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
      return false;
    } else {
      return true;
    }
  }

  Future pickImage() async {
    final hasPermission = await requestGalleryPermission();
    if (!hasPermission) {
      return null;
    }
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        image = File(result.files.single.path!);
        fileName = result.files.first.name;
      });
    } else {
      print('No Image Selected');
    }
  }

  Widget buildComment() {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 5,
            width: wd * 0.17,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(9),
            ),
          ),
          SizedBox(
            height: ht * 0.03,
          ),
          Text(
            'Wish to update your Post?',
            style: GoogleFonts.openSans(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: ht * 0.035),
          InkWell(
            onTap: () {
              pickImage();
            },
            child: image == null
                ? Container(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                    height: ht * 0.2,
                    width: wd * 0.85,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: onboardColor),
                    child: Column(
                      children: [
                        Icon(
                          FontAwesomeIcons.image,
                          color: buttonColor,
                          size: 50,
                        ),
                        SizedBox(
                          height: ht * 0.02,
                        ),
                        Text(
                          'Choose a Photo or a video',
                          style: GoogleFonts.openSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: buttonColor),
                        )
                      ],
                    ),
                  )
                : Image.file(
                    image!,
                    width: wd * 0.85,
                    height: ht * 0.2,
                    fit: BoxFit.cover,
                  ),
          ),
          SizedBox(
            height: ht * 0.035,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Container(
              height: ht * 0.18,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey.shade300,
                  )),
              child: TextFormField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    hintText: "Enter your text here...",
                    contentPadding:
                        EdgeInsets.only(left: 10, right: 5, bottom: 5),
                    hintStyle: GoogleFonts.openSans(
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w300,
                        fontSize: 15),
                    border: InputBorder.none),
              ),
            ),
          ),
          SizedBox(
            height: ht * 0.03,
          ),
          MainButton(
              onPressed: () {
                Navigator.pop(context);
              },
              leftPadding: wd * 0.35,
              rightPadding: wd * 0.35,
              child: Text(
                'Post',
                style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              )),
          SizedBox(
            height: ht * 0.04,
          )
        ],
      ),
    );
  }

  Widget servicePostWidget() {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(bottom: ht * 0.036),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                InkWell(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: ((context) => ResultPostSearch())));
                  },
                  child: Container(
                    height: ht * 0.28,
                    width: wd,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        "assets/images/concept-cloud-ai.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                    right: 10,
                    top: 10,
                    child: Container(
                      height: ht * 0.052,
                      width: ht * 0.052,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black38),
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(30))),
                              builder: ((context) {
                                return buildComment();
                              }));
                        },
                        child: Icon(
                          FontAwesomeIcons.penToSquare,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    )),
                Positioned(
                    right: 10,
                    bottom: 7,
                    child: Container(
                      height: ht * 0.052,
                      width: ht * 0.052,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black38),
                      child: GestureDetector(
                        onTap: likePost,
                        child: Icon(
                          isLiked
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                          color: isLiked ? Colors.red : Colors.white,
                          size: 28,
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 35,
              width: wd,
              child: RichText(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  text: TextSpan(children: [
                    TextSpan(
                        text: 'Davis Bryan',
                        style: GoogleFonts.openSans(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                    TextSpan(
                      text:
                          ' Wonderful experience with the upcoming technologies we tested',
                      style: GoogleFonts.openSans(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                      ),
                    )
                  ])),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 20),
      child: ListView.builder(
          itemCount: 3,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return servicePostWidget();
          }),
    );
  }
}

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:school_app/constants/constants.dart';
import 'package:school_app/features/search/controller/about_student.dart';
import 'package:school_app/features/search/controller/my_posts_listview.dart';
import 'package:school_app/features/search/controller/student_comments.dart';
import 'package:school_app/widgets/widgets.dart';

class UserAccount extends StatefulWidget {
  final String initialSelectedOption;
  final String initialPreviousOption;
  const UserAccount(
      {super.key,
      required this.initialSelectedOption,
      required this.initialPreviousOption});

  @override
  State<UserAccount> createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  late String selectedOption;
  late String previousOption;
  File? image;
  String? fileName;

  @override
  void initState() {
    super.initState();
    selectedOption = widget.initialSelectedOption;
    previousOption = widget.initialPreviousOption;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    if (selectedOption == 'About') {
      _animation = Tween<Offset>(
        begin: const Offset(0.0, 0.0),
        end: const Offset(0.0, 0.0),
      ).animate(_controller);
    } else if (selectedOption == 'Posts') {
      _animation = Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: const Offset(1.0, 0.0),
      ).animate(_controller);
    } else if (selectedOption == 'Comments') {
      _animation = Tween<Offset>(
        begin: const Offset(2.0, 0.0),
        end: const Offset(2.0, 0.0),
      ).animate(_controller);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateSelectedOption(String option) {
    setState(() {
      selectedOption = option;
      if (option == 'About') {
        _animation = Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: const Offset(0.0, 0.0),
        ).animate(_controller);
      } else if (option == 'Posts') {
        _animation = Tween<Offset>(
          begin: previousOption == 'About'
              ? const Offset(0.0, 0.0)
              : const Offset(2.0, 0.0),
          end: const Offset(1.0, 0.0),
        ).animate(_controller);
      } else if (option == 'Comments') {
        _animation = Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: const Offset(2.0, 0.0),
        ).animate(_controller);
      }
      previousOption = option;
      _controller.forward(from: 0.0);
    });
  }

  Widget buildDivider() {
    return SlideTransition(
      position: _animation,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        child: Divider(
          height: 0,
          thickness: 2.0,
          color: buttonColor,
        ),
      ),
    );
  }

  Widget buildContent() {
    if (selectedOption == 'About') {
      return AboutStudent();
    } else if (selectedOption == 'Posts') {
      return StudentPostListView();
    } else if (selectedOption == 'Comments') {
      return StudentComments();
    }
    return Container();
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

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.only(
                    top: ht * 0.06, left: 10, bottom: ht * 0.15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: SizedBox(
                          height: ht * 0.045,
                          width: wd * 0.09,
                          child: ReturnButton()),
                    ),
                    SizedBox(
                      height: ht * 0.03,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                  height: ht * 0.15,
                                  width: wd * 0.34,
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: image == null
                                          ? Image.asset(
                                              "assets/images/supplier.png",
                                              fit: BoxFit.cover,
                                            )
                                          : Image.file(
                                              image!,
                                              width: 105,
                                              height: 120,
                                              fit: BoxFit.cover,
                                            ))),
                              Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(7),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.shade400,
                                              blurRadius: 10,
                                              offset: Offset(1, 3))
                                        ]),
                                    child: InkWell(
                                      onTap: () {
                                        pickImage();
                                      },
                                      child: Icon(
                                        FontAwesomeIcons.pen,
                                        size: 20,
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Upload image',
                            style: GoogleFonts.openSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ht * 0.035,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () => _updateSelectedOption('About'),
                          child: Text(
                            'About',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: selectedOption == 'About'
                                  ? buttonColor
                                  : Colors.black,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => _updateSelectedOption('Posts'),
                          child: Text(
                            'Posts',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: selectedOption == 'Posts'
                                  ? buttonColor
                                  : Colors.black,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => _updateSelectedOption('Comments'),
                          child: Text(
                            'Comments',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: selectedOption == 'Comments'
                                  ? buttonColor
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    buildDivider(),
                    const SizedBox(
                      height: 20,
                    ),
                    buildContent(),
                  ],
                ),
              )),
              Positioned(bottom: 10, left: 15, right: 15, child: FloatingBar())
            ],
          )),
    );
  }
}

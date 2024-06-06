import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:school_app/constants/constants.dart';
import 'package:school_app/features/auth/model/student.dart';
import 'package:school_app/features/auth/services/student_service.dart';
import 'package:school_app/features/profile/controller/about_stud_controller.dart';
import 'package:school_app/features/posts/views/my_posts_listview.dart';
import 'package:school_app/features/search/controller/student_comments.dart';
import 'package:school_app/state/app_state.dart';
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
  final GlobalKey<AboutStudentControllerState> _aboutStudentKey =
      GlobalKey<AboutStudentControllerState>();
  late AnimationController _controller;
  late Animation<Offset> _animation;
  late String selectedOption;
  late String previousOption;
  File? image;
  String? fileName;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    updateData();
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

  updateData() async {
    ApplicationState appState = Provider.of(context, listen: false);
    await appState.refreshUser();
  }

  void updateAccount() async {
    setState(() {
      isLoading = true;
    });
    String bio = _aboutStudentKey.currentState?.bio ?? "";
    String resp = await StudentService().updateAccount(
      bio: bio,
      logo: image,
    );

    if (resp == 'success') {
      print('My bio is $bio');
      await Fluttertoast.showToast(
          msg: 'Your informations have been updated successfully !',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: messageColor,
          fontSize: 16);
      setState(() {
        isLoading = false;
      });
    }
    Navigator.pop(context);
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
      return AboutStudentController(key: _aboutStudentKey);
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
    StudentData? studentData = Provider.of<ApplicationState>(context).getUser;
    String? logoUrl = studentData?.logo;

    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
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
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    backgroundColor: returnColor,
                                    padding: EdgeInsets.zero,
                                  ),
                                  onPressed: () {
                                    updateAccount();
                                  },
                                  child: Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    size: 20,
                                    color: Colors.black,
                                  ))),
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
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: image == null
                                              ? logoUrl != null
                                                  ? logoUrl == ""
                                                      ? Image.asset(
                                                          'assets/images/avatar.png',
                                                          fit: BoxFit.cover,
                                                        )
                                                      : CachedNetworkImage(
                                                          imageUrl: logoUrl,
                                                          fit: BoxFit.cover,
                                                          placeholder:
                                                              (context, url) =>
                                                                  Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(Icons.error),
                                                        )
                                                  : Image.asset(
                                                      "assets/images/avatar.png",
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
                                            borderRadius:
                                                BorderRadius.circular(7),
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
                              onPressed: () =>
                                  _updateSelectedOption('Comments'),
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
                  Positioned(
                      bottom: 10, left: 15, right: 15, child: FloatingBar())
                ],
              )),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_app/constants/constants.dart';
import 'package:school_app/features/search/controller/search_post_listview.dart';
import 'package:school_app/features/search/controller/search_students_listview.dart';
import 'package:school_app/features/search/views/result_post_search.dart';
import 'package:school_app/features/search/views/result_student_search.dart';
import 'package:school_app/services/firebase_services.dart';
import 'package:school_app/widgets/widgets.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  FirebaseServices _services = FirebaseServices();
  late AnimationController _controller;
  late Animation<Offset> _animation;
  String selectedOption = 'Posts';
  String _post = "";
  bool _showInitialView = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateSelectedOption(String option) {
    setState(() {
      selectedOption = option;
      if (option == 'Posts') {
        _animation = Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: const Offset(0.0, 0.0),
        ).animate(_controller);
      } else {
        _animation = Tween<Offset>(
          begin: const Offset(0.0, 0.0),
          end: const Offset(1.0, 0.0),
        ).animate(_controller);
      }
      _controller.forward(from: 0.0);
    });
  }

  Widget buildDivider() {
    return SlideTransition(
      position: _animation,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Divider(
          height: 0,
          thickness: 2.0,
          color: buttonColor,
        ),
      ),
    );
  }

  // Widget buildContent() {
  //   if (selectedOption == 'Posts') {
  //     return SearchPostListView();
  //   } else {
  //     return SearchStudentListView();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 20, top: 60),
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
                height: ht * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 30),
                child: SizedBox(
                  height: ht * 0.03,
                  width: wd * 0.62,
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        hintText: 'Search a Post...',
                        hintStyle: GoogleFonts.lexend(
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade500,
                        )),
                    onChanged: (value) {
                      setState(() {
                        _post = value;
                        _showInitialView = false;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => _updateSelectedOption('Posts'),
                    child: Text(
                      'Posts',
                      style: GoogleFonts.lexend(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: selectedOption == 'Posts'
                            ? buttonColor
                            : Colors.grey.shade500,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => _updateSelectedOption('Students'),
                    child: Text(
                      'Students',
                      style: GoogleFonts.lexend(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: selectedOption == 'Students'
                            ? buttonColor
                            : Colors.grey.shade500,
                      ),
                    ),
                  ),
                ],
              ),
              buildDivider(),
              // buildContent(),
              (selectedOption == 'Posts')
                  ? StreamBuilder<QuerySnapshot>(
                      stream: _services.posts.snapshots(),
                      builder: (context, snapshot) {
                        if (_post.isEmpty) {
                          return SearchPostListView(
                            showText: true,
                          );
                        } else if (snapshot.hasError) {
                          return Text(
                              'Something went wrong : ${snapshot.error}');
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var data = snapshot.data!.docs[index];
                              if (data['description']
                                  .toString()
                                  .toLowerCase()
                                  .contains(_post)) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  ResultPostSearch())));
                                    },
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.search_outlined,
                                                    size: 20,
                                                    color: Colors.grey.shade400,
                                                  ),
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  SizedBox(
                                                      width: wd * 0.7,
                                                      child: Text(
                                                        data['description'],
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      )),
                                                ],
                                              ),
                                            ),
                                            Icon(
                                              Icons.call_made_outlined,
                                              size: 20,
                                              color: Colors.grey.shade400,
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Divider(
                                          color: Colors.grey.shade300,
                                          indent: 10,
                                          endIndent: 10,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }
                              return Container();
                            },
                          );
                        }
                      },
                    )
                  : StreamBuilder<QuerySnapshot>(
                      stream: _services.users.snapshots(),
                      builder: (context, snapshot) {
                        if (_post.isEmpty) {
                          return SearchStudentListView();
                        } else if (snapshot.hasError) {
                          return Text(
                              'Something went wrong : ${snapshot.error}');
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var data = snapshot.data!.docs[index];
                              if (data['Full Name']
                                  .toString()
                                  .toLowerCase()
                                  .contains(_post)) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  ResultStudentSearch())));
                                    },
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title: Text(data['Full Name'],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18)),
                                          leading: CircleAvatar(
                                            backgroundImage:
                                                NetworkImage(data['Logolink']),
                                          ),
                                        ),
                                        // const SizedBox(
                                        //   height: 5,
                                        // ),
                                        Divider(
                                          color: Colors.grey.shade300,
                                          indent: 10,
                                          endIndent: 10,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }
                              return Container();
                            },
                          );
                        } else {
                          return Container();
                        }
                      },
                    )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_app/constants/constants.dart';
import 'package:school_app/features/search/views/result_student_search.dart';

class SearchStudentListView extends StatefulWidget {
  const SearchStudentListView({super.key});

  @override
  State<SearchStudentListView> createState() => _SearchStudentListViewState();
}

class _SearchStudentListViewState extends State<SearchStudentListView> {
  Widget serviceWidget() {
    var ht = MediaQuery.of(context).size.height;
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ResultStudentSearch()));
          },
          child: Row(
            children: [
              Container(
                width: ht * 0.065,
                height: ht * 0.065,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: ClipOval(
                    child: Image.asset(
                  'assets/images/supplier.png',
                  fit: BoxFit.cover,
                )),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Binho',
                    style: GoogleFonts.openSans(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'X4',
                    style: GoogleFonts.openSans(
                        fontSize: 13,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.all(7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: returnColor,
                ),
                child: Icon(
                  FontAwesomeIcons.addressBook,
                  color: buttonColor,
                  size: 23,
                ),
              )
            ],
          ),
        ),
        Divider(
          height: ht * 0.05,
          color: Colors.grey.shade300,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recently Exchanges',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Clear History',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: buttonColor),
                  ))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: ListView.builder(
            itemCount: 3,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return serviceWidget();
            },
          ),
        ),
      ],
    );
  }
}

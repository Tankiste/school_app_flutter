import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:school_app/constants/constants.dart';
import 'package:school_app/features/home/controller/posts_listview.dart';
import 'package:school_app/features/notifications/views/notifications.dart';
import 'package:school_app/features/weather/views/weather_page.dart';
import 'package:school_app/widgets/widgets.dart';
import 'package:weather/weather.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  File? image;
  String? fileName;
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);
  Weather? _weather;

  @override
  void initState() {
    super.initState();
    _wf.currentWeatherByCityName("Douala").then((w) {
      setState(() {
        _weather = w;
      });
    });
  }

  Widget _weatherIcon() {
    var ht = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          height: ht * 0.30,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png"))),
        ),
        SizedBox(height: ht * 0.01),
        Text(
          _weather?.weatherDescription ?? "",
          style:
              GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _dateTimeInfo() {
    DateTime now = _weather!.date!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          DateFormat("EEEE").format(
            now,
          ),
          style:
              GoogleFonts.openSans(fontSize: 13, fontWeight: FontWeight.bold),
        ),
        Text(
          " ${DateFormat("d.M.y").format(now)}",
          style:
              GoogleFonts.openSans(fontSize: 13, fontWeight: FontWeight.w400),
        ),
      ],
    );
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
            'Publish a New Post',
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
              child: Container(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 20, top: ht * 0.07, right: 20, bottom: ht * 0.07),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/images/logo.png',
                            scale: 1.6,
                          ),
                          SizedBox(
                            height: ht * 0.045,
                            width: wd * 0.1,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: returnColor,
                                  padding: EdgeInsets.zero,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: ((context) =>
                                              NotificationScreen())));
                                },
                                child: Icon(
                                  FontAwesomeIcons.solidBell,
                                  size: 20,
                                  color: buttonColor,
                                )),
                          )
                        ],
                      ),
                      SizedBox(
                        height: ht * 0.035,
                      ),
                      Text(
                        'Hello, John !',
                        style: GoogleFonts.lexend(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: ht * 0.027,
                      ),
                      SearchBarItem(),
                      SizedBox(
                        height: ht * 0.027,
                      ),
                      Text(
                        'Best Post Of The Week',
                        style: GoogleFonts.lexend(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: ht * 0.02,
                      ),
                      Stack(
                        children: [
                          Container(
                            height: ht * 0.22,
                            width: wd,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                "assets/images/students-posing.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                              left: 10,
                              top: 7,
                              child: Row(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: ht * 0.05,
                                    width: wd * 0.1,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(13),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(13),
                                      child: Image.asset(
                                          "assets/images/supplier.png"),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    height: ht * 0.056,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.black26),
                                    padding: EdgeInsets.all(5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: ht * 0.022,
                                          width: wd * 0.2,
                                          child: Text(
                                            "Davis Bryan",
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.openSans(
                                                fontSize: 13,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                          height: ht * 0.02,
                                          width: wd * 0.18,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'O3',
                                                style: GoogleFonts.openSans(
                                                    fontSize: 13,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              Text(
                                                '6h',
                                                style: GoogleFonts.openSans(
                                                    fontSize: 13,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ))
                        ],
                      ),
                      SizedBox(
                        height: ht * 0.035,
                      ),
                      Text(
                        'Weather',
                        style: GoogleFonts.lexend(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: ht * 0.02,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WeatherPage()));
                        },
                        child: Card(
                          color: Colors.white,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: _weather == null
                              ? Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: wd * 0.4,
                                        vertical: ht * 0.08),
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(
                                          top: 7,
                                          left: wd * 0.06,
                                          right: wd * 0.06,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: Text(
                                                _weather?.areaName ?? "",
                                                style: GoogleFonts.openSans(
                                                    color: Colors.black45,
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Center(
                                              child: _dateTimeInfo(),
                                            )
                                          ],
                                        )),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding:
                                              EdgeInsets.only(left: wd * 0.1),
                                          child: Column(
                                            children: [
                                              Text(
                                                _weather?.weatherDescription ??
                                                    "",
                                                style: GoogleFonts.openSans(
                                                    fontSize: 16,
                                                    color: Colors.black45),
                                              ),
                                              // SizedBox(
                                              //   height: 5,
                                              // ),
                                              Text(
                                                '${_weather?.temperature?.celsius?.toStringAsFixed(0)}° C',
                                                style: GoogleFonts.openSans(
                                                    fontSize: 26,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black45),
                                              ),
                                              Text(
                                                'min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}° C / max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}° C',
                                                style: GoogleFonts.openSans(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black45),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                            padding: EdgeInsets.only(
                                                right: wd * 0.01, bottom: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: ht * 0.20,
                                                  width: wd * 0.4,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              "https://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png"))),
                                                ),
                                                Container(
                                                  child: Text(
                                                    'wind ${_weather?.windSpeed?.toStringAsFixed(0)} m/s',
                                                    style: GoogleFonts.openSans(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black45),
                                                  ),
                                                )
                                              ],
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                        ),
                      ),
                      SizedBox(
                        height: ht * 0.035,
                      ),
                      Text(
                        'Feed',
                        style: GoogleFonts.lexend(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: ht * 0.02,
                      ),
                      Column(
                        children: [
                          ListView.builder(
                            itemCount: 2,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return PostListView();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 90,
              right: 20,
              child: FloatingActionButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(30))),
                      builder: ((context) {
                        return buildComment();
                      }));
                },
                backgroundColor: buttonColor,
                heroTag: null,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 32,
                ),
                shape: CircleBorder(),
              )),
          // Positioned(
          //   bottom: 10,
          //   left: 15,
          //   right: 15,
          //   child: FloatingBar(),
          // )
        ],
      ),
    );
  }
}

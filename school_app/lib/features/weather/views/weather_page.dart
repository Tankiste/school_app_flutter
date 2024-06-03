import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:school_app/constants/constants.dart';
import 'package:school_app/widgets/widgets.dart';
import 'package:weather/weather.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
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

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;
    return Scaffold(
      body:
          // _weather == null
          //     ? Center(
          //         child: CircularProgressIndicator(),
          //       )
          //     :
          Container(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(top: ht * 0.065),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: ht * 0.05),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: SizedBox(
                          height: ht * 0.045,
                          width: wd * 0.09,
                          child: ReturnButton()),
                    ),
                  ),
                  SizedBox(
                    height: ht * 0.045,
                  ),
                  Text(
                    'Douala',
                    style: GoogleFonts.openSans(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: ht * 0.07,
                  ),
                  Text(
                    DateFormat("h:mm a").format(DateTime.now()),
                    style: GoogleFonts.openSans(
                        fontSize: 30, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: ht * 0.015,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat("EEEE").format(
                          DateTime.now(),
                        ),
                        style: GoogleFonts.openSans(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        DateFormat("  d.m.y").format(
                          DateTime.now(),
                        ),
                        style: GoogleFonts.openSans(
                            fontSize: 13, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ht * 0.09,
                  ),
                  Image.asset(
                    "assets/images/sunnysky.jpg",
                    scale: 1.5,
                  ),
                  SizedBox(height: ht * 0.04),
                  Text(
                    "overcast clouds",
                    style: GoogleFonts.openSans(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: ht * 0.04),
                  Text(
                    "14° C",
                    style: GoogleFonts.openSans(
                        fontSize: 60, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: ht * 0.04),
                  Container(
                    height: ht * 0.15,
                    width: wd * 0.75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: buttonColor,
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: wd * 0.13, vertical: ht * 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Min: 11° C',
                              style: GoogleFonts.openSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: ht * 0.025,
                            ),
                            Text(
                              'Wind: 2m/s',
                              style: GoogleFonts.openSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Max: 15° C',
                              style: GoogleFonts.openSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: ht * 0.025,
                            ),
                            Text(
                              'Humidity: 83%',
                              style: GoogleFonts.openSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

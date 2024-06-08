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
  List<Weather> _forecast = [];

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  Future<void> _loadWeather() async {
    var weather = await _wf.currentWeatherByCityName("Douala");
    var forecast = await _wf.fiveDayForecastByCityName("Douala");
    List<Weather> uniqueForecast = [];

    for (var day in forecast.toList()) {
      bool isUnique = true;
      for (var existing in uniqueForecast) {
        if (DateFormat("EEEE").format(day.date!) ==
            DateFormat("EEEE").format(existing.date!)) {
          isUnique = false;
          break;
        }
      }
      if (isUnique) {
        uniqueForecast.add(day);
      }
    }

    setState(() {
      _weather = weather;
      _forecast = uniqueForecast;
    });
  }

  Widget _dateTimeInfo() {
    var ht = MediaQuery.of(context).size.height;
    DateTime now = _weather!.date!;
    return Column(
      children: [
        Text(
          DateFormat("h:mm a").format(now),
          style:
              GoogleFonts.openSans(fontSize: 30, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: ht * 0.015,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat("EEEE").format(
                now,
              ),
              style: GoogleFonts.openSans(
                  fontSize: 13, fontWeight: FontWeight.bold),
            ),
            Text(
              " ${DateFormat("d.M.y").format(now)}",
              style: GoogleFonts.openSans(
                  fontSize: 13, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ],
    );
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

  Widget _forecastList() {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;

    return Container(
      height: ht * 0.2,
      // width: wd * 0.9,
      color: Colors.white,
      child: ListView.builder(
          // shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: _forecast.length,
          itemBuilder: (context, index) {
            Weather weather = _forecast[index];
            return Container(
              height: ht * 0.15,
              width: wd * 0.3,
              margin: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.shade300)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('EEEE').format(weather.date!),
                    style: GoogleFonts.openSans(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Image.network(
                    "https://openweathermap.org/img/wn/${weather.weatherIcon}@2x.png",
                    height: ht * 0.11,
                    width: wd * 0.2,
                  ),
                  Text(
                      "${weather.temperature?.celsius?.toStringAsFixed(0)}° C / ${weather.humidity?.toStringAsFixed(0)}%")
                ],
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: _weather == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(top: ht * 0.065, bottom: ht * 0.05),
                child: SingleChildScrollView(
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
                        _weather?.areaName ?? "",
                        style: GoogleFonts.openSans(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: ht * 0.07,
                      ),
                      _dateTimeInfo(),
                      SizedBox(
                        height: ht * 0.027,
                      ),
                      _weatherIcon(),
                      SizedBox(height: ht * 0.04),
                      Text(
                        "${_weather?.temperature?.celsius?.toStringAsFixed(0)}° C",
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
                            horizontal: wd * 0.13, vertical: ht * 0.037),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}° C',
                                  style: GoogleFonts.openSans(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: ht * 0.025,
                                ),
                                Text(
                                  'Wind: ${_weather?.windSpeed?.toStringAsFixed(0)}m/s',
                                  style: GoogleFonts.openSans(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}° C',
                                  style: GoogleFonts.openSans(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: ht * 0.025,
                                ),
                                Text(
                                  'Humidity: ${_weather?.humidity?.toStringAsFixed(0)}%',
                                  style: GoogleFonts.openSans(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: ht * 0.05,
                      ),
                      _forecastList()
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

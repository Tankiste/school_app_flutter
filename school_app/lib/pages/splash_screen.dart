import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_app/constants/constants.dart';
import 'package:school_app/pages/onboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, CupertinoPageRoute(builder: ((context) => OnBoard())));
    });
  }

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: splashColor,
        body: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: ht * 0.25,
                  width: wd * 0.7,
                  child: Image.asset('assets/images/network.png'),
                ),
                SizedBox(
                  height: ht * 0.03,
                ),
                Container(
                  height: ht * 0.08,
                  width: wd * 0.9,
                  child: Image.asset('assets/images/logo.png'),
                ),
              ],
            )));
  }
}

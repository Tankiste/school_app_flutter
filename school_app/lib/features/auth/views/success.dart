import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_app/constants/constants.dart';
import 'package:school_app/features/auth/views/login.dart';
import 'package:school_app/widgets/widgets.dart';

class Success extends StatefulWidget {
  const Success({super.key});

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  bool isPlaying = false;
  final controller = ConfettiController();

  @override
  void initState() {
    super.initState();

    controller.play();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;
    return Stack(alignment: Alignment.center, children: [
      Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: ht * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 150),
                Image.asset(
                  'assets/images/success1.png',
                  color: buttonColor,
                ),
                SizedBox(height: ht * 0.02),
                Text('Congrats!',
                    style: GoogleFonts.openSans(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                    )),
                SizedBox(
                  height: ht * 0.056,
                  width: wd * 0.4,
                  child: Text(
                    "Account Created Successfully",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade500),
                  ),
                ),
                SizedBox(
                  height: ht * 0.19,
                ),
                MainButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                        (Route<dynamic> route) => false);
                  },
                  leftPadding: 100,
                  rightPadding: 100,
                  child: Text(
                    'Get Started',
                    style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 7,
                )
              ],
            ),
          ),
        ),
      ),
      ConfettiWidget(
        confettiController: controller,
        blastDirectionality: BlastDirectionality.explosive,
        gravity: 0.2,
      )
    ]);
  }
}

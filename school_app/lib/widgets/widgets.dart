import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_app/constants/constants.dart';

class ReturnButton extends StatelessWidget {
  const ReturnButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: returnColor,
          padding: EdgeInsets.zero,
        ),
        onPressed: () {
          Navigator.maybePop(context);
        },
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 20,
          color: Colors.black,
        ));
  }
}

class MainButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final double leftPadding;
  final double rightPadding;

  const MainButton(
      {super.key,
      required this.onPressed,
      required this.leftPadding,
      required this.rightPadding,
      required this.child});

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
        child: Padding(
            padding: EdgeInsets.only(
                left: leftPadding,
                right: rightPadding,
                top: ht * 0.02,
                bottom: ht * 0.02),
            child: child));
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_app/constants/constants.dart';
import 'package:school_app/features/auth/views/login.dart';
import 'package:school_app/widgets/widgets.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _emailController = TextEditingController();
  GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Padding(
          padding: EdgeInsets.only(right: 15, top: ht * 0.07),
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
              SizedBox(height: ht * 0.07),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 15),
                child: Column(
                  children: [
                    Form(
                        key: _loginFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Forgot Password',
                              style: GoogleFonts.openSans(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: ht * 0.05),
                            Text('Email',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.openSans(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Container(
                                height: ht * 0.055,
                                padding: EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    )),
                                child: TextFormField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      hintText: 'Email or username',
                                      contentPadding:
                                          EdgeInsets.only(left: 10, top: 5),
                                      hintStyle: GoogleFonts.openSans(
                                          color: Colors.grey.shade500,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 15),
                                      border: InputBorder.none),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    if (!value.contains('@')) {
                                      return 'Please enter a valid email address';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                                'Your confirmation link will be send to your email address.',
                                style: GoogleFonts.openSans(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                )),
                            SizedBox(height: ht * 0.1),
                            Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: MainButton(
                                  onPressed: () {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginPage()),
                                        (Route<dynamic> route) => false);
                                  },
                                  leftPadding: wd * 0.33,
                                  rightPadding: wd * 0.33,
                                  child: Text(
                                    'Send',
                                    style: GoogleFonts.openSans(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )),
                          ],
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

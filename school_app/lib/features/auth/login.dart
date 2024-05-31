import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_app/constants/constants.dart';
import 'package:school_app/features/auth/registration.dart';
import 'package:school_app/widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  bool _obscurePassword = true;
  String errorMessage = '';
  bool isLoading = false;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(right: 15, top: ht * 0.07),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: SizedBox(
                      height: ht * 0.045,
                      width: wd * 0.1,
                      child: ReturnButton()),
                ),
                SizedBox(height: ht * 0.07),
                Padding(
                  padding: EdgeInsets.only(left: 55),
                  child: Image.asset(
                    'assets/images/logo.png',
                    scale: 1,
                  ),
                ),
                SizedBox(
                  height: ht * 0.06,
                ),
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
                                'Welcome!',
                                style: GoogleFonts.openSans(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                  'Please login or sign up to continue in the app.',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.openSans(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade500,
                                  )),
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
                                        prefixIcon: Icon(
                                          Icons.mail,
                                          color: Colors.grey.shade500,
                                          size: 28,
                                        ),
                                        hintText: 'Enter your mail',
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
                              SizedBox(height: 20),
                              Text('Password',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.openSans(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  )),
                              const SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Container(
                                  height: ht * 0.055,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                      )),
                                  child: TextFormField(
                                    controller: _passwordController,
                                    obscureText: _obscurePassword,
                                    keyboardType: TextInputType.visiblePassword,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          color: Colors.grey.shade500,
                                          size: 28,
                                        ),
                                        contentPadding:
                                            EdgeInsets.only(left: 10, top: 5),
                                        hintText: 'Password',
                                        border: InputBorder.none,
                                        hintStyle: GoogleFonts.openSans(
                                            color: Colors.grey.shade500,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 15),
                                        suffixIcon: IconButton(
                                            icon: Icon(_obscurePassword
                                                ? Icons.visibility_off
                                                : Icons.visibility),
                                            onPressed:
                                                _togglePasswordVisibility)),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your password';
                                      }
                                      if (value.length < 6) {
                                        return 'Password must be at least 6 characters';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //              ForgotPasswordPage()));
                                    },
                                    child: Text(
                                      'Forgot Password?',
                                      style: GoogleFonts.openSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: buttonColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: ht * 0.027),
                              Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: MainButton(
                                    onPressed: () {},
                                    leftPadding: wd * 0.33,
                                    rightPadding: wd * 0.33,
                                    child: isLoading
                                        ? CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.white))
                                        : Text(
                                            'Login',
                                            style: GoogleFonts.openSans(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                  )),
                              SizedBox(
                                height: 7,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: 'Create a new account?',
                                      style: GoogleFonts.openSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey.shade500,
                                      )),
                                  TextSpan(
                                      text: ' Sign Up',
                                      style: GoogleFonts.openSans(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: buttonColor),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      RegistrationPage())));
                                        })
                                ])),
                              ),
                              SizedBox(height: ht * 0.027),
                              Divider(
                                color: Colors.grey.shade400,
                              ),
                              SizedBox(
                                height: ht * 0.015,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text('Continue With Accounts',
                                    style: GoogleFonts.openSans(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey.shade500,
                                    )),
                              ),
                              SizedBox(
                                height: ht * 0.018,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: onboardColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          )),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: wd * 0.13,
                                            top: ht * 0.02,
                                            bottom: ht * 0.02,
                                            right: wd * 0.13),
                                        child: Icon(
                                          FontAwesomeIcons.google,
                                          color: buttonColor,
                                        ),
                                      )),
                                  ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: onboardColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          )),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: wd * 0.13,
                                            top: ht * 0.02,
                                            bottom: ht * 0.02,
                                            right: wd * 0.13),
                                        child: Icon(
                                          FontAwesomeIcons.facebook,
                                          color: buttonColor,
                                        ),
                                      )),
                                ],
                              ),
                              if (errorMessage.isNotEmpty)
                                Padding(
                                  padding: EdgeInsets.only(left: 40),
                                  child: Text(
                                    'Invalid account, use a correct email or password',
                                    style: GoogleFonts.openSans(
                                      color: Colors.red.shade900,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                            ],
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

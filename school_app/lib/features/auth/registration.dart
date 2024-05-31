import 'package:country_picker/country_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_app/constants/constants.dart';
import 'package:school_app/features/auth/login.dart';
import 'package:school_app/widgets/widgets.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _confirmpassController = TextEditingController();
  bool _isChecked = false;
  bool _obscurePassword = true;
  bool _isButtonPressed = false;
  bool isLoading = false;
  String? _selectedPromotion;
  String? _selectedGender;
  Country _selectedNationality = CountryParser.parseCountryCode('CM');
  List<String> _gender = ['Male', 'Female'];
  List<String> _promotions = [
    'X1',
    'X2',
    'X3',
    'X4',
    'X5',
    '01',
    '02',
    '03',
    'A3',
    'A4',
    'A5',
    'I4',
    'I5',
    'IP3',
    'IP4',
    'IP5',
    'FC'
  ];
  GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpassController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          // width: double.infinity,
          // height: double.infinity,
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
                  padding: const EdgeInsets.only(left: 55),
                  child: Image.asset(
                    'assets/images/logo.png',
                    scale: 1.04,
                  ),
                ),
                SizedBox(
                  height: ht * 0.06,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 15),
                  child: Column(
                    children: [
                      Form(
                          key: _registerFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sign Up',
                                style: GoogleFonts.openSans(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text('Create a new account',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.openSans(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade500,
                                  )),
                              SizedBox(height: ht * 0.03),
                              Text('Full Name',
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
                                    controller: _usernameController,
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.person,
                                          color: Colors.grey.shade500,
                                          size: 32,
                                        ),
                                        hintText: 'Enter your full name',
                                        contentPadding:
                                            EdgeInsets.only(left: 10, top: 5),
                                        hintStyle: GoogleFonts.openSans(
                                            color: Colors.grey.shade500,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 15),
                                        border: InputBorder.none),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your username';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Sex',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.openSans(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      SizedBox(height: 5),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: Container(
                                          height: ht * 0.05,
                                          width: wd * 0.36,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Colors.grey.shade300,
                                            ),
                                          ),
                                          child: DropdownButtonFormField(
                                            value: _selectedGender,
                                            iconEnabledColor:
                                                Colors.grey.shade400,
                                            hint: Text(
                                              'Gender ',
                                              style: GoogleFonts.openSans(
                                                  color: Colors.grey.shade500,
                                                  fontWeight: FontWeight.w200),
                                            ),
                                            items: _gender
                                                .map((gender) =>
                                                    DropdownMenuItem<String>(
                                                      value: gender,
                                                      child: Text(
                                                        gender,
                                                        style: GoogleFonts
                                                            .openSans(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ))
                                                .toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                _selectedGender = value;
                                              });
                                            },
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Please select a gender';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              prefixIcon: Padding(
                                                padding: EdgeInsets.only(
                                                    top: 7, left: 10),
                                                child: FaIcon(
                                                  FontAwesomeIcons.venusMars,
                                                  color: Colors.grey.shade500,
                                                  size: 23,
                                                ),
                                              ),
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      0, 3, 5, 5),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Nationality',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.openSans(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      SizedBox(height: 5),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: GestureDetector(
                                          onTap: () {
                                            showCountryPicker(
                                              context: context,
                                              favorite: [
                                                'CM',
                                                'CG',
                                                'CD',
                                                'TD',
                                                'GA',
                                                'CF',
                                                'FR',
                                                'IN'
                                              ],
                                              showPhoneCode: false,
                                              countryListTheme: CountryListThemeData(
                                                  bottomSheetHeight: 600,
                                                  inputDecoration: InputDecoration(
                                                      prefixIcon: Icon(
                                                          Icons.search,
                                                          color: buttonColor),
                                                      hintText:
                                                          'Search your country here...',
                                                      border: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors.grey
                                                                  .shade200),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)))),
                                              onSelect: (Country country) {
                                                setState(() {
                                                  _selectedNationality =
                                                      country;
                                                });
                                                print(
                                                    _selectedNationality.name);
                                              },
                                            );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(left: 10),
                                            height: ht * 0.05,
                                            width: wd * 0.17,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: Colors.grey.shade300,
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '${_selectedNationality.flagEmoji}',
                                                  style: GoogleFonts.openSans(
                                                      fontSize: 23),

                                                  // child: InputDecorator(
                                                  //   decoration: InputDecoration(
                                                  //     prefixIcon: Padding(
                                                  //       padding:
                                                  //           EdgeInsets.only(
                                                  //               top: 7,
                                                  //               left: 10,
                                                  //               right: 10),
                                                  //       child:
                                                  //           _selectedNationality !=
                                                  //                   null
                                                  //               ? Image.asset(
                                                  //                   _selectedNationality!
                                                  //                       .flagUri,
                                                  //                   package:
                                                  //                       'country_picker',
                                                  //                   width: 24,
                                                  //                   height: 24,
                                                  //                 )
                                                  //               : FaIcon(
                                                  //                   FontAwesomeIcons
                                                  //                       .flag,
                                                  //                   color: Colors
                                                  //                       .grey
                                                  //                       .shade500,
                                                  //                   size: 23,
                                                  //                 ),
                                                  //     ),
                                                  //     contentPadding:
                                                  //         EdgeInsets.fromLTRB(
                                                  //             0, 3, 5, 5),
                                                  //     border: InputBorder.none,
                                                  //   ),
                                                  //   // child: Text(
                                                  //   //   _selectedNationality !=
                                                  //   //           null
                                                  //   //       ? _selectedNationality!
                                                  //   //           .name
                                                  //   //       : 'Select Nationality',
                                                  //   //   style:
                                                  //   //       GoogleFonts.openSans(
                                                  //   //     color:
                                                  //   //         _selectedNationality !=
                                                  //   //                 null
                                                  //   //             ? Colors.black
                                                  //   //             : Colors.grey
                                                  //   //                 .shade500,
                                                  //   //     fontWeight:
                                                  //   //         FontWeight.w200,
                                                  //   //   ),
                                                  //   // ),
                                                  // ),
                                                ),
                                                Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Colors.grey.shade400,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text('Promotion',
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
                                    ),
                                  ),
                                  child: DropdownButtonFormField(
                                    // padding: EdgeInsets.only(left: 10, top: 5),
                                    value: _selectedPromotion,
                                    iconEnabledColor: Colors.grey.shade400,
                                    hint: Text(
                                      'Select your promotion',
                                      style: GoogleFonts.openSans(
                                          color: Colors.grey.shade500,
                                          fontWeight: FontWeight.w200),
                                    ),
                                    style: GoogleFonts.openSans(
                                        color: Colors.grey.shade300,
                                        fontSize: 15),
                                    items: _promotions.map((field) {
                                      return DropdownMenuItem<String>(
                                        value: field,
                                        child: Text(
                                          field,
                                          style: GoogleFonts.openSans(
                                            color: Colors.black,
                                            // fontWeight: FontWeight.w300,
                                            // fontSize: 15,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedPromotion = value;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please select a promotion';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: Padding(
                                        padding:
                                            EdgeInsets.only(left: 7, top: 7),
                                        child: FaIcon(
                                          FontAwesomeIcons.peopleGroup,
                                          color: Colors.grey.shade500,
                                          size: 25,
                                        ),
                                      ),
                                      contentPadding:
                                          EdgeInsets.fromLTRB(0, 3, 5, 5),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Email',
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
                              const SizedBox(height: 10),
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                    side:
                                        BorderSide(color: Colors.grey.shade400),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    value: _isChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        _isChecked = value!;
                                      });
                                    },
                                    activeColor: buttonColor,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'By creating an account, you are agreeing with our',
                                        style: GoogleFonts.openSans(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey.shade500),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        'terms & conditions.',
                                        style: GoogleFonts.openSans(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey.shade500),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              if (_isButtonPressed && !_isChecked)
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    'Please agree to the terms and conditions',
                                    style: GoogleFonts.openSans(
                                      color: Colors.red.shade900,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 3),
                              Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: MainButton(
                                    onPressed: () {
                                      setState(() {
                                        _isButtonPressed = true;
                                      });
                                    },
                                    leftPadding: wd * 0.31,
                                    rightPadding: wd * 0.31,
                                    child: isLoading
                                        ? CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.white))
                                        : Text(
                                            'Sign Up',
                                            style: GoogleFonts.openSans(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                  )),
                              const SizedBox(height: 10),
                            ],
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: 'Already have an account?',
                          style: GoogleFonts.openSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade500,
                          )),
                      TextSpan(
                          text: ' Sign in',
                          style: GoogleFonts.openSans(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: buttonColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => LoginPage())));
                            })
                    ])),
                  ),
                )
                // Padding(
                //   padding: const EdgeInsets.only(left: 300),
                //   child: TextButton(
                //       onPressed: () {
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: ((context) => LoginPage())));
                //       },
                //       child: Text(
                //         'Sign In',
                //         style: GoogleFonts.openSans(
                //             fontSize: 17, color: buttonColor),
                //       )),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

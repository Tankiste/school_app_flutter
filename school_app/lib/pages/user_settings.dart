import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_app/constants/constants.dart';
import 'package:school_app/widgets/widgets.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({super.key});

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  bool _isDarkMode = false;
  bool _isVisible = false;
  String selectedOption = '';

  void showLanguage() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void setSelectedOption(String option) {
    setState(() {
      selectedOption = option;
    });
  }

  Widget buildOption(String optionName, String secondName) {
    bool isSelected = optionName == selectedOption;
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        onTap: () {
          setSelectedOption(optionName);
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 10,
                    offset: Offset(0, 4))
              ]),
          child: Row(children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  optionName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? buttonColor : Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  secondName,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: isSelected ? messageColor : Colors.grey.shade500,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Checkbox(
                  side: BorderSide(color: Colors.grey.shade400),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  value: isSelected,
                  onChanged: (value) {
                    setState(() {
                      setSelectedOption(optionName);
                    });
                  },
                  activeColor: buttonColor,
                ),
              ),
            )
          ]),
        ),
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
            child: Padding(
              padding: EdgeInsets.fromLTRB(25, ht * 0.07, 25, ht * 0.15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: ht * 0.045,
                        width: wd * 0.09,
                        child: ReturnButton()),
                    SizedBox(
                      height: ht * 0.06,
                    ),
                    Text(
                      'Settings',
                      style: GoogleFonts.openSans(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: ht * 0.06,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Dark Mode',
                          style: GoogleFonts.openSans(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Transform.scale(
                          scale: 1.1,
                          child: Switch(
                              activeColor: buttonColor,
                              activeTrackColor: returnColor,
                              value: _isDarkMode,
                              onChanged: (value) {
                                setState(() {
                                  _isDarkMode = value;
                                });
                              }),
                        )
                      ],
                    ),
                    Divider(
                      height: 35,
                      color: Colors.grey.shade400,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Language',
                          style: GoogleFonts.openSans(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        _isVisible
                            ? Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: GestureDetector(
                                  onTap: showLanguage,
                                  child: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Colors.grey.shade500,
                                    size: 25,
                                  ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: GestureDetector(
                                  onTap: showLanguage,
                                  child: Icon(
                                    Icons.keyboard_arrow_right_rounded,
                                    color: Colors.grey.shade500,
                                    size: 25,
                                  ),
                                ),
                              )
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    if (_isVisible)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildOption('Français', 'French'),
                          SizedBox(height: 10),
                          buildOption('English', 'English'),
                        ],
                      )
                  ]),
            ),
          ),
          Positioned(bottom: 10, left: 15, right: 15, child: FloatingBar())
        ],
      ),
    );
  }
}

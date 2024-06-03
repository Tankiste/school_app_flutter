import 'package:flutter/material.dart';

void main() {
  runApp(const Terms());
}

class Terms extends StatelessWidget {
  const Terms({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: const TermsAndConditions(),
      ),
    );
  }
}

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        double height = constraints.maxHeight;
        double padding = width * 0.05; // 5% padding

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: Column(
            children: [
              Container(
                width: width,
                height: height,
                decoration: const BoxDecoration(color: Colors.white),
                child: Stack(
                  children: [
                    Positioned(
                      left: padding,
                      top: height * 0.9, // 90% from top
                      child: SizedBox(
                        width: width * 0.9, // 90% of width
                        height: height * 0.07, // 7% of height
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: width * 0.9, // 90% of width
                                height: height * 0.07, // 7% of height
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        width: 1, color: Color(0xFFF0F0F0)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: width * 0.65,
                              top: height * 0.015,
                              child: SizedBox(
                                width: width * 0.25, // 25% of width
                                height: height * 0.04, // 4% of height
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Container(
                                        width: width * 0.25, // 25% of width
                                        height: height * 0.04, // 4% of height
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFFDEFFFB),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Positioned(
                                      left: 34,
                                      top: 4,
                                      child: Text(
                                        'Profile',
                                        style: TextStyle(
                                          color: Color(0xFF137C8B),
                                          fontSize: 16,
                                          fontFamily: 'Lexend',
                                          fontWeight: FontWeight.w600,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: width * 0.08,
                              top: height * 0.015,
                              child: Container(
                                width: width * 0.1, // 10% of width
                                height: height * 0.04, // 4% of height
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFDEFFFB),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: width * 0.33,
                              top: height * 0.015,
                              child: Container(
                                width: width * 0.1, // 10% of width
                                height: height * 0.04, // 4% of height
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFDEFFFB),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 23,
                      top: 106,
                      child: SizedBox(
                        width: 227,
                        height: 22,
                        child: Text(
                          'Terms and Conditions',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 25,
                      top: 162,
                      child: SizedBox(
                        width: width * 0.9,
                        height: height * 0.6,
                        child: const Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce hendrerit consectetur dolor, quis maximus ipsum suscipit et. Suspendisse quis elit massa. Pellentesque eget aliquet est. Aenean pretium, risus quis ornare ultrices, tellus nulla dictum ex, non rutrum nulla arcu eget est. Proin convallis non nunc et feugiat. Donec ac iaculis turpis, quis pharetra elit. Duis cursus, massa id mattis tempor, urna augue dictum risus, fringilla sagittis ipsum lectus sed libero. Pellentesque placerat sed tellus et placerat. Nam eu eros sodales, egestas turpis vel, commodo mauris. Donec cursus tempor consectetur. Donec venenatis est in mi porta pellentesque. Aliquam volutpat id quam ac tempus. Quisque in mauris eros.\n\nVestibulum metus metus, iaculis a dictum vestibulum, porttitor id turpis. Vestibulum neque ipsum, euismod aliquam tellus eget, ornare fermentum lorem. Sed maximus mi et tortor viverra luctus. Aliquam ullamcorper pellentesque dui id maximus. Nunc sapien diam, tincidunt non mi sit amet, ullamcorper euismod neque. Vivamus commodo elit ac porttitor laoreet. Integer fermentum justo est, vitae venenatis leo sodales id. Nulla facilisi. Duis faucibus maximus est, id lobortis diam molestie condimentum. Vestibulum congue turpis eu vestibulum convallis. Pellentesque molestie nibh a sem sollicitudin, id rutrum nulla commodo. Aenean gravida erat turpis, quis ultricies dolor bibendum eget. ',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: Color(0xFF909090),
                            fontSize: 12,
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

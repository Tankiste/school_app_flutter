import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_app/widgets/widgets.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
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
              padding: EdgeInsets.only(left: 25, top: ht * 0.07, right: 25),
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
                      'Privacy Policy',
                      style: GoogleFonts.openSans(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: ht * 0.03,
                    ),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce hendrerit consectetur dolor, quis maximus ipsum suscipit et. Suspendisse quis elit massa. Pellentesque eget aliquet est. Aenean pretium, risus quis ornare ultrices, tellus nulla dictum ex, non rutrum nulla arcu eget est. Proin convallis non nunc et feugiat. Donec ac iaculis turpis, quis pharetra elit. Duis cursus, massa id mattis tempor, urna augue dictum risus, fringilla sagittis ipsum lectus sed libero. Pellentesque placerat sed tellus et placerat. Nam eu eros sodales, egestas turpis vel, commodo mauris. Donec cursus tempor consectetur. Donec venenatis est in mi porta pellentesque. Aliquam volutpat id quam ac tempus. Quisque in mauris eros.\n\nVestibulum metus metus, iaculis a dictum vestibulum, porttitor id turpis. Vestibulum neque ipsum, euismod aliquam tellus eget, ornare fermentum lorem. Sed maximus mi et tortor viverra luctus. Aliquam ullamcorper pellentesque dui id maximus. Nunc sapien diam, tincidunt non mi sit amet, ullamcorper euismod neque. Vivamus commodo elit ac porttitor laoreet.',
                      style: GoogleFonts.openSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade500),
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

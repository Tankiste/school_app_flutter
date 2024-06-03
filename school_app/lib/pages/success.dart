import 'package:flutter/material.dart';

void main() {
  runApp(const Success());
}

class Success extends StatelessWidget {
  const Success({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: const Scaffold(
        body: Congrats(),
      ),
    );
  }
}

class Congrats extends StatelessWidget {
  const Congrats({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1,
              color: const Color(0xFFFFFCFC),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 1,
                      height: 280,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("success.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.51,
                    left: MediaQuery.of(context).size.width * 0.38,
                    child: const Text(
                      'Congrats!',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 36,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.62,
                    left: MediaQuery.of(context).size.width * 0.37,
                    child: const SizedBox(
                      width: 204,
                      child: Text(
                        'Account Created Successfully',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0x84575454),
                          fontSize: 24,
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: MediaQuery.of(context).size.height * 0.12,
                    left: MediaQuery.of(context).size.width * 0.08,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF137C8B),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          // Handle button press
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            'Get Started',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

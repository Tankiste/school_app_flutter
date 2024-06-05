import 'package:flutter/material.dart';

void main() {
  runApp(const Success());
}

class Success extends StatefulWidget {
  const Success({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SuccessState createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  bool isDarkMode = false;
  bool isInFrench = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
              onPressed: () {
                setState(() {
                  isDarkMode = !isDarkMode;
                });
              },
            ),
            PopupMenuButton<bool>(
              icon: const Icon(Icons.language),
              itemBuilder: (context) => [
                const PopupMenuItem<bool>(
                  value: false,
                  child: Text('English'),
                ),
                const PopupMenuItem<bool>(
                  value: true,
                  child: Text('French'),
                ),
              ],
              onSelected: (value) {
                setState(() {
                  isInFrench = value;
                });
              },
            ),
          ],
        ),
        body: Congrats(isInFrench: isInFrench, isDarkMode: isDarkMode),
      ),
    );
  }
}

class Congrats extends StatelessWidget {
  final bool isInFrench;
  final bool isDarkMode;

  const Congrats(
      {super.key, required this.isInFrench, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1,
              color: Theme.of(context).colorScheme.surface,
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
                    child: Text(
                      isInFrench ? 'Félicitations!' : 'Congrats!',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 36,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.62,
                    left: MediaQuery.of(context).size.width * 0.37,
                    child: SizedBox(
                      width: 204,
                      child: Text(
                        isInFrench
                            ? 'Compte créé avec succès'
                            : 'Account Created Successfully',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0x84575454)
                              .withOpacity(isDarkMode ? 0.7 : 1.0),
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            isInFrench ? 'Commencer' : 'Get Started',
                            style: const TextStyle(
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

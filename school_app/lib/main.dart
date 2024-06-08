import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/firebase_options.dart';
import 'package:school_app/pages/splash_screen.dart';
import 'package:school_app/state/app_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ApplicationState())],
      child: ChangeNotifierProvider(
        create: (_) => ApplicationState(),
        child: MaterialApp(
          title: 'School App',
          // themeMode: ThemeMode.system,

          home: const SplashScreen(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_school_application/constants/constant_colors.dart';
import 'package:go_school_application/firebase_options.dart';
import 'package:go_school_application/screens/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Go School Attendance Management',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: scaffoldColor,
      ),
      home: const SplashScreen(),
    );
  }
}

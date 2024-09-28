import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_school_application/constants/constant_colors.dart';
import 'package:go_school_application/screens/authentication/options_screen.dart';
import 'package:go_school_application/screens/student/student_screen.dart';
import 'package:go_school_application/screens/teacher/teacher_screen.dart';
import 'package:go_school_application/screens/admin/admin_screen.dart';
import 'package:go_school_application/services/user_services.dart'; // Import your user services
import 'package:go_school_application/models/user_model.dart'; // Import your user model

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    autoRoute();
  }

  Future<void> autoRoute() async {
    // Delay for 3 seconds to show the splash screen
    await Future.delayed(const Duration(seconds: 3));

    // Check if the user is signed in
    User? user = _auth.currentUser;

    if (user != null) {
      // If user is signed in, fetch their email
      String email = user.email!;
      // Fetch the user model using the email
      UserModel? userModel = await UserServices().getUserByEmail(email);

      // If userModel exists, navigate to the appropriate screen
      if (userModel != null) {
        String? role = userModel.role;

        // Log the role to debug
        print("User role: $role");

        if (role == 'student') {
          // Navigate to the Student screen
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const StudentScreen()),
          );
        } else if (role == 'teacher') {
          // Navigate to the Teacher screen
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const TeacherScreen()),
          );
        } else if (role == 'admin') {
          // Navigate to the Admin screen
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const AdminScreen()),
          );
        } else {
          // If the role doesn't match, navigate to the Options screen
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const OptionsScreen()),
          );
        }
      } else {
        // If userModel is null, navigate to the Options screen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const OptionsScreen()),
        );
      }
    } else {
      // If user is not signed in, navigate to the Options screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const OptionsScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: splashColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App logo
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 165, 229, 245)
                        .withOpacity(0.15),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: const Image(
                image: AssetImage('assets/images/go-school.png'),
                color: Colors.white,
                colorBlendMode: BlendMode.modulate,
              ),
            ),
            const SizedBox(height: 20),
            // Welcome message
            const Text(
              "Welcome 🙏",
              style: TextStyle(
                fontSize: 32,
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // Loading indicator
            SizedBox(
              width: 100,
              child: LinearProgressIndicator(
                minHeight: 4,
                color: amberTextColor,
                backgroundColor: Colors.grey[300],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Please wait...",
              style: TextStyle(
                fontSize: 16,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

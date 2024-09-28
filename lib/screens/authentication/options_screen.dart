import 'package:flutter/material.dart';
import 'package:go_school_application/constants/constant_colors.dart';
import 'package:go_school_application/screens/authentication/login_screen.dart';
import 'package:go_school_application/screens/authentication/registration_screen.dart';
import 'package:go_school_application/widgets/common_widgets.dart';

class OptionsScreen extends StatelessWidget {
  const OptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: splashColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                const Image(
                  image: AssetImage(
                      "assets/images/go-school.png"), // Corrected the path
                ),
                const Spacer(),
                RoundedButton(
                  buttonText: "Sign In",
                  onPressed: () {
                    // Navigate to Sign In Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignInScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16.0),
                RoundedButton(
                  buttonText: "Sign Up",
                  onPressed: () {
                    // Navigate to Sign Up Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpScreen(),
                      ),
                    );
                  },
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

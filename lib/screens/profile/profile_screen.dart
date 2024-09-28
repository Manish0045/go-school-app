import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_school_application/constants/constant_colors.dart';
import 'package:go_school_application/models/user_model.dart';
import 'package:go_school_application/screens/admin/manage_users_screen.dart';
import 'package:go_school_application/screens/authentication/login_screen.dart';
import 'package:go_school_application/screens/student/attend_quiz.dart';
import 'package:go_school_application/services/auth_services.dart';
import 'package:go_school_application/services/user_services.dart';
import 'package:go_school_application/widgets/common_widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? name;
  String? userEmail;
  String? role;
  String? phoneNumber;
  String? joinedDate;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      User? user = _auth.currentUser; // Get the currently logged-in user
      if (user != null) {
        String? email = user.email;
        UserModel? userModel = await UserServices().getUserByEmail(email!);

        // print(userModel!.email);

        if (userModel != null) {
          setState(() {
            name = userModel.name;
            userEmail = userModel.email;
            role = userModel.role;
            phoneNumber = userModel.phoneNo;
            // print('$name,$userEmail,$role');
          });
        } else {
          print("User document does not exist");
        }
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Profile'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.cyan,
              child: name != null
                  ? Text(
                      name![0],
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    )
                  : const CircularProgressIndicator(), // First letter of the name
            ),
            const SizedBox(height: 16),

            // Name
            Text(
              name ?? 'Loading...', // Display name or loading text
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),

            // Role
            Text(
              role ?? 'Loading...', // Display role or loading text
              style: const TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 2, 246, 230),
              ),
            ),
            const SizedBox(height: 16),

            _buildProfileDetailRow('Email', userEmail ?? 'Loading...'),
            _buildProfileDetailRow('Phone', phoneNumber ?? 'null'),
            _buildProfileDetailRow('Joined Date', joinedDate ?? 'null'),

            const SizedBox(height: 24),

            // Conditional rendering based on role
            if (role == 'Admin') ...[
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ManageUsersScreen()),
                  );
                },
                child: const Text('Manage Users'),
              ),
            ] else if (role == 'Teacher') ...[
              ElevatedButton(
                onPressed: () {
                  // Teacher-specific action
                },
                child: const Text('Create Quizzes'),
              ),
            ] else if (role == 'Student') ...[
              ElevatedButton(
                onPressed: () {
                  // Student-specific action
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AttendQuizPage()));
                },
                child: const Text('Take Quizzes'),
              ),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  AuthServices().signOutUser();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignInScreen()));
                },
                child: Text("SignOut"))
          ],
        ),
      ),
    );
  }

  Widget _buildProfileDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
                color: amberTextColor,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, color: textColor),
          ),
        ],
      ),
    );
  }
}

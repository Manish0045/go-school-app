// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_school_application/widgets/constants.dart';
import 'package:go_school_application/services/user_services.dart';
import 'package:go_school_application/models/user_model.dart';

class AuthServices {
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserServices _userServices = UserServices();

  // Sign Up User
  Future<String> signUpUser({
    required String name,
    required String email,
    required String password,
    String role = ConstantRoles.studentRole,
  }) async {
    String result = "Some error occurred...!";
    try {
      if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String userId = userCredential.user?.uid ?? '';

        UserModel userModel = UserModel(
          userId: userId,
          name: name,
          email: email,
          role: role,
          address: null,
          phoneNo: null,
          dob: null,
        );

        // Create the user in Firestore using UserServices
        await _userServices.createUser(userModel);
        print(userCredential);

        result = "User registered and created in Firestore successfully!";
      } else {
        result = "Please enter all fields!";
      }
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  // Sign In User
  Future<String> signInUser({
    required String email,
    required String password,
  }) async {
    String result = "Some error occurred...!";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Optionally, retrieve user data from Firestore after signing in
        UserModel? userModel = await _userServices.getUserByEmail(email);

        if (userModel != null) {
          result = "User signed in successfully!";
          // You can now use `userModel` data in your app
        } else {
          result = "User data not found!";
        }
      } else {
        result = "Please enter all fields!";
      }
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  // Sign Out User
  Future<void> signOutUser() async {
    await _auth.signOut();
  }
}

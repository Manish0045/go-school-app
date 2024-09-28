import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart'; // Assuming UserModel is defined here

class UserServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create a new user in Firestore
  Future<String> createUser(UserModel userModel) async {
    String result = "Some error occurred...!";
    try {
      if (userModel.email.isNotEmpty) {
        await _firestore
            .collection('users')
            .doc(userModel.email)
            .set(userModel.toMap());
        result = "User created successfully!";
      } else {
        result = "Email is required!";
      }
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  // Update an existing user in Firestore
  Future<String> updateUser(UserModel userModel) async {
    String result = "Some error occurred...!";
    try {
      await _firestore
          .collection('users')
          .doc(userModel.email)
          .update(userModel.toMap());
      result = "User updated successfully!";
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  // Delete a user from Firestore
  Future<String> deleteUser(String email) async {
    String result = "Some error occurred...!";
    try {
      await _firestore.collection('users').doc(email).delete();
      result = "User deleted successfully!";
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  // Retrieve a user by their email
  Future<UserModel?> getUserByEmail(String email) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(email).get();
      if (snapshot.exists) {
        return UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}

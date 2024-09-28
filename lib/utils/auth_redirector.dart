import 'package:flutter/material.dart';
import 'package:go_school_application/screens/admin/admin_screen.dart';
import 'package:go_school_application/screens/authentication/options_screen.dart';
import 'package:go_school_application/screens/student/student_screen.dart';
import 'package:go_school_application/screens/teacher/teacher_screen.dart';
import 'package:go_school_application/widgets/constants.dart';

class AuthRedirector {
  Future<void> redirect(BuildContext context, String role) async {
    switch (role) {
      case ConstantRoles.studentRole:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => StudentScreen()));
        break;
      case ConstantRoles.teacherRole:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => TeacherScreen()));
        break;
      case ConstantRoles.adminRole:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AdminScreen()));
        break;
      default:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => OptionsScreen()));
    }
  }
}

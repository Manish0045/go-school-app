import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:go_school_application/screens/profile/profile_screen.dart';
import 'package:go_school_application/screens/teacher/quiz_screen.dart';
import 'package:go_school_application/screens/teacher/student_list_screen.dart';
import 'package:go_school_application/widgets/mark_attendance.dart';

class TeacherScreen extends StatefulWidget {
  const TeacherScreen({super.key});

  @override
  State<TeacherScreen> createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
  static const _kPages = <String, IconData>{
    'homepage': Icons.home_filled,
    'students': Icons.check_circle_outline,
    'add_test': Icons.quiz_outlined,
    'profile': Icons.settings,
  };

  final TabStyle _tabStyle = TabStyle.reactCircle;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _kPages.length,
      initialIndex: 0,
      child: Scaffold(
        body: const TabBarView(
          children: [
            MarkAttendance(),
            StudentListPage(),
            QuizFormPage(),
            ProfileScreen(),
          ],
        ),
        bottomNavigationBar: ConvexAppBar(
          style: _tabStyle,
          items: <TabItem>[
            for (final entry in _kPages.entries)
              TabItem(icon: entry.value, title: entry.key),
          ],
          onTap: (index) {
            // print('Clicked tab $index');
          },
        ),
      ),
    );
  }
}

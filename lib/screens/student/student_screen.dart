import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:go_school_application/screens/profile/profile_screen.dart';
import 'package:go_school_application/screens/student/attend_quiz.dart';
import 'package:go_school_application/screens/student/total_attendance.dart';
import 'package:go_school_application/widgets/mark_attendance.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  static const _kPages = <String, IconData>{
    'homepage': Icons.home_filled,
    'attendence': Icons.check_circle_outline,
    'test': Icons.quiz_outlined,
    'profile': Icons.settings,
  };

  final TabStyle _tabStyle = TabStyle.reactCircle;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _kPages.length,
      initialIndex: 0,
      child: Scaffold(
        body: TabBarView(
          children: [
            MarkAttendance(),
            AttendanceReportPage(),
            QuizPage(),
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

import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:go_school_application/screens/admin/admin_dashboard.dart';
import 'package:go_school_application/screens/admin/manage_users_screen.dart';
import 'package:go_school_application/screens/profile/profile_screen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  static const _kPages = <String, IconData>{
    'dashboard': Icons.dashboard_customize_outlined,
    'users': Icons.person_2_outlined,
    'profile': Icons.settings,
  };

  final TabStyle _tabStyle = TabStyle.reactCircle;

  final PageController _pageController = PageController(initialPage: 0);

  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: const [
          AdminDashboard(),
          ManageUsersScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: ConvexAppBar(
        style: _tabStyle,
        items: <TabItem>[
          for (final entry in _kPages.entries)
            TabItem(icon: entry.value, title: entry.key),
        ],
        initialActiveIndex: _currentIndex,
        activeColor: Colors.amber,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
            _pageController.jumpToPage(index);
          });
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_school_application/constants/constant_colors.dart';
import 'package:go_school_application/screens/admin/add_user_screen.dart';
import 'package:go_school_application/screens/admin/edit_user_screen.dart';

class ManageUsersScreen extends StatelessWidget {
  const ManageUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const EditUserScreen(),
      const AddUserScreen(),
    ];

    final tabs = <Tab>[
      const Tab(
        icon: Icon(Icons.person),
        text: 'Edit User',
      ),
      const Tab(
        icon: Icon(Icons.add),
        text: 'Add User',
      ),
    ];

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'Manage Users',
            style: TextStyle(color: scaffoldColor, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.amberAccent,
            labelColor: Colors.cyan,
            dividerColor: Color(0x00fff678),
            tabs: tabs,
          ),
        ),
        body: TabBarView(
          children: pages,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_school_application/widgets/common_widgets.dart'; // Ensure this imports your common widgets

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: _getGreeting()),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today\'s Overview',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: _buildAttendanceCard(80), // Static attendance count
                ),
                Flexible(
                  child: _buildTotalUsersCard(200), // Static user count
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 300,
              child: _buildAttendanceChart({
                'Present': 75.0, // Static data
                'Absent': 25.0, // Static data
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceCard(int presentCount) {
    return Card(
      color: Colors.green[100],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Present Today',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              '$presentCount',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalUsersCard(int totalUsers) {
    return Card(
      color: Colors.blue[100],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Total Users',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              '$totalUsers',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceChart(Map<String, double> attendanceStats) {
    return PieChart(
      PieChartData(
        sections: attendanceStats.entries
            .map(
              (e) => PieChartSectionData(
                color: e.key == 'Present' ? Colors.green : Colors.red,
                value: e.value,
                title: '${e.key}: ${e.value.toInt()}%',
                radius: 60,
                titleStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

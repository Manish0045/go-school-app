import 'package:flutter/material.dart';
import 'package:go_school_application/models/attendance_model.dart';
import 'package:go_school_application/services/attendance_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_school_application/widgets/common_widgets.dart';

class AttendanceReportPage extends StatefulWidget {
  const AttendanceReportPage({super.key});

  @override
  State<AttendanceReportPage> createState() => _AttendanceReportPageState();
}

class _AttendanceReportPageState extends State<AttendanceReportPage> {
  final AttendanceService _attendanceService = AttendanceService();
  User? user = FirebaseAuth.instance.currentUser; // Get the logged-in user

  late Future<List<Attendance>> _attendanceRecords;
  int totalPresent = 0;
  int totalAbsent = 0;

  @override
  void initState() {
    super.initState();
    // Fetch attendance records for the logged-in user
    _attendanceRecords =
        _attendanceService.getUserAttendanceRecords(user!.email!);
  }

  void _calculateSummary(List<Attendance> attendanceRecords) {
    totalPresent = 0;
    totalAbsent = 0;
    for (Attendance record in attendanceRecords) {
      if (record.status == 'present') {
        totalPresent++;
      } else if (record.status == 'absent') {
        totalAbsent++;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Attendance Report'),
      body: FutureBuilder<List<Attendance>>(
        future: _attendanceRecords,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching attendance records'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No attendance records found'));
          }

          List<Attendance> attendanceRecords = snapshot.data!;
          _calculateSummary(
              attendanceRecords); // Calculate present/absent totals

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: attendanceRecords.length,
                  itemBuilder: (context, index) {
                    Attendance record = attendanceRecords[index];
                    return ListTile(
                      leading: Icon(
                        record.status == 'present'
                            ? Icons.check_circle_outline
                            : Icons.cancel_outlined,
                        color: record.status == 'present'
                            ? Colors.green
                            : Colors.red,
                      ),
                      title: Text(
                        record.status == 'present' ? 'Present' : 'Absent',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: record.status == 'present'
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                      subtitle: Text('Date: ${record.date}'),
                      trailing: Text(
                        'Time: ${record.timestamp.toLocal().toString().split(' ')[1]}',
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Total Present',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '$totalPresent',
                              style: TextStyle(
                                fontSize: 24.0,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Total Absent',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '$totalAbsent',
                              style: TextStyle(
                                fontSize: 24.0,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

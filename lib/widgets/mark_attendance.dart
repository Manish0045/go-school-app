import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_school_application/widgets/common_widgets.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:intl/intl.dart';

class MarkAttendance extends StatefulWidget {
  const MarkAttendance({super.key});

  @override
  State<MarkAttendance> createState() => _MarkAttendanceState();
}

class _MarkAttendanceState extends State<MarkAttendance> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? userName;
  bool _isAttendanceMarked = false;
  bool _isScanning = false;
  String greeting = '';
  String todayDate =
      DateFormat('yyyy-MM-dd').format(DateTime.now()); // Current date format

  @override
  void initState() {
    super.initState();
    _setGreeting();
    _getUserName();
    _checkAttendanceStatus(); // Check attendance status on init
  }

  void _setGreeting() {
    final hour = DateTime.now().hour;
    setState(() {
      if (hour < 12) {
        greeting = 'Good Morning';
      } else if (hour < 17) {
        greeting = 'Good Afternoon';
      } else {
        greeting = 'Good Evening';
      }
    });
  }

  Future<void> _getUserName() async {
    User? user = _auth.currentUser;
    if (user != null) {
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.email)
          .get();
      setState(() {
        userName = userData['name'];
      });
    }
  }

  Future<void> _checkAttendanceStatus() async {
    User? user = _auth.currentUser;
    if (user != null) {
      final attendanceDoc = await FirebaseFirestore.instance
          .collection('attendance')
          .doc(user.email)
          .collection('daily')
          .doc(todayDate)
          .get();

      setState(() {
        _isAttendanceMarked = attendanceDoc.exists; // Set the attendance status
      });
    }
  }

  Future<void> _markAttendance(String status) async {
    User? user = _auth.currentUser;
    if (user != null) {
      final attendanceDoc = await FirebaseFirestore.instance
          .collection('attendance')
          .doc(user.email)
          .collection('daily')
          .doc(todayDate)
          .get();

      if (!attendanceDoc.exists) {
        // If attendance is not yet marked for the day, mark it now
        await FirebaseFirestore.instance
            .collection('attendance')
            .doc(user.email)
            .collection('daily')
            .doc(todayDate)
            .set({
          'status': status,
          'timestamp': Timestamp.now(),
        });
        setState(() {
          _isAttendanceMarked = true; // Update attendance status
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Attendance marked as $status")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Attendance already marked for today")),
        );
      }
    }
  }

  Future<void> _scanQR() async {
    setState(() {
      _isScanning = true;
    });
    try {
      var result = await BarcodeScanner.scan();
      if (result.type == ResultType.Barcode) {
        // Assuming the QR code contains the attendance information
        String scannedData = result.rawContent;
        // Process scanned data if needed
        print("Scanned QR Code: $scannedData");
        await _markAttendance('present');
      }
    } catch (e) {
      print('Error scanning QR code: $e');
    } finally {
      setState(() {
        _isScanning = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "$greeting \n$userName"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              '$greeting, ${userName ?? "User"}!',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Date: $todayDate',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 40),
            if (!_isAttendanceMarked) ...[
              SlideAction(
                text: "Mark Present",
                onSubmit: () async {
                  await _markAttendance('present');
                },
                outerColor: Colors.green,
              ),
              const SizedBox(height: 20),
              SlideAction(
                text: "Mark Absent",
                onSubmit: () async {
                  await _markAttendance('absent');
                },
                outerColor: Colors.red,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _scanQR,
                child: Text(_isScanning ? 'Scanning...' : 'Scan QR Code'),
              ),
            ] else ...[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 10),
                  const Text(
                    "Attendance has already been marked for today.",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CircleAvatar(
                child: Icon(
                  Icons.check_circle,
                  size: 150,
                  color: Colors.green,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

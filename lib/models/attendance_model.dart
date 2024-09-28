import 'package:cloud_firestore/cloud_firestore.dart';

class Attendance {
  final String date; // Date stored as document ID in Firestore
  final String status; // Attendance status (e.g., "present" or "absent")
  final DateTime timestamp; // Timestamp of when the status was recorded

  Attendance({
    required this.date,
    required this.status,
    required this.timestamp,
  });

  // Factory constructor to create an Attendance object from Firestore data
  factory Attendance.fromFirestore(String date, Map<String, dynamic> data) {
    return Attendance(
      date: date, // Date is passed as document ID
      status: data['status'] ??
          'absent', // Default to 'absent' if status is missing
      timestamp: (data['timestamp'] as Timestamp)
          .toDate(), // Convert Firestore Timestamp to DateTime
    );
  }
}

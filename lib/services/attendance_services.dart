import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/attendance_model.dart';

class AttendanceService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch attendance records for the logged-in user
  Future<List<Attendance>> getUserAttendanceRecords(String userEmail) async {
    List<Attendance> attendanceRecords = [];

    try {
      // Reference the 'daily' subcollection of the user's attendance document
      CollectionReference dailyCollection = _firestore
          .collection('attendance')
          .doc(userEmail)
          .collection('daily');

      // Query the 'daily' subcollection, ordering by 'timestamp'
      QuerySnapshot snapshot = await dailyCollection
          .orderBy('timestamp', descending: true) // Order by timestamp
          .get();

      // Iterate over each document in the 'daily' subcollection
      for (var doc in snapshot.docs) {
        // Create an Attendance object for each document and add it to the list
        attendanceRecords.add(Attendance.fromFirestore(
            doc.id, doc.data() as Map<String, dynamic>));
      }
    } catch (e) {
      print('Error fetching attendance records: $e');
    }

    return attendanceRecords; // Return the list of attendance records
  }
}

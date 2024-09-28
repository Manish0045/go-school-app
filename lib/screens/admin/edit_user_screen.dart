import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_school_application/constants/constant_colors.dart';

class EditUserScreen extends StatefulWidget {
  const EditUserScreen({super.key});

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  List<Map<String, dynamic>> userList = [];
  bool _isLoading = true;

  final List<String> roles = ["All", "Student", "Admin", "Teacher"];
  String selectedRole = "All";

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    setState(() {
      _isLoading = true;
    });

    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('users').get();

      userList = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          'name': data['name'] ?? 'Unknown',
          'role': data['role'] ?? 'Unknown Role',
        };
      }).toList();
    } catch (e) {
      print('Error fetching users: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredUserList = userList.where((user) {
      if (selectedRole == "All") return true;
      return user['role'] == selectedRole;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SizedBox(
          height: 30,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: roles.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedRole = roles[index];
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 1.0,
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: selectedRole == roles[index]
                        ? amberTextColor
                        : Colors.grey[300],
                  ),
                  child: Center(
                    child: Text(
                      roles[index],
                      style: const TextStyle(
                        fontSize: 15,
                        color: scaffoldColor,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: filteredUserList.length,
                itemBuilder: (context, index) {
                  final student = filteredUserList[index];
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            child: Text(
                              student['name']?.substring(0, 1) ?? '',
                              style: const TextStyle(fontSize: 24),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            student['name'] ?? 'Unknown',
                            style: const TextStyle(fontSize: 18.0),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            student['role'] ?? 'Unknown Role',
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}

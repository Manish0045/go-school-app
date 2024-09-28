import 'package:flutter/material.dart';
import 'package:go_school_application/models/user_model.dart';
import 'package:go_school_application/services/auth_services.dart';
import 'package:go_school_application/services/user_services.dart';
import 'package:go_school_application/widgets/common_widgets.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final UserServices _userServices = UserServices();
  final AuthServices _authServices = AuthServices();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _standardController = TextEditingController();
  final TextEditingController _divisionController = TextEditingController();
  final TextEditingController _rollNoController = TextEditingController();
  final TextEditingController _guardianNameController = TextEditingController();
  final TextEditingController _guardianPhoneNoController =
      TextEditingController();
  final TextEditingController _employeeIdController = TextEditingController();
  final TextEditingController _qualificationController =
      TextEditingController();
  final TextEditingController _adminEmployeeIdController =
      TextEditingController();

  String _selectedRole = "Student";
  bool _isLoading = false;

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = picked.toIso8601String().split('T').first;
      });
    }
  }

  void _clearForm() {
    _nameController.clear();
    _addressController.clear();
    _emailController.clear();
    _phoneNoController.clear();
    _dobController.clear();
    _standardController.clear();
    _divisionController.clear();
    _rollNoController.clear();
    _guardianNameController.clear();
    _guardianPhoneNoController.clear();
    _employeeIdController.clear();
    _qualificationController.clear();
    _adminEmployeeIdController.clear();

    // Optionally reset the role to the default value.
    setState(() {
      _selectedRole = "Student";
    });
  }

  Future<void> _addUser() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Register user with Firebase Auth
      var userCredential = await _authServices.signUpUser(
        name: _nameController.text,
        email: _emailController.text,
        password: "12345678", // Default password, should be changed
      );

      if (userCredential != null) {
        // String userId = userCredential.
        UserModel? userData =
            await UserServices().getUserByEmail(_emailController.text);
        String userId = userData!.email;

        // Create a new user model based on the role selected
        UserModel userModel;
        if (_selectedRole == "Student") {
          userModel = Student(
            userId: userId,
            name: _nameController.text,
            email: _emailController.text,
            address: _addressController.text,
            phoneNo: _phoneNoController.text,
            dob: _dobController.text,
            standard: _standardController.text,
            division: _divisionController.text,
            rollNo: _rollNoController.text,
            guardianName: _guardianNameController.text,
            guardianPhoneNo: _guardianPhoneNoController.text,
          );
        } else if (_selectedRole == "Teacher") {
          userModel = Teacher(
            userId: userId,
            name: _nameController.text,
            email: _emailController.text,
            address: _addressController.text,
            phoneNo: _phoneNoController.text,
            dob: _dobController.text,
            employeeId: _employeeIdController.text,
            qualification: _qualificationController.text,
          );
        } else if (_selectedRole == "Admin") {
          userModel = Admin(
            userId: userId,
            name: _nameController.text,
            email: _emailController.text,
            address: _addressController.text,
            phoneNo: _phoneNoController.text,
            dob: _dobController.text,
            adminEmployeeId: _adminEmployeeIdController.text,
          );
        } else {
          userModel = UserModel(
            userId: userId,
            name: _nameController.text,
            email: _emailController.text,
            address: _addressController.text,
            phoneNo: _phoneNoController.text,
            dob: _dobController.text,
          );
        }

        // Save user to the database
        String result = await _userServices.createUser(userModel);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(result)));
        _clearForm();
      }
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $error')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Add User'),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButton<String>(
                      value: _selectedRole,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedRole = newValue!;
                        });
                      },
                      items: <String>['Student', 'Teacher', 'Admin']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16.0),
                    RoundedInput(controller: _nameController, hintText: 'Name'),
                    RoundedInput(
                        controller: _addressController, hintText: 'Address'),
                    RoundedInput(
                        controller: _emailController, hintText: 'Email'),
                    RoundedInput(
                        controller: _phoneNoController, hintText: 'Phone No'),
                    GestureDetector(
                      onTap: () => _selectDate(context, _dobController),
                      child: AbsorbPointer(
                        child: RoundedInput(
                            controller: _dobController,
                            hintText: 'Date of Birth'),
                      ),
                    ),
                    if (_selectedRole == "Student") ...[
                      RoundedInput(
                          controller: _standardController,
                          hintText: 'Standard'),
                      RoundedInput(
                          controller: _divisionController,
                          hintText: 'Division'),
                      RoundedInput(
                          controller: _rollNoController, hintText: 'Roll No'),
                      RoundedInput(
                          controller: _guardianNameController,
                          hintText: 'Guardian Name'),
                      RoundedInput(
                          controller: _guardianPhoneNoController,
                          hintText: 'Guardian Phone No'),
                    ],
                    if (_selectedRole == "Teacher") ...[
                      RoundedInput(
                          controller: _employeeIdController,
                          hintText: 'Employee ID'),
                      RoundedInput(
                          controller: _qualificationController,
                          hintText: 'Qualification'),
                    ],
                    if (_selectedRole == "Admin") ...[
                      RoundedInput(
                          controller: _adminEmployeeIdController,
                          hintText: 'Admin Employee ID'),
                    ],
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: _addUser,
                      child: const Text('Add User'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

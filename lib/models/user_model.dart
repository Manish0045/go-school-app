import 'package:go_school_application/widgets/constants.dart';

class UserModel {
  final String userId;
  final String name;
  final String email;
  final String role;
  final String? address;
  final String? phoneNo;
  final String? dob;

  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    this.role = ConstantRoles.studentRole,
    this.address,
    this.phoneNo,
    this.dob,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'role': role,
      'address': address,
      'phoneNo': phoneNo,
      'dob': dob,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'],
      name: map['name'],
      email: map['email'],
      role: map['role'],
      address: map['address'],
      phoneNo: map['phoneNo'],
      dob: map['dob'],
    );
  }
}

class Student extends UserModel {
  final String standard;
  final String division;
  final String rollNo;
  final String guardianName;
  final String guardianPhoneNo;

  Student({
    required super.userId,
    required super.name,
    required super.email,
    super.address,
    super.phoneNo,
    super.dob,
    required this.standard,
    required this.division,
    required this.rollNo,
    required this.guardianName,
    required this.guardianPhoneNo,
  }) : super(role: ConstantRoles.studentRole);

  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'standard': standard,
      'division': division,
      'rollNo': rollNo,
      'guardianName': guardianName,
      'guardianPhoneNo': guardianPhoneNo,
    });
    return map;
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      userId: map['userId'],
      name: map['name'],
      email: map['email'],
      address: map['address'],
      phoneNo: map['phoneNo'],
      dob: map['dob'],
      standard: map['standard'],
      division: map['division'],
      rollNo: map['rollNo'],
      guardianName: map['guardianName'],
      guardianPhoneNo: map['guardianPhoneNo'],
    );
  }
}

class Teacher extends UserModel {
  final String employeeId;
  final String qualification;

  Teacher({
    required super.userId,
    required super.name,
    required super.email,
    super.address,
    super.phoneNo,
    super.dob,
    required this.employeeId,
    required this.qualification,
  }) : super(role: ConstantRoles.teacherRole);

  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'employeeId': employeeId,
      'qualification': qualification,
    });
    return map;
  }

  factory Teacher.fromMap(Map<String, dynamic> map) {
    return Teacher(
      userId: map['userId'],
      name: map['name'],
      email: map['email'],
      address: map['address'],
      phoneNo: map['phoneNo'],
      dob: map['dob'],
      employeeId: map['employeeId'],
      qualification: map['qualification'],
    );
  }
}

class Admin extends UserModel {
  final String adminEmployeeId;

  Admin({
    required super.userId,
    required super.name,
    required super.email,
    super.address,
    super.phoneNo,
    super.dob,
    required this.adminEmployeeId,
  }) : super(role: ConstantRoles.adminRole);

  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'adminEmployeeId': adminEmployeeId,
    });
    return map;
  }

  factory Admin.fromMap(Map<String, dynamic> map) {
    return Admin(
      userId: map['userId'],
      name: map['name'],
      email: map['email'],
      address: map['address'],
      phoneNo: map['phoneNo'],
      dob: map['dob'],
      adminEmployeeId: map['adminEmployeeId'],
    );
  }
}

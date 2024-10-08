# go_school_application

A new Flutter project.

## overview
This application allows users to chec and manage their attenance with ease.  The app has a modern, user-friendly interface, making it accessible for all types of users.
The App containes Three roles 
- Admin
- Teacher
- Student

### Note-
You have to create Admin role directly in database authentication onto firebase to access admin panel.
It have fields on firestore like 
{
userId:'',
name:admin,
address:'',
phoneNo:'234567876',
role:Admin,
dob:''
}

first one Admin store afterwords you can add directly various roles from admin panel like student , admin and teacher

### Teacher Role
Teachers can mark their attendance ,  check their students and add quizes for student

### Admin Role
Admin can Manage Users, Check Users and View reports

### Student Role
Student can mark their attendance, view attendance history , take quizes 


## Installation
To run this app locally, follow the steps below.
- Prerequisites Flutter SDK (version 3.x or above) Install Flutter
- Android Studio or Visual Studio Code for running the app on a physical device or emulator.
- Dart version 2.12 or later.

# Steps
- Clone the repository 
  ```sh
  git clone https://github.com/Manish0045/go-school-app.git
  ```
- Navigate to the Project Directory
  ```sh
  cd go-school-app
  ```
- Install Dependencies Install the necessary Flutter packages by running the following command
  ```sh
  flutter pub get
  ```
- Run the App Ensure a device is connected or an emulator is running, then run the app with:
  ```sh
  flutter run
  ```

## Tech Stack
Frameworks and Languages
Frameworks: Flutter, Languages: Dart,

# Screen Snapshots

<img src="ss_for_go_school/option_screen.png" height="350" width="200" alt="Option screen"> <img src="ss_for_go_school/sign_in.png" height="350" width="200">
<img src="ss_for_go_school/sign_up.png" height="350" width="200"> <img src="ss_for_go_school/student_home.png" height="350" width="200"> 
<img src="ss_for_go_school/attendance_report.png" height="350" width="200"> <img src="ss_for_go_school/quiz_screen.png" height="350" width="200"> 
<img src="ss_for_go_school/profile_screen.png" height="350" width="200"> <img src="ss_for_go_school/teacher_home.png" height="350" width="200"> 
<img src="ss_for_go_school/students_list.png" height="350" width="200"> <img src="ss_for_go_school/create_quiz_form.png" height="350" width="200"> 
<img src="ss_for_go_school/admin_home.png" height="350" width="200"> <img src="ss_for_go_school/manage_user.png" height="350" width="200"> 
<img src="ss_for_go_school/manage_user_filter.png" height="350" width="200"> <img src="ss_for_go_school/add_new_user.png" height="350" width="200">

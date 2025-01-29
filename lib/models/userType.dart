
import 'package:disastermanagement/admin/adminhome.dart';
import 'package:disastermanagement/campcoordinator/campcoordinatorhome.dart';
import 'package:disastermanagement/police/respondtoreports.dart';
import 'package:disastermanagement/volunteer/screens/home.dart';
import 'package:flutter/material.dart';



String? userType;
final List<Map<String, dynamic>> users = [
  {
    'email': 'admin@gmail.com',
    'password': 'admin123',
    'userType': 'admin',
  },
  {
    'email': 'user@gmail.com',
    'password': 'user123',
    'userType': 'user',
  },
  {
    'email': 'ambulance@gmail.com',
    'password': 'ambulance123',
    'userType': 'ambulance',
  },
  {
    'email': 'coordinator@gmail.com',
    'password': 'coordinator123',
    'userType': 'campcoordinator',
  },
  {
    'email': 'police@gmail.com',
    'password': 'police123',
    'userType': 'police',
  },
  {
    'email': 'volunteer@gmail.com',
    'password': 'volunteer123',
    'userType': 'volunteer',
  },
];

void login(BuildContext context, String email, String password) {
  // Find user by email
  final user = users.firstWhere(
    (user) => user['email'] == email && user['password'] == password,
    orElse: () => {},
  );

  if (user.isEmpty) {
    // Show error message if login fails
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Invalid email or password")),
    );
    return;
  }

   userType = user['userType']!;
  // Widget homePage = getHomePage(email);
 
 if (user['userType']== "admin") {
   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminHomePage(),));
 }
 else if(user['userType']== "user"){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => VolunteerHomePage(),));
 }
 else if(user['userType']== "campcoordinator"){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CoordinatorHomeScreen(),));
 }
 else if(user['userType']== "volunteer"){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => VolunteerHomePage(),));
 }
  else if(user['userType']== "police"){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ReportResponsePage(),));
 }
 else if(user['userType']== "ambulance"){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => VolunteerHomePage(),));
 }
 
  // Navigator.push(
  //   context,
  //   MaterialPageRoute(builder: (context) => homePage),
  // );
}





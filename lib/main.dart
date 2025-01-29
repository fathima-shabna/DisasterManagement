import 'package:disastermanagement/admin/addcampcoordinator.dart';
import 'package:disastermanagement/admin/adminhome.dart';
import 'package:disastermanagement/admin/assigntask.dart';
import 'package:disastermanagement/admin/map.dart';
import 'package:disastermanagement/admin/viewfeedbacks.dart';
import 'package:disastermanagement/admin/viewreportedincidents.dart';
import 'package:disastermanagement/authentication/screens/ambulanceregistration.dart';
import 'package:disastermanagement/authentication/screens/login.dart';
import 'package:disastermanagement/authentication/screens/registration.dart';
import 'package:disastermanagement/campcoordinator/availableresources.dart';
import 'package:disastermanagement/campcoordinator/campcoordinatorhome.dart';
import 'package:disastermanagement/campcoordinator/demandresources.dart';
import 'package:disastermanagement/common/theme.dart';
import 'package:disastermanagement/police/respondtoreports.dart';
import 'package:disastermanagement/volunteer/screens/ambulanceviewresponse.dart';
import 'package:disastermanagement/volunteer/screens/home.dart';
import 'package:disastermanagement/volunteer/screens/location.dart';
import 'package:disastermanagement/volunteer/screens/report.dart';
import 'package:disastermanagement/volunteer/screens/resources.dart';
import 'package:disastermanagement/volunteer/screens/viewalert.dart';
import 'package:disastermanagement/volunteer/screens/viewallalerts.dart';
import 'package:disastermanagement/volunteer/screens/viewreport.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      // ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      home: LoginScreen()
    );
  }
}



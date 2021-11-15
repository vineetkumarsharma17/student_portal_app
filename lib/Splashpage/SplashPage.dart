import 'dart:async';
import 'package:flutter/material.dart';
import 'package:student_portal_app/Dashboard/DashboardPage.dart';
import 'package:student_portal_app/HomePage/Director/Director_LogIn.dart';
import 'package:student_portal_app/HomePage/Director/Director_dashboard/directorDashboard.dart';
import 'package:student_portal_app/HomePage/Faculty/faculty_LogIn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_portal_app/HomePage/Faculty/faculty_dashboard/facultyDashboard.dart';
class SplashPage extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}
class SplashScreenState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 2),
        () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>DashboardPage()));
          // check_if_already_login_faculty();

    });
            // context, MaterialPageRoute(builder: (context) => DirectorLogIn())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 250,
          height: 250,
          child: const Image(
            image: AssetImage('assets/images/collage_logo.png'),
          ),
        ),
      ),
    );
  }
  void  check_if_already_login() async {
     SharedPreferences ManagerLoginData = await SharedPreferences.getInstance();
    bool loginstatus = (ManagerLoginData.getBool('dlogin') ?? true);
    if (loginstatus == true) {
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => DirectorDashboard())).then((value) =>
          Navigator.pop(context));
    }
    else
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DirectorLogIn()));
  }
  void  check_if_already_login_faculty() async {
    SharedPreferences ManagerLoginData = await SharedPreferences.getInstance();
    bool loginstatus = await ManagerLoginData.getBool('flogin')??false;
    if (loginstatus == true) {
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => FacultyDashboard())).then((value) =>
          Navigator.pop(context));
    }
    else
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => FacultyLogIn()));
  }
}

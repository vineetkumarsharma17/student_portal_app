import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_portal_app/HomePage/Admin_Portal/Faculty_Attendance_card/FacultyAttendance.dart';
import 'package:student_portal_app/HomePage/Admin_Portal/Faculty_Card/FacultyCard.dart';
import 'package:student_portal_app/HomePage/Admin_Portal/Fees_Card/AdminFeesCard.dart';
import 'package:student_portal_app/HomePage/Admin_Portal/Student_card/StudentCard.dart';
import 'package:student_portal_app/HomePage/Faculty/faculty_LogIn.dart';
import 'package:student_portal_app/HomePage/Faculty/faculty_dashboard/viewAttendance/viewAttendance.dart';

import 'studentAttendence/takeStudentAttendence.dart';
//import 'package:student_portal_app/HomePage/Student_Portal/SliderPage/SliderPages.dart';



class FacultyDashboard extends StatefulWidget {
  FacultyDashboard({Key? key}) : super(key: key);

  @override
  _FacultyDashboardState createState() => _FacultyDashboardState();
}

class _FacultyDashboardState extends State<FacultyDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child:ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('flogin',false);
                Navigator.push(context,MaterialPageRoute(builder: (context)=>FacultyLogIn())
                ).then((value) => Navigator.pop(context)).then((value) => Navigator.pop(context));
              },
            ),
            ListTile(
              title: const Text('About us'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      //backgroundColor: Color(0xFFC0C9BF),
      appBar: AppBar(
        elevation: 0.0,
        // backgroundColor: Color(0xFFC0C9BF),
        //backgroundColor: Colors.grey[200],
        // leading: IconButton(
        //   icon: Icon(Icons.menu),
        //   onPressed: () {},
        //   tooltip: 'Menu',
        // ),
        title: Text("Faculty"),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: IconButton(
              onPressed: () {
              },
              icon: Icon(Icons.more_vert),
            ),
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //SliderScreen(),
              SizedBox(
                height: 150,
              ),
              Container(
                padding: EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                width: MediaQuery.of(context).size.width * .99,
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Card(
                      color: Colors.orange,
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Column(
                          children: [
                            Container(
                              child: Text(
                                "Dashboard",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              child: Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => ViewSelfAttendance()));
                                      },
                                      child: Container(
                                        width: MediaQuery.of(context).size.width * 0.27,
                                        child: Column(
                                          children: [
                                            Icon(Icons.school_rounded),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 10),
                                              child: Text(
                                                ""
                                                    "View Attendence",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => TakeStudentAttendence()));
                                      },
                                      child: Container(
                                        width: MediaQuery.of(context).size.width * 0.27,
                                        child: Column(
                                          children: [
                                            Icon(Icons.school_rounded),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 10),
                                              child: Text(
                                                "Take Student Attendence",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

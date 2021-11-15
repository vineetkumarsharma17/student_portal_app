import 'package:flutter/material.dart';
import 'package:student_portal_app/HomePage/Admin_Portal/Faculty_Attendance_card/FacultyAttendance.dart';
import 'package:student_portal_app/HomePage/Admin_Portal/Faculty_Card/FacultyCard.dart';
import 'package:student_portal_app/HomePage/Admin_Portal/Fees_Card/AdminFeesCard.dart';
import 'package:student_portal_app/HomePage/Admin_Portal/Student_card/StudentCard.dart';
//import 'package:student_portal_app/HomePage/Student_Portal/SliderPage/SliderPages.dart';



class AdminPortalPage extends StatefulWidget {
  AdminPortalPage({Key? key}) : super(key: key);

  @override
  _AdminPortalPageState createState() => _AdminPortalPageState();
}

class _AdminPortalPageState extends State<AdminPortalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFFC0C9BF),
      appBar: AppBar(
        elevation: 0.0,
       // backgroundColor: Color(0xFFC0C9BF),
        //backgroundColor: Colors.grey[200],
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
          tooltip: 'Menu',
        ),
        title: Text("Admin"),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: IconButton(
              onPressed: () {},
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
                    StudentSlabCard(),
                    SizedBox(height: 10),
                    AdminFeesCardSlab(),
                    SizedBox(height: 10),
                    FacultyAttendanceCardSlab(),
                    SizedBox(height: 10),
                    FacultySlabCard(),
                    SizedBox(height: 10),
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

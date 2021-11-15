import 'package:flutter/material.dart';
import 'package:student_portal_app/HomePage/Student_Portal/Assignment_card/AssignmentCard.dart';
import 'package:student_portal_app/HomePage/Student_Portal/Fees_Card/FeesCard.dart';
import 'package:student_portal_app/HomePage/Student_Portal/Online_Class_Card/OnlineClassCard.dart';
import 'package:student_portal_app/HomePage/Student_Portal/Quiz_Test_Card/QuizTestCard.dart';
//import 'package:student_portal_app/HomePage/Student_Portal/SliderPage/SliderPages.dart';
import 'package:student_portal_app/HomePage/Student_Portal/StudentCard/StudentDetails.dart';

class StudentPortal extends StatelessWidget {
  const StudentPortal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StudentPortalPage(),
    );
  }
}

class StudentPortalPage extends StatefulWidget {
  StudentPortalPage({Key? key}) : super(key: key);

  @override
  _StudentPortalPageState createState() => _StudentPortalPageState();
}

class _StudentPortalPageState extends State<StudentPortalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE4CCF8),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFFE4CCF8),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
          tooltip: 'Menu',
        ),
        title: Text("SNITC"),
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
      body: SingleChildScrollView(
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
                width: MediaQuery.of(context).size.width * 0.99,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    StudentDetailsCard(),
                    SizedBox(height: 10),
                    FeesSlabsCard(),
                    SizedBox(height: 10),
                    AssignmentSlabsCard(),
                    SizedBox(height: 10),
                    QuizSlabsCard(),
                    SizedBox(height: 10),
                    OnlineClassSlabsCard(),
                    SizedBox(height: 10),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

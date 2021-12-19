import 'package:flutter/material.dart';
import 'package:student_portal_app/HomePage/Admin_Portal/Student_card/Promoted_Student/PromoteStudent.dart';
import 'package:student_portal_app/HomePage/Admin_Portal/Student_card/Student_Admission/Personal_info/personal_info.dart';
import 'package:student_portal_app/HomePage/Admin_Portal/Student_card/Student_search_card/student_search_card.dart';
import 'package:student_portal_app/HomePage/Admin_Portal/Student_card/today_present_classwise/today_present.dart';

class StudentSlabCard extends StatefulWidget {
  StudentSlabCard({Key? key}) : super(key: key);

  @override
  _StudentSlabCardState createState() => _StudentSlabCardState();
}

class _StudentSlabCardState extends State<StudentSlabCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
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
                "Student",
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
                            builder: (context) => RegisterPersonalInfo()));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.27,
                        child: Column(
                          children: const [
                            Icon(Icons.school_rounded),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "Student Admission",
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
                            builder: (context) => StudentSearchDetails()));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.27,
                        child: Column(
                          children: const [
                            Icon(Icons.school_rounded),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "Search Student",
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
                      onTap: () {},
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.27,
                        child: Column(
                          children: [
                            Icon(Icons.school_rounded),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "Student List",
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
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PromoteStudent()));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Column(
                          children: [
                            Icon(Icons.school_rounded),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "Promote Student",
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
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TodaysPresentClasswise()));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Column(
                        children: const [
                          Icon(Icons.school_rounded),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Today Present Student Classwise",
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
          ],
        ),
      ),
    );
  }
}

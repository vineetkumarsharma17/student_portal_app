import 'package:flutter/material.dart';
import 'package:student_portal_app/HomePage/Admin_Portal/AdminPortal.dart';
import 'package:student_portal_app/HomePage/Director/Director_LogIn.dart';
import 'package:student_portal_app/HomePage/Faculty/faculty_LogIn.dart';
//import 'package:student_portal_app/HomePage/Admin_Portal/Student_card/Promoted_Student/PromoteStudent.dart';
import 'package:student_portal_app/HomePage/Student_Portal/StudentPortal.dart';
//import 'package:student_portal_app/Loginpage/LoginPage.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Material(
                    //elevation: 10,
                    color: Color(0xFF36AC71),
                    borderRadius: BorderRadius.circular(15),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                      child: ButtonTheme(
                        minWidth: double.infinity,
                        child: MaterialButton(
                          onPressed: () {
                            //loginForm();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AdminPortalPage(),
                              ),
                            );
                          },
                          child: Text(
                            "Admin",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: Material(
                    //elevation: 10,
                    color: Color(0xFF36AC71),
                    borderRadius: BorderRadius.circular(15),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                      child: ButtonTheme(
                        minWidth: double.infinity,
                        child: MaterialButton(
                          onPressed: () {
                            //loginForm();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DirectorLogIn(),
                              ),
                            );
                          },
                          child: Text(
                            "Director",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: Material(
                    //elevation: 10,
                    color: Color(0xFF36AC71),
                    borderRadius: BorderRadius.circular(15),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                      child: ButtonTheme(
                        minWidth: double.infinity,
                        child: MaterialButton(
                          onPressed: () {
                            //loginForm();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => FacultyLogIn(),
                              ),
                            );
                          },
                          child: Text(
                            "Faculty",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: Material(
                    //elevation: 10,
                    color: Color(0xFF36AC71),
                    borderRadius: BorderRadius.circular(15),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                      child: ButtonTheme(
                        minWidth: double.infinity,
                        child: MaterialButton(
                          onPressed: () {
                            //loginForm();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => StudentPortal(),
                              ),
                            );
                          },
                          child: Text(
                            "Student",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_portal_app/HomePage/Admin_Portal/AdminPortal.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isloading = false;
  String error = "";
  var obj;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future loginForm() async {
    if (_usernameController.text.isEmpty && _passwordController.text.isEmpty) {
      setState(() {
        error = "Please Filled All Empty Fields";
      });
    } else {
      setState(() {
        error = "";
        isloading = true;
      });

      // Store all data with Param Name.
      print("Username:" + _usernameController.text);
      print("password:" + _passwordController.text);

      var data = {
        "username": _usernameController.text,
        "password": _passwordController.text
      };
      // Starting App API Call.
      var response = await http.post(
          Uri.parse(
              "http://sniic.co.in/admin/school_app/login_verification.php"),
          body: json.encode(data));

      // Getting Server response into variable.
      setState(() {
        obj = jsonDecode(response.body);
      });

      if (obj['status'] == "Active") {
        setState(() {
          isloading = false;
        });
        // String regno = obj['regno'];
        // print(regno);
        // SharedPreferences pref = await SharedPreferences.getInstance();
        // await pref.setString("regNo", regno);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => AdminPortalPage()));
      } else {
        setState(() {
          isloading = false;
          error =
              "Student Providing Details are invalid So please provide valid details";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFBCEBEB),
      body: Container(
        width: MediaQuery.of(context).size.width * 1,
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 1,
                height: 180,
              ),
              Card(
                color: Color(0xFFFDFAFF),
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.98,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 80,
                      ),
                      CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/images/racepayLogo.jpeg"),
                        radius: 60,
                      ),
                      SizedBox(
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 30,
                          ),
                          child: Text(
                            "Welcome To SNITC",
                            style: TextStyle(
                                color: Color(0xFF5A5858),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextFormField(
                          controller: _usernameController,
                          //maxLength: 10,
                          //keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.person,
                              color: Colors.blueGrey[200],
                              size: 24,
                            ),
                            hintText: "Enter Username",
                            labelText: "Username",
                            labelStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextFormField(
                          controller: _passwordController,
                          //maxLength: 10,
                          //keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.lock,
                              color: Colors.blueGrey[200],
                              size: 24,
                            ),
                            hintText: "Enter Password",
                            labelText: "Password",
                            labelStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: error != ""
                              ? Text(
                                  error,
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                  textAlign: TextAlign.left,
                                )
                              : Text("")),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Material(
                          //elevation: 10,
                          color: Color(0xFF097272),
                          borderRadius: BorderRadius.circular(15),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                            child: ButtonTheme(
                              minWidth: double.infinity,
                              child: MaterialButton(
                                onPressed: () {
                                  loginForm();
                                  // Navigator.of(context).push(
                                  //   MaterialPageRoute(
                                  //     builder: (context) => StudentPortal(),
                                  //   ),
                                  // );
                                },
                                child: (isloading == true
                                    ? Text(
                                        "Loading .....",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    : Text(
                                        "Continue",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

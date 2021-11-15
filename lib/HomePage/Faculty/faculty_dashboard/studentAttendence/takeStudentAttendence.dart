import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_portal_app/component/alertdilog.dart';

class TakeStudentAttendence extends StatefulWidget {
  TakeStudentAttendence({Key? key}) : super(key: key);

  @override
  _TakeStudentAttendenceState createState() => _TakeStudentAttendenceState();
}

class _TakeStudentAttendenceState extends State<TakeStudentAttendence> {
  bool isLoading = false;
  bool isuploadingAttendence = false;
  Map<String, bool> studentAtendance = <String, bool>{};
  String error = "";
  String? currentClass;
  String? currentPeriod;
  String present='';
  List classList = [
    "Pre-NC",
    "NC",
    "UKG",
    "KG",
    "1st",
    "2nd",
    "3rd",
    "4th",
    "5th",
    "6th",
    "7th",
    "8th",
    "9th",
    "10th",
    "11th",
    "12th",
  ];
  List period = [
    "1st", "2nd", "3rd", "4th", "5th","6th","7th","8th","9th","10th",
  ];
  List? searchStudentList;

  Future searchstudentInfo() async {
    studentAtendance.clear();
    if (currentClass!.isEmpty&&currentPeriod!.isEmpty) {
      setState(() {
        isLoading = false;
        showMyDialog("Error", "Please fill all empty fields", context);
      });
    } else {
      setState(() {
        error = "";
        isLoading = true;
      });
      print("class:" + currentClass!);
      var data = {
        "class": currentClass!,
      };

      /// Start App API Calls
      var response = await http.post(
          Uri.parse(
              "http://sniic.co.in/admin/school_app/student_detail_json.php"),
          body: json.encode(data));
      var obj = jsonDecode(response.body);
      if (obj["result"] == 'S') {
        print(obj);
        setState(() {
          error = "";
          isLoading = false;
          searchStudentList = obj["data"];
        });
      } else {
        setState(() {
          error = "Student's Details is not valid in the database";
          isLoading = false;
        });
      }
    }
  }
  Future uploadAttendance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (present=="") {
      setState(() {
        isLoading = false;
        showMyDialog("Error", "Please upload at least one attendance!", context);
      });
    } else {
      setState(() {
        error = "";
        isLoading = true;
      });
      var data = {
        "class": currentClass,
        "regnos":present,
        "section":"A",
        "subject":"math",
        "period":currentPeriod,
        "fid":prefs.getString("fregNo")
      };

      /// Start App API Calls
      var response = await http.post(
          Uri.parse(
              "http://sniic.co.in/admin/school_app/student_attendance.php"),
          body: json.encode(data));
      var obj = jsonDecode(response.body);
      if (obj["result"] == 'S') {
        print(obj);
        showMyDialog("Success", "Attendence Succefully uploaded", context
        ).then((value) => Navigator.pop(context));
        // setState(() {
        //   error = "";
        //   isLoading = false;
        // });
      } else {
        setState(() {
          error = "Attendense upload failed.";
          isLoading = false;
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFBCEBEB),
      appBar: AppBar(
        backgroundColor: Color(0xFF097272),
        title: Text("Mark Student Attendance"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 30, bottom: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Select Class:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 50),
                          child: DropdownButton(
                            isExpanded: true,
                            underline: Text(""),
                            hint: Text("Select Class"),
                            value: currentClass,
                            items: classList.map<DropdownMenuItem<String>>((e) {
                              return DropdownMenuItem<String>(
                                child: Text(e),
                                value: e,
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                currentClass = value.toString();
                                print(currentClass);
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30, bottom: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Select Period:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 50),
                          child: DropdownButton(
                            isExpanded: true,
                            underline: Text(""),
                            hint: Text("Select Period"),
                            value: currentPeriod,
                            items: period.map<DropdownMenuItem<String>>((e) {
                              return DropdownMenuItem<String>(
                                child: Text(e),
                                value: e,
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                currentPeriod = value.toString();
                                print(currentPeriod);
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                child: error != ""
                    ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    error,
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                    textAlign: TextAlign.left,
                  ),
                )
                    : Text(""),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF097272),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {
                    searchstudentInfo();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: isLoading != false
                        ? Text(
                      "Loading.....",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                        : Text(
                      "Next",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount:
                  searchStudentList == null ? 0 : searchStudentList!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      margin: EdgeInsets.symmetric(vertical: 2.5),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: CheckboxListTile(
                        secondary: Container(
                          child: Image.network(searchStudentList![index]["pic"],
                            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                              return const Text('Pic\nNot Found');
                            },),
                        ),
                        title: Text(
                          searchStudentList![index]["name"],
                        ),
                        subtitle: Text(searchStudentList![index]["srno"]),
                        selected:
                        studentAtendance[searchStudentList![index]["regno"]] ??
                            false,
                        autofocus: true,
                        activeColor: Colors.green,
                        checkColor: Colors.white,
                        //activeColor: Colors.red,
                        value:
                        studentAtendance[searchStudentList![index]["regno"]] ??
                            false,
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            studentAtendance[searchStudentList![index]["regno"]] =
                            value!;
                            print(studentAtendance);
                            // print(value);
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: searchStudentList == null
                    ? Text("")
                    : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF097272),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    present='';
                    for (var key in studentAtendance.keys) {
                      if(studentAtendance[key]==true)
                      present+=key.toString()+",";
                    }
                    uploadAttendance();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: isuploadingAttendence != false
                        ? Text(
                      "Loading.....",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                        : Text(
                      "Submit Attendance",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
  void submitAttendence()async{
    var data = {
      "class": currentClass!,

    };

    /// Start App API Calls
    var response = await http.post(
        Uri.parse(
            "http://sniic.co.in/admin/school_app/login/faculty_login_verification.php"),
        body: json.encode(data));
    var obj = jsonDecode(response.body);
    if (obj["result"] == 'S') {
      print(obj);
      setState(() {
        error = "";
        isLoading = false;
        searchStudentList = obj["data"];
      });
    } else {
      setState(() {
        error = "Student's Details is not valid in the database";
        isLoading = false;
      });
    }
  }

  }

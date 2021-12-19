import 'dart:convert';
import 'dart:io';

import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:student_portal_app/component/alertdilog.dart';

class TodaysPresentClasswise extends StatefulWidget {
  const TodaysPresentClasswise({Key? key}) : super(key: key);

  @override
  _TodaysPresentClasswiseState createState() => _TodaysPresentClasswiseState();
}

class _TodaysPresentClasswiseState extends State<TodaysPresentClasswise> {
  String? currentClass;
  List attendance = [];
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
  bool loading = true;
  int total = 0, attend = 0;
  double? per;
  String datefrom = '', dateto = '';
  Future<void> getData() async {
    setState(() {
      loading = false;
    });
    var data = {"class": currentClass, "fromdate": datefrom, "todate": dateto};
    // Starting App API Call.
    var response = await http
        .post(
            Uri.parse(
                "http://sniic.co.in/admin/school_app/student_att_by_class_json.php"),
            body: json.encode(data))
        .catchError((e) {
      if (e is SocketException) {
        showMyDialog("Error", "No internet connection", context);
      }
      setState(() {
        // error = "";
        loading = true;
      });
    });
    // Getting Server response into variable.
    var obj = jsonDecode(response.body);

    if (obj["result"] == "S") {
      setState(() {
        loading = true;
        attendance = obj["data"];
        total = int.parse(obj["total"] ?? "0");
      });
      print(obj.toString());
    } else {
      setState(() {
        loading = true;
        // error = "Student Class is not valid in the list";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Attendance"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.025,
        ),
        width: MediaQuery.of(context).size.width * 0.95,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30, bottom: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Current Class:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 50),
                          child: DropdownButton(
                            isExpanded: true,
                            underline: const Text(""),
                            hint: const Text("Select Current Class"),
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
              Card(
                  // elevation: 7,
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .10,
                      vertical: 5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: DateTimeFormField(
                      onDateSelected: (DateTime value) {
                        datefrom = value.year.toString() +
                            "-" +
                            value.month.toString() +
                            "-" +
                            value.day.toString();
                        print(datefrom);
                      },
                      dateFormat: DateFormat.yMd(),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        errorStyle: TextStyle(color: Colors.redAccent),
                        icon: Icon(Icons.event_note),
                        labelText: 'Starting Date',
                        hintText: 'mm/dd/yyyy',
                      ),
                      mode: DateTimeFieldPickerMode.date,
                      autovalidateMode: AutovalidateMode.always,
                    ),
                  )),
              Card(
                  // elevation: 7,
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .10,
                      vertical: 5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: DateTimeFormField(
                      onDateSelected: (DateTime value) {
                        dateto = value.year.toString() +
                            "-" +
                            value.month.toString() +
                            "-" +
                            value.day.toString();
                        print(dateto);
                        // print()
                      },
                      dateFormat: DateFormat.yMd(),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        errorStyle: TextStyle(color: Colors.redAccent),
                        icon: Icon(Icons.event_note),
                        labelText: 'End Date',
                        hintText: 'mm/dd/yyyy',
                      ),
                      mode: DateTimeFieldPickerMode.date,
                      autovalidateMode: AutovalidateMode.always,
                    ),
                  )),
              loading
                  ? Container(
                      // color: Colors.red,
                      margin: EdgeInsets.only(left: width * .6),
                      child: CircleAvatar(
                        radius: 30,
                        child: IconButton(
                            onPressed: () {
                              getData();
                            },
                            icon: const Icon(
                              Icons.search,
                              size: 40,
                            )),
                      ),
                    )
                  : const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: attendance == [] ? 0 : attendance.length,
                  itemBuilder: (BuildContext context, int index) {
                    attend = int.parse(attendance[index]["presence"] ?? "0");
                    per = attend * 100.0 / total;
                    return GestureDetector(
                      onTap: () {},
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            margin: EdgeInsets.symmetric(vertical: 2.5),
                            decoration: BoxDecoration(
                              color: Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  // child: Image.network(studentData[index]["pic"],
                                  //   errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                  //     return Icon(Icons.error_outline,size: 50,);
                                  //   },),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  child: Column(
                                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .5,
                                          child: Text(
                                            attendance[index]["name"],
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(attendance[index]["rollno"]
                                          .toString()),
                                      Text("Present:  " +
                                          attendance[index]["presence"]
                                              .toString()),
                                      Text("Attendance:  " +
                                          per!.toStringAsFixed(2) +
                                          "%"),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

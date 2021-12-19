import 'dart:convert';
import 'dart:io';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:student_portal_app/component/alertdilog.dart';

class Attendance extends StatefulWidget {
  final regno;
  const Attendance({Key? key, this.regno}) : super(key: key);
  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  String datefrom = '', dateto = '';
  bool loading = true;
  List attendance = [];
  var totaldays;

  @override
  Future<void> getAttendanced() async {
    setState(() {
      loading = false;
    });
    var data = {
      "rollno": "SNIICSTUD100920211101",
      "fromdate": datefrom,
      "todate": dateto
    };

    var response = await http
        .post(
            Uri.parse(
                "http://sniic.co.in/admin/school_app/student_att_report_by_date_range_json.php"),
            body: json.encode(data))
        .catchError((e) {
      if (e is SocketException) {
        showMyDialog("Error", "No internet connection", context);
      }
      setState(() {
        loading = true;
      });
    });
    var obj = jsonDecode(response.body);
    if (obj["result"] == 'S') {
      print("++++++++++++++++++++++++++++++++++++++++++");
      print(obj.toString());
      attendance = obj["data"];
      totaldays = obj["total_day"];
      setState(() {
        loading = true;
      });
    }
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int total = int.parse(totaldays);
    int present = attendance.length;
    double per = (present * 100.0) / total;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
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
                            if (validate()) {
                              getAttendanced();
                            }
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
            attendance.isNotEmpty
                ? Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                  width: width * .4,
                                  child: const Text(
                                    "Total days",
                                    style: TextStyle(fontSize: 20),
                                  )),
                              SizedBox(
                                  width: width * .1,
                                  child: const Text(":",
                                      style: TextStyle(fontSize: 20))),
                              SizedBox(
                                  width: width * .3,
                                  child: Text(totaldays.toString(),
                                      style: const TextStyle(fontSize: 20))),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                  width: width * .4,
                                  child: const Text(
                                    "Total Present",
                                    style: TextStyle(fontSize: 20),
                                  )),
                              SizedBox(
                                  width: width * .1,
                                  child: const Text(":",
                                      style: TextStyle(fontSize: 20))),
                              SizedBox(
                                  width: width * .3,
                                  child: Text(attendance.length.toString(),
                                      style: const TextStyle(fontSize: 20))),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                  width: width * .4,
                                  child: const Text(
                                    "Attendance",
                                    style: TextStyle(fontSize: 20),
                                  )),
                              SizedBox(
                                  width: width * .1,
                                  child: const Text(":",
                                      style: TextStyle(fontSize: 20))),
                              SizedBox(
                                  width: width * .3,
                                  child: Text(per.toStringAsFixed(2) + "%",
                                      style: const TextStyle(fontSize: 20))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                : Text(""),
            Container(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: attendance == [] ? 0 : attendance.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(attendance[index]["date_of_att"]),
                        leading: Icon(Icons.star),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  bool validate() {
    if (datefrom == "" || dateto == "") {
      showMyDialog("msg", "please select date range.", context);
      return false;
    }
    return true;
  }
}

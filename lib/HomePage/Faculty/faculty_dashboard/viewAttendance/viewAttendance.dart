import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_portal_app/component/alertdilog.dart';
import 'package:http/http.dart' as http;
class ViewSelfAttendance extends StatefulWidget {
  const ViewSelfAttendance({Key? key}) : super(key: key);

  @override
  _ViewSelfAttendanceState createState() => _ViewSelfAttendanceState();
}

class _ViewSelfAttendanceState extends State<ViewSelfAttendance> {
  List month = [
    "January","February","March","April","May","June","July",
    "August","September","October","November","December"
  ];
  int full=0,half=0;
  String?indiff,outdiff;
  List attendanceData=[];
  bool isLoading=false;
  var currentMonth;
  double? width;
  int ?monthNo;
  void loadAttendance()async{
    if(currentMonth==null){
      setState(() {
        isLoading=false;
      });
      showMyDialog("Error", "Please select a month", context);
    }
    else {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? regNo = preferences.getString("fregNo");
      print(regNo);
      print(monthNo);
      var data = {
        "empid": regNo,
        "month": monthNo.toString(),
      };
      var response = await http.post(
          Uri.parse(
              "http://sniic.co.in/admin/school_app/staff_att_json.php"),
          body: json.encode(data));
      var obj = jsonDecode(response.body);
      if (obj['result'] == "S") {
        setState(() {
          isLoading = false;
        });
        attendanceData=obj["data"];
        for(var x in attendanceData)
          {
            if(x["day_status"]=="Half Day")
              half++;
            else
              full++;
          }
        setState(() {
        });
        print(attendanceData);
      } else {
        setState(() {
          isLoading = false;
          showMyDialog("Error", "Could not load attendance", context);
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width-20;
    return Scaffold(
      appBar: AppBar(
        title: Text("View Self Attendance"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 30, bottom: 10,left: 10,right: 10),
          child: Column(
            children: [
              Container(
                // margin: EdgeInsets.only(top: 10, bottom: 10),
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
                        "Select Month:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 50),
                          child: DropdownButton(
                            isExpanded: true,
                            underline: Text(""),
                            hint: Text("Select Month"),
                            value: currentMonth,
                            items: month.map<DropdownMenuItem<String>>((e) {
                              return DropdownMenuItem<String>(
                                child: Text(e),
                                value: e,
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                currentMonth = value.toString();
                                monthNo=month.indexOf(currentMonth)+1;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
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
                    setState(() {
                      isLoading=!isLoading;
                      half=full=0;
                      loadAttendance();
                    });
                    // searchstudentInfo();
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
                      "View Attendance",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: (full!=0||half!=0)?Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 15,horizontal: 30),
                      decoration: BoxDecoration(
                        color: Color(0xFF097272),
                      ),
                      child: Text("Total Full: $full",style: TextStyle(
                        color: Colors.white,
                      ),),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 15,horizontal: 30),
                      decoration: BoxDecoration(
                        color: Color(0xFF097272),
                      ),
                      child: Text("Total Half: $half",style: TextStyle(
                        color: Colors.white,
                      ),),

                    ),
                  ],
                ):Text(""),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: attendanceData == [] ? 0 : attendanceData.length,
                itemBuilder: (BuildContext context, int index) {
                  var style=TextStyle(fontWeight: FontWeight.bold,
                  color: Colors.white);
                  List<Color> _colors = [Colors.orangeAccent, Colors.red];
                  List<double> _stops = [0.0, 0.8];
                  List<Color> _colors2 = [Colors.green, Colors.yellow];
                  List<double> _stops2 = [0.0, 0.7];
                  List part=(attendanceData[index]["out_diff"]).toString().split('.');
                  outdiff=part[0];
                  if(part[1].length>=2)
                    outdiff=(outdiff!+"."+part[1].toString().substring(0,2));
                  else
                    outdiff=outdiff!+"."+part[1].toString();
                   part=(attendanceData[index]["in_diff"]).toString().split('.');
                  indiff=part[0];
                  if(part.length==2) {
                    if (part[1].length >= 2)
                      indiff =
                      (indiff! + "." + part[1].toString().substring(0, 2));
                    else
                      indiff = indiff! + "." + part[1].toString();
                  }
                  String working_hour=(attendanceData[index]["working_hour"]).toString().substring(0,8);
                  return Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    margin: EdgeInsets.symmetric(vertical: 2.5),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: (attendanceData[index]["day_status"]!="Half Day")?_colors2:_colors,
                        stops: _stops,
                      ),
                      boxShadow: [
                      BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    )],
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(child: Row(
                              children: [
                                Container(
                                  width: width!*.2,
                                  child: Text("Date",style: style,),
                                ),
                                Container(
                                  width:  width!*.02,
                                  child: Text(":",style: style,),
                                ),
                                Container(
                                  width: width!*.25,
                                  child: Text(attendanceData[index]["date"].toString()),
                                )
                              ],
                            )),
                            Expanded(child: Row(
                              children: [
                                Container(
                                  width: width!*.2,
                                  child: Text("Working Hour",style: style,),
                                ),
                                Container(
                                  width:  width!*.02,
                                  child: Text(":",style: style,),
                                ),
                                Container(
                                  width: width!*.25,
                                  child: Text(working_hour),
                                )
                              ],
                            )),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(child: Row(
                              children: [
                                Container(
                                  width: width!*.2,
                                  child: Text("In Time",style: style,),
                                ),
                                Container(
                                  width:  width!*.02,
                                  child: Text(":",style: style,),
                                ),
                                Container(
                                  width: width!*.25,
                                  child: Text(attendanceData[index]["intime"].toString()),
                                )
                              ],
                            )),
                            Expanded(child: Row(
                              children: [
                                Container(
                                  width: width!*.2,
                                  child: Text("Out time",style: style,),
                                ),
                                Container(
                                  width:  width!*.02,
                                  child: Text(":",style: style,),
                                ),
                                Container(
                                  width: width!*.25,
                                  child: Text(attendanceData[index]["outtime"].toString()),
                                )
                              ],
                            )),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(child: Row(
                              children: [
                                Container(
                                  width: width!*.2,
                                  child: Text("In Diff",style: style,),
                                ),
                                Container(
                                  width:  width!*.02,
                                  child: Text(":",style: style,),
                                ),
                                Container(
                                  width: width!*.25,
                                  child: Text(indiff??"NA"),
                                )
                              ],
                            )),
                            Expanded(child: Row(
                              children: [
                                Container(
                                  width: width!*.2,
                                  child: Text("Out Diff",style: style,),
                                ),
                                Container(
                                  width:  width!*.02,
                                  child: Text(":",style: style,),
                                ),
                                Container(
                                  width: width!*.25,
                                  child: Text(outdiff??"NA"),
                                )
                              ],
                            )),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(child: Row(
                              children: [
                                Container(
                                  width: width!*.2,
                                  child: Text("Day Status",style: style,),
                                ),
                                Container(
                                  width:  width!*.02,
                                  child: Text(":",style: style,),
                                ),
                                Container(
                                  width: width!*.25,
                                  child:Text(attendanceData[index]["day_status"].toString()),
                                )
                              ],
                            )),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

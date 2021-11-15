import 'dart:convert';

import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
class UploadLeave extends StatefulWidget {
  const UploadLeave({Key? key}) : super(key: key);

  @override
  _UploadLeaveState createState() => _UploadLeaveState();
}

class _UploadLeaveState extends State<UploadLeave> {
  TextEditingController regNo=TextEditingController();
  TextEditingController reason=TextEditingController();
  String fromDate='';
  bool isLoading=false;
  String toDate='';
  String error='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFBCEBEB),
      appBar: AppBar(
        backgroundColor: Color(0xFF097272),
        title: Text("Upload Leave"),
      ),
      body: SingleChildScrollView(
        child: Container(margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .1,
          vertical: 40,),

          child: Column(
            children: [
              Container(
                //color: Color(0xFFFFFFFF),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: TextFormField(
                    controller: regNo,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.location_city,
                        color: Colors.black,
                        size: 24,
                      ),
                      border: InputBorder.none,
                      hintText: "Registration No",
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),

              Container(
                //color: Color(0xFFFFFFFF),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: DateTimeFormField(
                    onDateSelected: (DateTime value) {
                      fromDate = value.day.toString() +
                          "/" +
                          value.month.toString() +
                          "/" +
                          value.year.toString();
                      print(fromDate);
                    },
                    dateFormat: DateFormat.yMd(),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      errorStyle: TextStyle(color: Colors.redAccent),
                      icon: Icon(Icons.event_note),
                      labelText: 'From Date',
                      hintText: 'mm/dd/yyyy',
                    ),
                    mode: DateTimeFieldPickerMode.date,
                    autovalidateMode: AutovalidateMode.always,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                //color: Color(0xFFFFFFFF),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: DateTimeFormField(
                    onDateSelected: (DateTime value) {
                      toDate = value.day.toString() +
                          "/" +
                          value.month.toString() +
                          "/" +
                          value.year.toString();
                      print(toDate);
                    },
                    dateFormat: DateFormat.yMd(),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      errorStyle: TextStyle(color: Colors.redAccent),
                      icon: Icon(Icons.event_note),
                      labelText: 'To Date',
                      hintText: 'mm/dd/yyyy',
                    ),
                    mode: DateTimeFieldPickerMode.date,
                    autovalidateMode: AutovalidateMode.always,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                //color: Color(0xFFFFFFFF),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: reason,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.location_city,
                        color: Colors.black,
                        size: 24,
                      ),
                      border: InputBorder.none,
                      hintText: "Reason",
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1,
                ),
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF097272),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {
                    upload_Leave();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: isLoading != false
                        ? Text(
                      "Uploading.....",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                        : Text(
                      "Upload",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
 Future upload_Leave()async{
   print("hello");
   if (regNo.text.isNotEmpty &&
       reason.text.isNotEmpty &&
       fromDate.isNotEmpty &&
       toDate.isNotEmpty) {
     setState(() {
       error = "";
       isLoading = true;
     });

     var data = {
       "roll_no": regNo.text,
       "from_date": fromDate,
       "to_date": toDate,
       "reason": reason.text,
     };
     var response = await http.post(
         Uri.parse(
             "http://sniic.co.in/admin/school_app/student_leave.php"),
         body: json.encode(data));
     var obj = jsonDecode(response.body);
     if (obj['result'] == "S") {
       print("Success");
       showModalBottomSheet(context: context, builder: (BuildContext bc){
         return Container(
           child: Wrap(
             children: [
               ListTile(title: Text("Leave Uploaded"),),
               Center(
                 child: TextButton(onPressed: (){
                   setState(() {
                     isLoading=false;
                   });
                   Navigator.of(context).pop();
                 },
                     child: Text("OK")),
               )
             ],
           ),
         );
       });
       // Navigator.of(context).push(
       //     MaterialPageRoute(builder: (context) => OfficialStudentInfo()));
     }
     else print("failed");
   } else {
     setState(() {
       isLoading = false;
       error = "Please Filled All Details properly";
     });
   }
 }
}

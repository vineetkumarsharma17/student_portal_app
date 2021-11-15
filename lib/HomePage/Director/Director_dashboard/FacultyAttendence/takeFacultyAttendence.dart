import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_portal_app/component/alertdilog.dart';
import 'package:http/http.dart' as http;
class TakeFacultyAttendence extends StatefulWidget {
  const TakeFacultyAttendence({Key? key}) : super(key: key);

  @override
  _TakeFacultyAttendenceState createState() => _TakeFacultyAttendenceState();
}

class _TakeFacultyAttendenceState extends State<TakeFacultyAttendence> {
  String reg='';
  bool isLoading=true;
  Future scan()async{
    final barcode=await FlutterBarcodeScanner.scanBarcode("green", "Cancel", true, ScanMode.QR);
    setState(() {
      reg=barcode;
      if(reg=='-1'){
        showMyDialog("Eror!",'could not scan your id',context).then((value) => Navigator.pop(context));
      }
    });
    //Navigator.push(context, MaterialPageRoute(builder: (context)=>SuccessScan(roll_no!)));
  }
  @override
  void initState() {
    scan();
    // TODO: implement initState
    super.initState();
  }
  Future uploadAttendance() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        isLoading = false;
      });
      var data = {
        "empid":reg,
        "Add_By":"123456789"
      };

      /// Start App API Calls
      var response = await http.post(
          Uri.parse(
              "http://sniic.co.in/admin/school_app/staff_att.php"),
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
        showMyDialog("Error", "Somthing went wrong Try again!", context);
        setState(() {
          isLoading = false;
        });
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Card(
                elevation: 9,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(reg,style: TextStyle(
                      fontSize: 24,
                      color: Colors.red,
                    fontWeight: FontWeight.bold
                  ),),
                ),
              ),
            ),
            SizedBox(height: 30,),
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
                        uploadAttendance();
                      },
                      child:isLoading?Text(
                        "Confirm",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ):Text("Uploading....",
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
            SizedBox(height: 30,),
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
                          scan();
                        },
                        child:Text(
                          "Scan Again",
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
          ],
        ),
      ),
    );
  }
}

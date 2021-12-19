import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:student_portal_app/HomePage/Admin_Portal/Student_card/Student_search_card/studentAlldetail/tab/attendence.dart';
import 'package:student_portal_app/HomePage/Admin_Portal/Student_card/Student_search_card/studentAlldetail/tab/fee_history.dart';
import 'package:student_portal_app/HomePage/Admin_Portal/Student_card/Student_search_card/studentAlldetail/tab/fee_reicipt.dart';
import 'package:student_portal_app/HomePage/Admin_Portal/Student_card/Student_search_card/studentAlldetail/tab/other_fee.dart';
import 'package:student_portal_app/HomePage/Admin_Portal/Student_card/Student_search_card/studentAlldetail/tab/siblings.dart';
import 'package:student_portal_app/HomePage/Admin_Portal/Student_card/Student_search_card/studentAlldetail/tab/student_profile.dart';
import 'package:student_portal_app/component/alertdilog.dart';

class StudentAllinformation extends StatefulWidget {
  String regNo, name, pic;
  StudentAllinformation(this.regNo, this.name, this.pic);

  @override
  _StudentAllinformationState createState() =>
      _StudentAllinformationState(regNo, name, pic);
}

class _StudentAllinformationState extends State<StudentAllinformation> {
  String regNo, name, pic;
  _StudentAllinformationState(this.regNo, this.name, this.pic) {
    print(regNo);
    getData();
  }
  List sibling_list = [];
  List benificiarySibling = [];
  String total_pending = '0',
      presentClass = '',
      fname = 'NA',
      edu_fees = '0',
      session = 'NA';
  List fees_history = [], recipt_list = [], other_item_fees = [];
  List<bool> isSelected = [false, false, false, false];
  Future getData() async {
    print("run");
    var reg = {"regno": regNo};
    var response = await http
        .post(
            Uri.parse(
                "http://sniic.co.in/admin/school_app/Sibling_List_By_Reg_json.php"),
            body: json.encode(reg))
        .catchError((e) {
      if (e is SocketException)
        showMyDialog("Error", "No internet connection", context);
      setState(() {});
    });
    var obj = jsonDecode(response.body);
    if (obj["result"] == 'S') {
      print("++++++++++++++++++++++++++++++++++++++++++");
      // print(fees_history);
      // print(sibling_list);
      print(obj);
      // print("++++++++++++++++++++++++++++++++++++++++++++=");
      setState(() {
        sibling_list = obj["sibling_list"];
        // benificiarySibling=obj["benificiary_sibling"];
        total_pending = obj["total_pending"].toString();
        presentClass = obj["class"];
        fees_history = obj["fees_history"];
        recipt_list = obj["recipt_list"];
        session = obj["session"];
        fname = obj["fname"];
        edu_fees = obj["edu_fees"];
        other_item_fees = obj["other_item_fees"];
      });
      if (obj == null)
        showMyDialog("Server Error", "Somthing went wrong ", context);
    } else
      showMyDialog("Error", "Somthing went wrong ", context);
  }

  TextStyle _textStyle = TextStyle(
    color: Colors.black,
    fontSize: 15,
  );
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    //double width=MediaQuery.of(context).size.width;
    double radius = 50;
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Student Detail"),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: "Profile"),
              Tab(text: "Siblings"),
              Tab(text: "Fee History"),
              Tab(text: "Fee reciept"),
              Tab(text: "Attendance"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Profile(),
            Siblings(sibling_list: sibling_list),
            FeeHistory(fee_history: fees_history),
            FeeReciept(recipt_list: recipt_list),
            Attendance(
              regno: regNo,
            )
            // OtherFee(other_item_fees: other_item_fees),
          ],
        ),
      ),
    );
  }

  void showSiblings(context) {
    print(sibling_list);
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
              child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: (sibling_list.isNotEmpty)
                      ? ListView.builder(
                          itemCount: sibling_list.length,
                          itemBuilder: ((BuildContext context, int index) {
                            return ListTile(
                                leading: Icon(Icons.person),
                                // trailing: Text("GFG",
                                //   style: TextStyle(
                                //       color: Colors.green, fontSize: 15),),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("SrNo: " +
                                        sibling_list[index]["srno"].toString()),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("RegNo: " +
                                        sibling_list[index]["regno"]
                                            .toString()),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("Name: " +
                                        sibling_list[index]["name"].toString()),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("Father: " +
                                        sibling_list[index]["fname"]
                                            .toString()),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("Mother: " +
                                        sibling_list[index]["mname"]
                                            .toString()),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("Class: " +
                                        sibling_list[index]["class"]
                                            .toString()),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("Section: " +
                                        sibling_list[index]["section"]
                                            .toString()),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("Fee/month: " +
                                        sibling_list[index]["edufees"]
                                            .toString()),
                                    SizedBox(
                                      height: 10,
                                      child: Divider(
                                        color: Colors.red,
                                        thickness: 2,
                                      ),
                                    ),
                                  ],
                                ));
                          }))
                      : Padding(
                          padding: const EdgeInsets.only(
                              bottom: 128.0, top: 50, left: 50),
                          child: Text("No Record"),
                        )));
        });
  }

  void showFeeHistory(context) {
    print(fees_history);
    showModalBottomSheet(
        //isScrollControlled:true,
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
              child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: (fees_history.isNotEmpty)
                      ? ListView.builder(
                          itemCount: fees_history.length,
                          itemBuilder: ((BuildContext context, int index) {
                            return ListTile(
                                leading:
                                    Icon(Icons.account_balance_wallet_rounded),
                                // trailing: Text("GFG",
                                //   style: TextStyle(
                                //       color: Colors.green, fontSize: 15),),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Class: " +
                                        fees_history[index]["class"]
                                            .toString()),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("Season: " +
                                        fees_history[index]["ses"].toString()),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("Submitted Fee: " +
                                        fees_history[index]["submit_fees"]
                                            .toString()),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("Education Fee: " +
                                        fees_history[index]["edu_fees"]
                                            .toString()),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("Total Fee: " +
                                        fees_history[index]["total_fees"]
                                            .toString()),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("Pending Fee: " +
                                        fees_history[index]["pending_fees"]
                                            .toString()),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      height: 10,
                                      child: Divider(
                                        color: Colors.red,
                                        thickness: 2,
                                      ),
                                    ),
                                  ],
                                ));
                          }))
                      : Padding(
                          padding: const EdgeInsets.only(
                              bottom: 128.0, top: 50, left: 50),
                          child: Text("No Record"),
                        )));
        });
  }

  void showRecieptHistory(context) {
    print(recipt_list);
    showModalBottomSheet(
        //isScrollControlled:true,
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
              child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: (recipt_list.isNotEmpty)
                      ? ListView.builder(
                          itemCount: recipt_list.length,
                          itemBuilder: ((BuildContext context, int index) {
                            return ListTile(
                                leading:
                                    Icon(Icons.account_balance_wallet_outlined),
                                // trailing: Text("GFG",
                                //   style: TextStyle(
                                //       color: Colors.green, fontSize: 15),),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("SrNo: " +
                                        recipt_list[index]["sno"].toString()),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("Season: " +
                                        recipt_list[index]["ses"].toString()),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("Class: " +
                                        recipt_list[index]["class"].toString()),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("Date/Time: " +
                                        recipt_list[index]["dor"].toString()),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("Month Fee: " +
                                        recipt_list[index]["months_fees"]
                                            .toString()),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("Education Fee: " +
                                        recipt_list[index]["educational_fees"]
                                            .toString()),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("Remark: " +
                                        recipt_list[index]["remark"]
                                            .toString()),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      height: 10,
                                      child: Divider(
                                        color: Colors.red,
                                        thickness: 2,
                                      ),
                                    ),
                                  ],
                                ));
                          }))
                      : Padding(
                          padding: const EdgeInsets.only(
                              bottom: 128.0, top: 50, left: 50),
                          child: Text("No Record"),
                        )));
        });
  }

  void showOtherFee(context) {
    print(other_item_fees);
    showModalBottomSheet(
        //isScrollControlled:true,
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
              child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: (other_item_fees.isNotEmpty)
                      ? ListView.builder(
                          itemCount: other_item_fees.length,
                          itemBuilder: ((BuildContext context, int index) {
                            return ListTile(
                                leading: Icon(Icons.list),
                                // trailing: Text("GFG",
                                //   style: TextStyle(
                                //       color: Colors.green, fontSize: 15),),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("SrNo: " +
                                        other_item_fees[index]["recno"]
                                            .toString()),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("Items: " +
                                        other_item_fees[index]["items"]
                                            .toString()),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("Item Fee: " +
                                        other_item_fees[index]["item_fees"]
                                            .toString()),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("Remark: " +
                                        other_item_fees[index]["remark"]
                                            .toString()),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("Date: " +
                                        other_item_fees[index]["dor"]
                                            .toString()),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      height: 10,
                                      child: Divider(
                                        color: Colors.red,
                                        thickness: 2,
                                      ),
                                    ),
                                  ],
                                ));
                          }))
                      : Padding(
                          padding: const EdgeInsets.only(
                              bottom: 128.0, top: 50, left: 50),
                          child: Text("No Record"),
                        )));
        });
  }
}
/*SafeArea(
child: SingleChildScrollView(
child: Column(
children: [
Container(
height: 210,
decoration: BoxDecoration(
// color: Colors.teal,
// border: Border.all(color: Colors.black38),
borderRadius: BorderRadius.circular(10)
),
width: MediaQuery.of(context).size.width,
//padding: EdgeInsets.all(10),
child: Stack(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
children: [
Container(
width:width,
height: 150,
child: Image.asset("assets/images/top.jpg",fit: BoxFit.fill,),
),
Positioned(
top: 110,
left: width*.5-radius,
child: CircleAvatar(
radius: radius,
backgroundColor: Colors.red,
child: CircleAvatar(
backgroundImage: NetworkImage(pic,),
radius: radius-3,
),
),
),
],
),
),
Padding(
padding: const EdgeInsets.all(8.0),
child: Text(name,style: TextStyle(
color: Colors.teal,
fontWeight: FontWeight.w900,
fontStyle: FontStyle.italic,
fontFamily: 'Open Sans',
fontSize: 40
),),
),
Card(
child: Container(
width: width*.85,
// color: Colors.white,
// margin: EdgeInsets.only(left: 30),
child: Padding(
padding: const EdgeInsets.all(8.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
//Text("Sr.No:"+data["srno"],style: _textStyle,),
Text("Reg no :"+regNo,style: _textStyle,),
SizedBox(height: 5,),
Text("Class: "+presentClass,style: _textStyle,),
SizedBox(height: 5,),
Text("Session: "+session,style: _textStyle,),
SizedBox(height: 5,),
Text("Education Fee: "+edu_fees.toString(),style: _textStyle,),
],
),
),
),
),
Wrap(
children: [
Padding(
padding: const EdgeInsets.only(left: 8,right: 8,top: 4,bottom: 4),
child: OutlinedButton(style: ButtonStyle(
backgroundColor: MaterialStateProperty.all(Colors.teal),
),
onPressed: (){
print(sibling_list);
showSiblings(context);
},
child: Text("Siblings",style: TextStyle(color: Colors.white),),
),
),
Padding(
padding: const EdgeInsets.only(left: 8,right: 8,top: 4,bottom: 4),
child: OutlinedButton(style: ButtonStyle(
backgroundColor: MaterialStateProperty.all(Colors.teal),
),
onPressed:()=>showFeeHistory(context),
child: Text("Fee History",style: TextStyle(color: Colors.white),),
),
),
Padding(
padding: const EdgeInsets.only(left: 8,right: 8,top: 4,bottom: 4),
child: OutlinedButton(style: ButtonStyle(
backgroundColor: MaterialStateProperty.all(Colors.teal),
),
onPressed: (){
showRecieptHistory(context);
},
child: Text("Fee Receipt history",style: TextStyle(color: Colors.white),),
),
),
Padding(
padding: const EdgeInsets.only(left: 8,right: 8,top: 4,bottom: 4),
child: OutlinedButton(style: ButtonStyle(
backgroundColor: MaterialStateProperty.all(Colors.teal),
),
onPressed: (){
showMyDialog("Pending Fee", "Your pending fee is "+total_pending, context);
},
child: Text("Pending Fee",style: TextStyle(color: Colors.white),),
),
),
Padding(
padding: const EdgeInsets.only(left: 8,right: 8,top: 4,bottom: 4),
child: OutlinedButton(style: ButtonStyle(
backgroundColor: MaterialStateProperty.all(Colors.teal),
),
onPressed: (){
showOtherFee(context);
},
child: Text("Other Fee",style: TextStyle(color: Colors.white),),
),
),
Padding(
padding: const EdgeInsets.only(left: 8,right: 8,top: 4,bottom: 4),
child: OutlinedButton(
style: ButtonStyle(
backgroundColor: MaterialStateProperty.all(Colors.teal),
),
onPressed: (){
showSiblings(context);
},
child: Text("Submit Fee",style: TextStyle(color: Colors.white),),
),
),
],
),
],
),
),
),*/

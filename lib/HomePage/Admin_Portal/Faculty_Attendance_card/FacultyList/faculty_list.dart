import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:student_portal_app/HomePage/Admin_Portal/Faculty_Attendance_card/FacultyList/facultyDetail.dart';

import 'faculty_id_card_generator.dart';
class FacultyList extends StatefulWidget {
  const FacultyList({Key? key}) : super(key: key);
  @override
  _FacultyListState createState() => _FacultyListState();
}
class _FacultyListState extends State<FacultyList> {
  bool isLoading = false;
  String error = "";
  List facultyData = [];
  List facultyDataBackup = [];
  void initState(){
    loadFacultyDetails();
  }
  Future<void> loadFacultyDetails() async {
    isLoading=false;
      var response = await http.post(
          Uri.parse(
              "http://sniic.co.in/admin/school_app/staff_list_json.php"));
      // Getting Server response into variable.
      var obj = jsonDecode(response.body);
      if (obj["result"] == "S") {
        setState(() {
          error = "";
          isLoading = true;
          facultyData = facultyDataBackup=obj["data"];
        });
        print(facultyData);
      } else {
        print(obj["message"]);
        setState(() {
          isLoading = true;
          error = "Something Went Wrong";
        });
      }
  }
  bool isSearching=true;
  TextEditingController searchController=TextEditingController();
  searchFaculty(String query){
    List  searchData=[];
    for(Map x in facultyDataBackup){
      if(x["name"].toString().toLowerCase().contains(query.toLowerCase())) {
        searchData.add(x);
      }
      setState(() {
        facultyData=searchData;
      });
    }
    if(searchData.isEmpty) {
      return Fluttertoast.showToast(
        msg: "Faculty not found!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
      );
    }
    // print(searchData);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFF097272),
          title: isSearching?const Text("Faculty List")
              :TextField(
            controller:searchController ,
            style: const TextStyle(color: Colors.white),
            onChanged: (query){
              searchFaculty(query);
            },
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.white,
                  ),
                  onPressed:(){
                    setState(() {
                      facultyData=facultyDataBackup;
                      searchController.clear();
                      isSearching=true;
                    });
                  }
              ),
              hintText: 'Type Faculty Name..',
              hintStyle: TextStyle(
                  color: Colors.white
              ),
            ),
          ),
          actions: [
            isSearching?IconButton(
              icon: const Icon(Icons.search),
              onPressed: (){
                setState(() {
                  isSearching=false;
                });

              },):Text("")
          ]),
      body:isLoading?RefreshIndicator(
        onRefresh: loadFacultyDetails,
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.025,
          ),
          width: MediaQuery.of(context).size.width * 0.95,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: facultyData == [] ? 0 : facultyData.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 10, vertical: 10),
                margin: EdgeInsets.symmetric(vertical: 2.5),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: GestureDetector(
                  onTap: (){
                    Map data=facultyData[index];
                    print(data);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>FacultyDetail(data: data,)));
                  },
                  child: Row(
                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(facultyData[index]["pic"]),
                          backgroundColor: Colors.grey,
                          radius: 40,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width*.5,
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5),
                              child: Text(
                                facultyData[index]["name"],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(facultyData[index]["empid"]),
                            Text("Phone:"+facultyData[index]["phone"]),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>
                              FacultyIdCard(facultyData[index],))
                          );
                        },
                        child: Container(
                          // alignment: Alignment.centerRight,
                          height: 100,
                          child: Icon(Icons.qr_code_2,size: 50,),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ):Center(child: CircularProgressIndicator()),
    );
  }
}

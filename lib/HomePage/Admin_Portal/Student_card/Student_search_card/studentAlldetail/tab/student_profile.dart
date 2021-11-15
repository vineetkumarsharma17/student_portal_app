import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  TextStyle heading=TextStyle(
    color: Colors.black54,
    fontSize: 20,
    fontWeight: FontWeight.bold
  );
  TextStyle data_ts=TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold
  );
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width-15;
    return Container(
      margin: EdgeInsets.only(left: 10,right: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 100,
            backgroundImage: NetworkImage("http://sniic.co.in/admin/Student_Mang/pic/SNIICSTUD21102019735.jpg",),
            onBackgroundImageError: (_,__) {   },
            child: Icon(Icons.person,size: 100,),
          ),
          Text("Vineet kumar sharma",style: TextStyle(
            color: Colors.red,
            fontSize: 30,
            fontWeight: FontWeight.bold
          ),),
          SizedBox(height: 10,),
          Row(
            children: [
              Container(
                width: width*.35,
                child: Text("RegNo",style: heading,),
              ),
              Container(
                width: width*.03,
                child: Text(":",style: heading,),
              ),Container(
                width: width*.5,
                child: Text("1238238372938928398",style: data_ts,),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Container(
                width: width*.35,
                child: Text("Father",style: heading,),
              ),
              Container(
                width: width*.03,
                child: Text(":",style: heading,),
              ),Container(
                width: width*.5,
                child: Text("SANTOSH YADAV",style: data_ts,),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Container(
                width: width*.35,
                child: Text("Mother",style: heading,),
              ),
              Container(
                width: width*.03,
                child: Text(":",style: heading,),
              ),Container(
                width: width*.5,
                child: Text("Malti Devi",style: data_ts,),
              ),
            ],
          ),

          SizedBox(height: 10,),
          Row(
            children: [
              Container(
                width: width*.35,
                child: Text("Class",style: heading,),
              ),
              Container(
                width: width*.03,
                child: Text(":",style: heading,),
              ),Container(
                width: width*.5,
                child: Text("4th",style: data_ts,),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Container(
                width: width*.35,
                child: Text("Section",style: heading,),
              ),
              Container(
                width: width*.03,
                child: Text(":",style: heading,),
              ),Container(
                width: width*.5,
                child: Text("Section A",style: data_ts,),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Container(
                width: width*.35,
                child: Text("Education Fee",style: heading,),
              ),
              Container(
                width: width*.03,
                child: Text(":",style: heading,),
              ),Container(
                width: width*.5,
                child: Text("1238 Rs",style: data_ts,),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Container(
                width: width*.35,
                child: Text("Balance Fee",style: heading,),
              ),
              Container(
                width: width*.03,
                child: Text(":",style: heading,),
              ),Container(
                width: width*.5,
                child: Text("1238 Rs",style: data_ts,),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Container(
                width: width*.35,
                child: Text("Attendance",style: heading,),
              ),
              Container(
                width: width*.03,
                child: Text(":",style: heading,),
              ),Container(
                width: width*.5,
                child: Text("40/75",style: data_ts,),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Container(
                width: width*.35,
                child: Text("Transport",style: heading,),
              ),
              Container(
                width: width*.03,
                child: Text(":",style: heading,),
              ),Container(
                width: width*.5,
                child: Text("Yes",style: data_ts,),
              ),
            ],
          ),


        ],
      )
    );
  }
}
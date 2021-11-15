
import 'package:flutter/material.dart';
class FacultyDetail extends StatefulWidget {
  final Map data;
  const FacultyDetail({Key? key, required this.data}) : super(key: key);

  @override
  _FacultyDetailState createState() => _FacultyDetailState(data);
}
class information{
  final String k,v;

  information(this.k, this.v);
}

class _FacultyDetailState extends State<FacultyDetail> {
  final Map data;


  _FacultyDetailState(this.data);
  @override
  @override
  Widget build(BuildContext context) {
    TextStyle leftTextstyle=TextStyle(
        color: Colors.black,
        fontSize: 18,
      fontWeight: FontWeight.bold,
    );
    TextStyle rightTextstyle=TextStyle(
      color: Colors.black87,
      //fontSize: 18,
      fontWeight: FontWeight.bold,
    );
    SizedBox sb=SizedBox(
      width: MediaQuery.of(context).size.width*.8,
      child: Divider(
        color: Colors.black38,
        thickness: 1,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Faculty Detail"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width*.8,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(data["pic"]),
                  ),
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Employee id:",style: leftTextstyle,),
                    Text(data["empid"],style: rightTextstyle,),
                  ],
                ),SizedBox(
                  width: MediaQuery.of(context).size.width*.8,
                  child: Divider(
                    color: Colors.black38,
                    thickness: 1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Card no:",style: leftTextstyle,),
                    Text(data["cardno"],style: rightTextstyle,),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*.8,
                  child: Divider(
                    color: Colors.black38,
                    thickness: 1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Name:",style: leftTextstyle,),
                    Text(data["name"],style: rightTextstyle,),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*.8,
                  child: Divider(
                    color: Colors.black38,
                    thickness: 1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Phone:",style: leftTextstyle,),
                    Text(data["phone"],style: rightTextstyle,),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*.8,
                  child: Divider(
                    color: Colors.black38,
                    thickness: 1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Email:",style: leftTextstyle,),
                    Text(data["email"],style: rightTextstyle,),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*.8,
                  child: Divider(
                    color: Colors.black38,
                    thickness: 1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Gender:",style: leftTextstyle,),
                    Text((data["gender"])=="M"?"Male":"Female",style: rightTextstyle,),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*.8,
                  child: Divider(
                    color: Colors.black38,
                    thickness: 1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("DOB:",style: leftTextstyle,),
                    Text(data["dob"],style: rightTextstyle,),
                  ],
                ),SizedBox(
                  width: MediaQuery.of(context).size.width*.8,
                  child: Divider(
                    color: Colors.black38,
                    thickness: 1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Religion:",style: leftTextstyle,),
                    Text(data["religion"],style: rightTextstyle,),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*.8,
                  child: Divider(
                    color: Colors.black38,
                    thickness: 1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Marital status:",style: leftTextstyle,),
                    Text(data["married"],style: rightTextstyle,),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*.8,
                  child: Divider(
                    color: Colors.black38,
                    thickness: 1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Id proof:",style: leftTextstyle,),
                    Text(data["idproof"],style: rightTextstyle,),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*.8,
                  child: Divider(
                    color: Colors.black38,
                    thickness: 1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Id no:",style: leftTextstyle,),
                    Text(data["idno"],style: rightTextstyle,),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*.8,
                  child: Divider(
                    color: Colors.black38,
                    thickness: 1,
                  ),
                ),
                Row(
                  children: [
                    Text("Address:",style: leftTextstyle,),
                    Text(data["address"],style: rightTextstyle,),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*.8,
                  child: Divider(
                    color: Colors.black38,
                    thickness: 1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("City:",style: leftTextstyle,),
                    Text(data["city"],style: rightTextstyle,),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*.8,
                  child: Divider(
                    color: Colors.black38,
                    thickness: 1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Designation:",style: leftTextstyle,),
                    Text(data["desig"],style: rightTextstyle,),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*.8,
                  child: Divider(
                    color: Colors.black38,
                    thickness: 1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Employee type:",style: leftTextstyle,),
                    Text(data["emptype"],style: rightTextstyle,),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*.8,
                  child: Divider(
                    color: Colors.black38,
                    thickness: 1,
                  ),
                ),
                Row(
                  children: [
                    Text("Qualification:",style: leftTextstyle,),
                    Text(data["qualification"],style: rightTextstyle,),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*.8,
                  child: Divider(
                    color: Colors.black38,
                    thickness: 1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Experience:",style: leftTextstyle,),
                    Text(data["exp"],style: rightTextstyle,),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*.8,
                  child: Divider(
                    color: Colors.black38,
                    thickness: 1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Experties:",style: leftTextstyle,),
                    Text(data["experties"],style: rightTextstyle,),
                  ],
                ),SizedBox(
                  width: MediaQuery.of(context).size.width*.8,
                  child: Divider(
                    color: Colors.black38,
                    thickness: 1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Date of joining:",style: leftTextstyle,),
                    Text(data["doj"],style: rightTextstyle,),
                  ],
                ),SizedBox(
                  width: MediaQuery.of(context).size.width*.8,
                  child: Divider(
                    color: Colors.black38,
                    thickness: 1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Salary:",style: leftTextstyle,),
                    Text(data["salary"],style: rightTextstyle,),
                  ],
                ),SizedBox(
                  width: MediaQuery.of(context).size.width*.8,
                  child: Divider(
                    color: Colors.black38,
                    thickness: 1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("totalaprhol:",style: leftTextstyle,),
                    Text(data["totalaprhol"],style: rightTextstyle,),
                  ],
                ),SizedBox(
                  width: MediaQuery.of(context).size.width*.8,
                  child: Divider(
                    color: Colors.black38,
                    thickness: 1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Year:",style: leftTextstyle,),
                    Text(data["year"],style: rightTextstyle,),
                  ],
                ),






            ],),
          ),
        ),
      ),
    );
  }
}

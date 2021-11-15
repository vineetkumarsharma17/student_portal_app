import 'package:flutter/material.dart';

class Siblings extends StatefulWidget {
  final List sibling_list;

  const Siblings({Key? key, required this.sibling_list}) : super(key: key);
  @override
  State<Siblings> createState() => _SiblingsState(sibling_list);
}

class _SiblingsState extends State<Siblings> {
  List sibling_list;
  _SiblingsState(this.sibling_list);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Center(
            child:  (sibling_list.isNotEmpty)?ListView.builder(
    itemCount: sibling_list.length,
    itemBuilder: ((BuildContext context,int index)
    {
    return ListTile(
    leading: Icon(Icons.person),
    // trailing: Text("GFG",
    //   style: TextStyle(
    //       color: Colors.green, fontSize: 15),),
    title: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text("SrNo: "+sibling_list[index]["srno"].toString()),
    SizedBox(height: 5,),
    Text("RegNo: "+sibling_list[index]["regno"].toString()),
    SizedBox(height: 5,),
    Text("Name: "+sibling_list[index]["name"].toString()),
    SizedBox(height: 5,),
    Text("Father: "+sibling_list[index]["fname"].toString()),
    SizedBox(height: 5,),
    Text("Mother: "+sibling_list[index]["mname"].toString()),
    SizedBox(height: 5,),
    Text("Class: "+sibling_list[index]["class"].toString()),
    SizedBox(height: 5,),
    Text("Section: "+sibling_list[index]["section"].toString()),
    SizedBox(height: 5,),
    Text("Fee/month: "+sibling_list[index]["edufees"].toString()),
    SizedBox(height: 10,
    child: Divider(color: Colors.red,thickness: 2,),),
    ],
    )
    );
    })):Padding(
    padding: const EdgeInsets.only(bottom: 128.0,top: 50,left: 50),
    child: Text("No Record"),)
    )
    );
  }
}
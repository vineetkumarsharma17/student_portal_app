import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
class FacultyIdCard extends StatefulWidget {
  final Map data;
  FacultyIdCard(this.data);

  @override
  _FacultyIdCardState createState() => _FacultyIdCardState(data);
}

class _FacultyIdCardState extends State<FacultyIdCard> {
  var data;
  _FacultyIdCardState(this.data);
  initState(){

  }
var padding=const EdgeInsets.only(left:18.0);
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle=TextStyle(color: Colors.black);
    TextStyle textStyle2=TextStyle(color: Colors.white,
    fontSize: 34,
    fontWeight: FontWeight.bold,
    letterSpacing: 4);
    var width= MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Faculty Id Generator"),
      ),
      body: Center(child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(right: 10,left: 10),
          //width: MediaQuery.of(context).size.width*.95,
          //color: Colors.red,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/id_bg.jpg"),
                fit: BoxFit.fill,
              )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 80,
                  margin: EdgeInsets.only(top: 20),
                  width: width*.9,
                  // color: Colors.red,
                  child: Row(
                    children:[
                      Container(
                        width:width*.2,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/collage_logo.png"),
                          )
                        ),
                      ),
                    Container(
                      width: width*.5,
                      child: Column(
                        children: [
                          Text("SNIIC",style: textStyle2,),
                          Text("KUTUBPUR SULTANPUR UP",style: TextStyle(
                              color: Colors.white
                          ),)
                        ],
                      ),
                    ),

              ],
                  ),
                ),
                // Container(
                //   height: 80,
                //   margin: EdgeInsets.only(top: 20),
                //   width: width*.9,
                //  // color: Colors.red,
                //   child: ListTile(
                //     leading: CircleAvatar(
                //        backgroundColor: Colors.blue,
                //       backgroundImage: AssetImage("assets/images/collage_logo.png"),
                //      // radius: 49,
                //     ),
                //     title: Text("SNIIC",style: textStyle2,),
                //     subtitle: Text("KUTUBPUR SULTANPUR UP",style: TextStyle(
                //       color: Colors.white
                //     ),),
                //   ),
                // ),
                Padding(
                  padding:EdgeInsets.all(20),
                  child: CircleAvatar(
                    radius: 82,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: NetworkImage(data["pic"]),
                    ),
                  ),
                ),
                Padding(
                  padding:padding,
                  child: Container(
                    width: width*.9,
                    child:Text(data["name"],style:TextStyle(
                      color: Colors.teal,
                      fontSize: 34,
                      fontWeight: FontWeight.bold
                    ),) ,
                  ),
                ),
                Padding(
                  padding: padding,
                  child: Row(children: [
                    Container(
                      width: width*.25,
                      child:Text("ID ",style: textStyle,) ,
                    ),
                    Container(
                      width: width*.05,
                      child:Text(":",style: textStyle,) ,
                    ),
                    Container(
                      width: width*.6,
                      child:Text(data["empid"],style: textStyle,) ,
                    ),
                  ],),
                ),
                Padding(
                  padding:padding,
                  child: Row(children: [
                    Container(
                      width: width*.25,
                      child:Text("Email",style: textStyle,) ,
                    ),
                    Container(
                      width: width*.05,
                      child:Text(":",style: textStyle,) ,
                    ),
                    Container(
                      width: width*.6,
                      child:Text(data["email"],style: textStyle,) ,
                    ),
                  ],),
                ),
                Padding(
                  padding:padding,
                  child: Row(children: [
                    Container(
                      width: width*.25,
                      child:Text("Address",style: textStyle,) ,
                    ),
                    Container(
                      width: width*.05,
                      child:Text(":",style: textStyle,) ,
                    ),
                    Container(
                      width: width*.6,
                      child:Text(data["address"],style: textStyle,) ,
                    ),
                  ],),
                ),
                Padding(
                  padding:padding,
                  child: Row(children: [
                    Container(
                      width: width*.25,
                      child:Text("Contact\t: ",style: textStyle,) ,
                    ),
                    Container(
                      width: width*.05,
                      child:Text(":",style: textStyle,) ,
                    ),
                    Container(
                      width: width*.6,
                      child:Text(data["phone"],style: textStyle,) ,
                    ),
                  ],),
                ),
                Container(
                  alignment: Alignment.center,
                  //margin: EdgeInsets.only(top: 10),
                  //color: Colors.white,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 78.0),
                    child: QrImage(
                      data: data["empid"],
                      version: QrVersions.auto,
                      size: 200.0,
                      foregroundColor: Colors.black,
                    ),
                  ),
                )

              ],
            )
          ),
        ),
      ),),
    );
  }
}

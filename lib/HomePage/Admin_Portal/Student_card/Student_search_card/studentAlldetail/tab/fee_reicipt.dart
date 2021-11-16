import 'package:flutter/material.dart';

class FeeReciept extends StatefulWidget {
  final List recipt_list;

  const FeeReciept({Key? key, required this.recipt_list}) : super(key: key);
  @override
  State<FeeReciept> createState() => _FeeRecieptState(recipt_list);
}

class _FeeRecieptState extends State<FeeReciept> {
  List recipt_list;
  _FeeRecieptState(this.recipt_list);
  @override
  Widget build(BuildContext context) {
    // print("======================================");
    // print(recipt_list);
    double width=MediaQuery.of(context).size.width-20;
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Center(
            child: (recipt_list.isNotEmpty)?ListView.builder(
                itemCount: recipt_list.length,
                itemBuilder: ((BuildContext context,int index)
                {
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    elevation: 7,
                    child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Container(
                                  width: width*.35,
                                  child: Text("SrNo",),
                                ),
                                Container(
                                  width: width*.03,
                                  child: Text(":",),
                                ),Container(
                                  width: width*.5,
                                  child: Text(recipt_list[index]["sno"].toString()),
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Container(
                                  width: width*.35,
                                  child: Text("Season",),
                                ),
                                Container(
                                  width: width*.03,
                                  child: Text(":",),
                                ),Container(
                                  width: width*.5,
                                  child: Text(recipt_list[index]["ses"].toString()),
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Container(
                                  width: width*.35,
                                  child: Text("Class",),
                                ),
                                Container(
                                  width: width*.03,
                                  child: Text(":",),
                                ),Container(
                                  width: width*.5,
                                  child: Text(recipt_list[index]["class"].toString()),
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Container(
                                  width: width*.35,
                                  child: Text("Date/Time",),
                                ),
                                Container(
                                  width: width*.03,
                                  child: Text(":",),
                                ),Container(
                                  width: width*.5,
                                  child: Text(recipt_list[index]["dor"].toString()),
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Container(
                                  width: width*.35,
                                  child: Text("Date/Time",),
                                ),
                                Container(
                                  width: width*.03,
                                  child: Text(":",),
                                ),Container(
                                  width: width*.5,
                                  child: Text(recipt_list[index]["dor"].toString()),
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),

                            Row(
                              children: [
                                Container(
                                  width: width*.35,
                                  child: Text("Month Fee",),
                                ),
                                Container(
                                  width: width*.03,
                                  child: Text(":",),
                                ),Container(
                                  width: width*.5,
                                  child: Text(recipt_list[index]["months_fees"].toString()),
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Container(
                                  width: width*.35,
                                  child: Text("Education Fee",),
                                ),
                                Container(
                                  width: width*.03,
                                  child: Text(":",),
                                ),Container(
                                  width: width*.5,
                                  child: Text(recipt_list[index]["educational_fees"].toString()),
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Container(
                                  width: width*.35,
                                  child: Text("Remark",),
                                ),
                                Container(
                                  width: width*.03,
                                  child: Text(":",),
                                ),Container(
                                  width: width*.5,
                                  child: Text(recipt_list[index]["remark"].toString()),
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                          ],
                        )
                    ),
                  );
                })):Padding(
              padding: const EdgeInsets.only(bottom: 128.0,top: 50,left: 50),
              child: Text("No Record"),)
        )
    );
  }
}
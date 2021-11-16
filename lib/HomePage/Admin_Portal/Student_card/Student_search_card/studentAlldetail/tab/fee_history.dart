import 'package:flutter/material.dart';

class FeeHistory extends StatefulWidget {
  final List fee_history;

  const FeeHistory({Key? key, required this.fee_history}) : super(key: key);
  @override
  State<FeeHistory> createState() => _FeeHistoryState(fee_history);
}

class _FeeHistoryState extends State<FeeHistory> {
  List fees_history;
  _FeeHistoryState(this.fees_history);
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width-20;
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Center(
          child: (fees_history.isNotEmpty)?ListView.builder(
              itemCount: fees_history.length,
              itemBuilder: ((BuildContext context,int index)
              {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  elevation: 7,
                  child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10,),
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
                                child: Text(fees_history[index]["class"].toString()),
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
                                child: Text(fees_history[index]["ses"].toString()),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Container(
                                width: width*.35,
                                child: Text("Submitted Fee",),
                              ),
                              Container(
                                width: width*.03,
                                child: Text(":",),
                              ),Container(
                                width: width*.5,
                                child: Text(fees_history[index]["submit_fees"].toString()),
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
                                child: Text(fees_history[index]["edu_fees"].toString()),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Container(
                                width: width*.35,
                                child: Text("Total fee",),
                              ),
                              Container(
                                width: width*.03,
                                child: Text(":",),
                              ),Container(
                                width: width*.5,
                                child: Text(fees_history[index]["total_fees"].toString()),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Container(
                                width: width*.35,
                                child: Text("Pending fee",),
                              ),
                              Container(
                                width: width*.03,
                                child: Text(":",),
                              ),Container(
                                width: width*.5,
                                child: Text(fees_history[index]["pending_fees"].toString()),
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
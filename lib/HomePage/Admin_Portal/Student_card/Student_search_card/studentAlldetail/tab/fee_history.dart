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
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Center(
          child: (fees_history.isNotEmpty)?ListView.builder(
              itemCount: fees_history.length,
              itemBuilder: ((BuildContext context,int index)
              {
                return ListTile(
                    leading: Icon(Icons.account_balance_wallet_rounded),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Class: "+fees_history[index]["class"].toString()),
                        SizedBox(height: 5,),
                        Text("Season: "+fees_history[index]["ses"].toString()),
                        SizedBox(height: 5,),
                        Text("Submitted Fee: "+fees_history[index]["submit_fees"].toString()),
                        SizedBox(height: 5,),
                        Text("Education Fee: "+fees_history[index]["edu_fees"].toString()),
                        SizedBox(height: 5,),
                        Text("Total Fee: "+fees_history[index]["total_fees"].toString()),
                        SizedBox(height: 5,),
                        Text("Pending Fee: "+fees_history[index]["pending_fees"].toString()),
                        SizedBox(height: 5,),
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
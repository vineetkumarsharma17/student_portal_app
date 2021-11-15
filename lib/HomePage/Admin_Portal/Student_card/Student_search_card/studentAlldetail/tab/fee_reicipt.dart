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
    print("======================================");
    print(recipt_list);

    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Center(
            child: (recipt_list.isNotEmpty)?ListView.builder(
                itemCount: recipt_list.length,
                itemBuilder: ((BuildContext context,int index)
                {
                  return ListTile(
                      leading: Icon(Icons.account_balance_wallet_outlined),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("SrNo: "+recipt_list[index]["sno"].toString()),
                          SizedBox(height: 5,),
                          Text("Season: "+recipt_list[index]["ses"].toString()),
                          SizedBox(height: 5,),
                          Text("Class: "+recipt_list[index]["class"].toString()),
                          SizedBox(height: 5,),
                          Text("Date/Time: "+recipt_list[index]["dor"].toString()),
                          SizedBox(height: 5,),
                          Text("Month Fee: "+recipt_list[index]["months_fees"].toString()),
                          SizedBox(height: 5,),
                          Text("Education Fee: "+recipt_list[index]["educational_fees"].toString()),
                          SizedBox(height: 5,),
                          Text("Remark: "+recipt_list[index]["remark"].toString()),
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
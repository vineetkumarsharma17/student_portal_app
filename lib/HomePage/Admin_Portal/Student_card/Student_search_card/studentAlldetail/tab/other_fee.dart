import 'package:flutter/material.dart';

class OtherFee extends StatefulWidget {
  final List other_item_fees;

  const OtherFee({Key? key, required this.other_item_fees}) : super(key: key);
  @override
  State<OtherFee> createState() => _OtherFeeState(other_item_fees);
}

class _OtherFeeState extends State<OtherFee> {
  List other_item_fees;
  _OtherFeeState(this.other_item_fees);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Center(
            child:  (other_item_fees.isNotEmpty)?ListView.builder(
    itemCount: other_item_fees.length,
    itemBuilder: ((BuildContext context,int index)
    {
    return ListTile(
    leading: Icon(Icons.list),
    // trailing: Text("GFG",
    //   style: TextStyle(
    //       color: Colors.green, fontSize: 15),),
    title: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text("SrNo: "+other_item_fees[index]["recno"].toString()),
    SizedBox(height: 5,),
    Text("Items: "+other_item_fees[index]["items"].toString()),
    SizedBox(height: 5,),
    Text("Item Fee: "+other_item_fees[index]["item_fees"].toString()),
    SizedBox(height: 5,),
    Text("Remark: "+other_item_fees[index]["remark"].toString()),
    SizedBox(height: 5,),
    Text("Date: "+other_item_fees[index]["dor"].toString()),
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
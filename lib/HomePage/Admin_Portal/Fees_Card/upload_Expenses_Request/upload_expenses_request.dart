import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_portal_app/component/alertdilog.dart';
import 'package:student_portal_app/component/image_pick_camera_gallry.dart';
import 'package:http/http.dart' as http;
class UploadExpensRequest extends StatefulWidget {
  const UploadExpensRequest({Key? key}) : super(key: key);

  @override
  _UploadExpensRequestState createState() => _UploadExpensRequestState();
}

class _UploadExpensRequestState extends State<UploadExpensRequest> {
  TextEditingController title = TextEditingController();
  TextEditingController detail = TextEditingController();
  TextEditingController transfer_type = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController add_by = TextEditingController();
  XFile? uploadimage;
  bool isLoading = false;
  String error = "";
  imagePickFromMobile pic=new imagePickFromMobile();
  Future<void> uploadexpens() async {
    if (add_by.text.isNotEmpty &&
        amount.text.isNotEmpty &&
        detail.text.isNotEmpty &&
        transfer_type.text.isNotEmpty &&
        title.text.isNotEmpty &&
        uploadimage != null)
    {
      setState(() {
        error = "";
        isLoading = true;
      });
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              "http://sniic.co.in/admin/school_app/inventory/Upload_Expense_Request.php"));

      request.files
          .add(await http.MultipartFile.fromPath('image', uploadimage!.path));

      request.fields["title"] = title.text;
      request.fields["detail"] = detail.text;
      request.fields["trans_type"] = transfer_type.text;
      request.fields["amount"] = amount.text;
      request.fields["addby"] = add_by.text;
      var res = await request.send();
      res.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
      if (res.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        showMyDialog("Success","Upload expenses Successfull",context);
      } else {
        setState(() {
          isLoading = false;
          error = "Error during connection to server";
        });
      }
    } else {
      setState(() {
        error = "Please Filled All Field Properly";
        isLoading = false;
      });
      showMyDialog("Error",error,context);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Expense Request"),
      ),
      body:  Container(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 30,
                        ),
                        child: CircleAvatar(
                          radius: 80,
                          backgroundColor: Color(0xFFFFFFFF),
                          child: CircleAvatar(
                              radius: 78,
                              backgroundImage: uploadimage != null
                                  ? FileImage(
                                File(uploadimage!.path),
                              )
                                  : null,
                          child: uploadimage == null?Text("Click Bill Image"):null,),
                        ),
                      ),
                      Positioned(
                          top: 100,
                          left: 120,
                          child: RawMaterialButton(
                            fillColor: Color(0xFF097272),
                            onPressed: () {
                              pic.showPicker(context);
                              print(pic.getFile());
                            },
                            child: Icon(
                              Icons.add_a_photo,
                              color: Color(0xFFFFFFFF),
                            ),
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(10.0),
                          ))
                    ],
                  ),
                ),SizedBox(
                  height: 10,
                ),
                Container(
                  //color: Color(0xFFFFFFFF),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: title,
                      onChanged: (value){
                        setState(() {
                          uploadimage=pic.getFile();
                        });
                      },
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: Colors.black,
                          size: 24,
                        ),
                        border: InputBorder.none,
                        labelText: "Title",
                        hintText: "Enter Title",
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  //color: Color(0xFFFFFFFF),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: detail,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: Colors.black,
                          size: 24,
                        ),
                        border: InputBorder.none,
                        labelText: "Detail",
                        hintText: "Enter Details",
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  //color: Color(0xFFFFFFFF),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: transfer_type,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: Colors.black,
                          size: 24,
                        ),
                        border: InputBorder.none,
                        labelText: "Transefer type",
                        hintText: "Enter Transfer Type",
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  //color: Color(0xFFFFFFFF),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: amount,
                      //maxLength: 10,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        //   counterStyle: TextStyle(height: double.minPositive,),
                        counterText: "",
                        icon: Icon(
                          Icons.phone_android,
                          color: Colors.black,
                          size: 24,
                        ),
                        border: InputBorder.none,
                        labelText: "Amount",
                        hintText: "Enter Amount",
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  //color: Color(0xFFFFFFFF),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: add_by,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.email_rounded,
                          color: Colors.black,
                          size: 24,
                        ),
                        border: InputBorder.none,
                        labelText: "Added By",
                        hintText: "Enter name",
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ), SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.1,
                  ),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF097272),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      uploadexpens();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: isLoading != false
                          ? Text(
                        "Saving.....",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                          : Text(
                        "Save & Next",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

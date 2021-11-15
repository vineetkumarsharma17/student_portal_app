import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student_portal_app/HomePage/Admin_Portal/Student_card/Student_Admission/MothersDetail/MothersDetail.dart';

class FathersDetail extends StatefulWidget {
  const FathersDetail({Key? key}) : super(key: key);
  @override
  _FathersDetailState createState() => _FathersDetailState();
}

class _FathersDetailState extends State<FathersDetail> {
  bool isLoading = false;
  TextEditingController fatherName = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController profession = TextEditingController();
  TextEditingController designation = TextEditingController();
  String? dob;
  String? dateOfBirth;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFBCEBEB),
      appBar: AppBar(
        backgroundColor: Color(0xFF097272),
        title: Text("Father's Detail"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1,
          vertical: 40,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                    controller: fatherName,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: Colors.black,
                        size: 24,
                      ),
                      border: InputBorder.none,
                      labelText: "Name",
                      hintText: "Enter Father's Name",
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
                    controller: mobile,
                    maxLength: 10,
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
                      labelText: "Mobile",
                      hintText: "Enter Mobile",
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
                    controller: email,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.email_rounded,
                        color: Colors.black,
                        size: 24,
                      ),
                      border: InputBorder.none,
                      labelText: "Email",
                      hintText: "Enter Email",
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
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: DateTimeFormField(
                    dateFormat: DateFormat.yMd(),
                    decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        hintText: "mm/dd/yyyy",
                        labelText: 'Date of Birth',
                        icon: Icon(
                          Icons.event_note,
                          color: Colors.black,
                        )),
                    mode: DateTimeFieldPickerMode.date,
                    autovalidateMode: AutovalidateMode.always,
                    onDateSelected: (value) {
                      setState(() {
                        dob = value.day.toString() +
                            "/" +
                            value.month.toString() +
                            "/" +
                            value.year.toString();
                      });
                    },
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
                    controller: profession,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.work_outline,
                        color: Colors.black,
                        size: 24,
                      ),
                      border: InputBorder.none,
                      hintText: "Enter Profession",
                      labelText: "Profession",
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
                    controller: designation,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.work_outline,
                        color: Colors.black,
                        size: 24,
                      ),
                      border: InputBorder.none,
                      hintText: "Enter Designation",
                      labelText: "Designation",
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
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: DateTimeFormField(
                    dateFormat: DateFormat.yMd(),
                    decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        hintText: "mm/dd/yyyy",
                        labelText: 'Date of Anniversary',
                        icon: Icon(
                          Icons.event_note,
                          color: Colors.black,
                        )),
                    mode: DateTimeFieldPickerMode.date,
                    autovalidateMode: AutovalidateMode.always,
                    onDateSelected: (value) {
                      setState(() {
                        dateOfBirth = value.day.toString() +
                            "/" +
                            value.month.toString() +
                            "/" +
                            value.year.toString();
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 5,
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
                    //   if(_formKey.currentState!.validate()){
                    //     uploadPersonalInfo();
                    //
                    // }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MothersDetail()));
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

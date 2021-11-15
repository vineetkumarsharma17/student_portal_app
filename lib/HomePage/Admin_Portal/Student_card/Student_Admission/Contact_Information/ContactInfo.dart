import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:student_portal_app/HomePage/Admin_Portal/Student_card/Student_Admission/Official_Details/OfficialStudentInfo.dart';

class ContactInfo extends StatefulWidget {
  final String regNum;
  ContactInfo(this.regNum);

  @override
  _ContactInfoState createState() => _ContactInfoState(regNum);
}

class _ContactInfoState extends State<ContactInfo> {
  String regNumber;
  _ContactInfoState(this.regNumber);
  String error = "";
  bool isLoading = false;
  String? stateName;
  List stateList = [
    "Andhra Pradesh",
    "Arunachal Pradesh",
    "Assam",
    "Bihar",
    "Chhattisgarh",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Odisha",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttar Pradesh",
    "Uttarakhand",
    "West Bengal",
    "Delhi",
    "Jammu Kashmir",
  ];
  TextEditingController address = new TextEditingController();
  TextEditingController city = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController mobileNumber = new TextEditingController();

  Future<void> contactInfoUpdate() async {
    print("hello");
    if (regNumber.isNotEmpty &&
        address.text.isNotEmpty &&
        city.text.isNotEmpty &&
        stateName!.isNotEmpty &&
        email.text.isNotEmpty &&
        mobileNumber.text.isNotEmpty) {
      setState(() {
        error = "";
        isLoading = true;
      });

      var data = {
        "address": address.text,
        "city": city.text,
        "state": stateName,
        "email": email.text,
        "phoneno": mobileNumber.text,
        "regno": regNumber
      };
      var response = await http.post(
          Uri.parse(
              "http://sniic.co.in/admin/school_app/student_contact_detail.php"),
          body: json.encode(data));
      var obj = jsonDecode(response.body);
      if (obj['result'] == "S") {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => OfficialStudentInfo()));
      }
    } else {
      setState(() {
        isLoading = false;
        error = "Please Filled All Details properly";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFBCEBEB),
      appBar: AppBar(
        backgroundColor: Color(0xFF097272),
        title: Text(
          "Contact Information",
          style: TextStyle(
            color: Color(0xFFFFFFFF),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .1,
          vertical: 40,
        ),
        width: MediaQuery.of(context).size.width * 0.8,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                //color: Color(0xFFFFFFFF),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: TextFormField(
                    controller: address,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.home_rounded,
                        color: Colors.black,
                        size: 24,
                      ),
                      border: InputBorder.none,
                      hintText: "Enter Address",
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: TextFormField(
                    controller: city,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.location_city,
                        color: Colors.black,
                        size: 24,
                      ),
                      border: InputBorder.none,
                      hintText: "Enter City",
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
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "State:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 45, right: 20),
                          child: DropdownButton(
                            isExpanded: true,
                            underline: Text(""),
                            hint: Text("Select State"),
                            value: stateName,
                            items: stateList.map<DropdownMenuItem<String>>((e) {
                              return DropdownMenuItem<String>(
                                child: Text(e),
                                value: e,
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                stateName = value.toString();
                                print(stateName);
                              });
                            },
                          ),
                        ),
                      ),
                    ],
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.email_rounded,
                        color: Colors.black,
                        size: 24,
                      ),
                      border: InputBorder.none,
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
                //color: Color(0xFFFFFFFF),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: TextFormField(
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    controller: mobileNumber,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.phone_android_outlined,
                        color: Colors.black,
                        size: 24,
                      ),
                      border: InputBorder.none,
                      counterText: "",
                      hintText: "Enter Mobile Number",
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
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF097272),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {
                    contactInfoUpdate();
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
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:student_portal_app/HomePage/Admin_Portal/Student_card/Student_Admission/FathersDetail/FathersDetail.dart';

class GaurdianDetail extends StatefulWidget {
  const GaurdianDetail({Key? key}) : super(key: key);
  @override
  _GaurdianDetailState createState() => _GaurdianDetailState();
}

class _GaurdianDetailState extends State<GaurdianDetail> {
  bool isLoading = false;
  TextEditingController guardianName = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController idNum = TextEditingController();
  List idTypeList = ["Aadhar no", "Pan Card no", "Voter id no", "Other"];
  String? idType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFBCEBEB),
      appBar: AppBar(
        backgroundColor: Color(0xFF097272),
        title: Text("Garudian Detail"),
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
                    controller: guardianName,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: Colors.black,
                        size: 24,
                      ),
                      border: InputBorder.none,
                      labelText: "Guardian Name",
                      hintText: "Enter Guardian Name",
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
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.phone_iphone_rounded,
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
                //color: Color(0xFFFFFFFF),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "ID Type:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * .1,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: idType,
                              items: idTypeList.map((e) {
                                return DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  idType = value.toString();
                                });
                              },
                              isExpanded: true,
                              hint: Text("Select ID Type"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ), //id type
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
                    controller: guardianName,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.perm_identity_rounded,
                        color: Colors.black,
                        size: 24,
                      ),
                      border: InputBorder.none,
                      labelText: "Id no",
                      hintText: "Enter Id number",
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
                            builder: (context) => FathersDetail()));
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

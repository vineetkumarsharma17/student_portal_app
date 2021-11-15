import 'package:flutter/material.dart';

class SubmitStudentFeesDetails extends StatefulWidget {
  SubmitStudentFeesDetails({Key? key}) : super(key: key);

  @override
  _SubmitStudentFeesDetailsState createState() =>
      _SubmitStudentFeesDetailsState();
}

class _SubmitStudentFeesDetailsState extends State<SubmitStudentFeesDetails> {
  bool isLoading = false;
  String error = "";
  String checkFeesOption = "";
  TextEditingController rollNumber = new TextEditingController();
  TextEditingController nameWise = new TextEditingController();
  TextEditingController mobileNumber = new TextEditingController();
  List studentFeeList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFBCEBEB),
      appBar: AppBar(
        backgroundColor: Color(0xFF097272),
        title: Text("Check Student's Fees"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.025),
        width: MediaQuery.of(context).size.width * 0.95,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Radio(
                      value: "rollNumber",
                      groupValue: checkFeesOption,
                      onChanged: (value) {
                        setState(() {
                          checkFeesOption = value.toString();
                          print(checkFeesOption);
                        });
                      }),
                  Text("Roll Number:"),
                  Radio(
                      value: "name",
                      groupValue: checkFeesOption,
                      onChanged: (value) {
                        setState(() {
                          checkFeesOption = value.toString();
                          print(checkFeesOption);
                        });
                      }),
                  Text("Name:"),
                  Radio(
                      value: "mobile",
                      groupValue: checkFeesOption,
                      onChanged: (value) {
                        setState(() {
                          checkFeesOption = value.toString();
                          print(checkFeesOption);
                        });
                      }),
                  Text("Mobile Number"),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              //color: Color(0xFFFFFFFF),
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(5),
              ),
              child: checkFeesOption == "rollNumber"
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: TextFormField(
                        controller: rollNumber,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.search_rounded,
                            color: Colors.black,
                            size: 24,
                          ),
                          border: InputBorder.none,
                          hintText: "Enter Student Roll Number",
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    )
                  : checkFeesOption == "name"
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: TextFormField(
                            controller: nameWise,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.person_rounded,
                                color: Colors.black,
                                size: 24,
                              ),
                              border: InputBorder.none,
                              hintText: "Enter Student Name",
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        )
                      : checkFeesOption == "mobile"
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: TextFormField(
                                controller: mobileNumber,
                                decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.phone_iphone_rounded,
                                    color: Colors.black,
                                    size: 24,
                                  ),
                                  border: InputBorder.none,
                                  hintText: "Enter Student Mobile Number",
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            )
                          : Text(""),
            ),
            Container(
              child: error != ""
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        error,
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                        textAlign: TextAlign.left,
                      ),
                    )
                  : Text(""),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              child: checkFeesOption != ""
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF097272),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () {
                        //searchStudentDetails();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: isLoading != false
                            ? Text(
                                "Searching.....",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            : Text(
                                "Search",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    )
                  : Text(""),
            ),
            Container(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: studentFeeList == [] ? 0 : studentFeeList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          margin: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Row(
                            children: [
                              Container(
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  child: Icon(
                                    Icons.person_outlined,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                child: Column(
                                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Text(
                                        studentFeeList[index]["name"],
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Text(studentFeeList[index]["class"]),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

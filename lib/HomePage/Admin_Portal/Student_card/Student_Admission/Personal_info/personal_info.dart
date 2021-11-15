import 'dart:convert';
import 'dart:io';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:student_portal_app/HomePage/Admin_Portal/Student_card/Student_Admission/Contact_Information/ContactInfo.dart';

class RegisterPersonalInfo extends StatefulWidget {
  const RegisterPersonalInfo({Key? key}) : super(key: key);

  @override
  _RegisterPersonalInfoState createState() => _RegisterPersonalInfoState();
}

class _RegisterPersonalInfoState extends State<RegisterPersonalInfo> {
  String error = "";
  bool isLoading = false;
  TextEditingController registrationNo = TextEditingController();
  TextEditingController scholarId = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController boardRegNo = TextEditingController();
  TextEditingController aadharCard = TextEditingController();
  String? gender;
  String? dob;
  String? admissionDate;
  List categoryList = ["Genral", "OBC", "SC/ST", "Other"];
  String? bloodGroup;
  List bloodGroupList = ["A+", "B+", "O-", "O+", "Other"];
  String? category;
  String? group;
  List groupList = ["New Student", "Staff", "Ex Employee", "Other"];
  List religionList = ["Hindu", "Muslim", "Sikh", "Christian", "Other"];
  String? religion;

  ImagePicker picker = new ImagePicker();
  XFile? uploadimage;
  @override
  void initState() {
    getRegNo();
    super.initState();
  }

  Future getRegNo() async {
    var attendance = {};
    var response1 = await http.post(
        Uri.parse(
            "http://sniic.co.in/admin/school_app/genrate_studentRegNo.php"),
        body: json.encode(attendance));
    var obj1 = jsonDecode(response1.body);
    if (obj1["result"] == 'S') {
      setState(() {
        registrationNo.text = obj1["regno"];
      });
    } else {
      setState(() {
        error = "Registration is not Valid";
      });
    }
  }

  Future<void> uploadPersonalInfo() async {
    if (admissionDate!.isNotEmpty &&
        registrationNo.text.isNotEmpty &&
        scholarId.text.isNotEmpty &&
        name.text.isNotEmpty &&
        boardRegNo.text.isNotEmpty &&
        aadharCard.text.isNotEmpty &&
        gender!.isNotEmpty &&
        category!.isNotEmpty &&
        dob!.isNotEmpty &&
        group!.isNotEmpty &&
        bloodGroup!.isNotEmpty &&
        religion!.isNotEmpty &&
        uploadimage != null) {
      setState(() {
        error = "";
        isLoading = true;
      });
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              "http://sniic.co.in/admin/school_app/student_personal_detail.php"));

      request.files
          .add(await http.MultipartFile.fromPath('image', uploadimage!.path));

      request.fields["add_date"] = admissionDate!;
      request.fields["regno"] = registrationNo.text;
      request.fields["scholorid"] = scholarId.text;
      request.fields["name"] = name.text;
      request.fields["boardregno"] = boardRegNo.text;
      request.fields["adharid"] = aadharCard.text;
      request.fields["gender"] = gender!;
      request.fields["category"] = category!;
      request.fields["dob"] = dob!;
      request.fields["group"] = group!;
      request.fields["bloodgroup"] = bloodGroup!;
      request.fields["rel"] = religion!;
      var res = await request.send();
      res.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
      if (res.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ContactInfo(registrationNo.text)));
        print(res);
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFBCEBEB),
      appBar: AppBar(
        backgroundColor: Color(0xFF097272),
        title: Text("Personal Information"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  _showPicker(context);
                },
                child: uploadimage == null
                    ? Container(
                        width: 150.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white54),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.add_a_photo_outlined,
                          size: 100,
                          color: Colors.white54,
                        ),
                      )
                    : Container(
                        width: 150.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(File(uploadimage!.path)),
                          ),
                        ),
                      ),
              ),
              Card(
                // elevation: 7,
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .10,
                    vertical: 5),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: DateTimeFormField(
                    onDateSelected: (DateTime value) {
                      admissionDate = value.day.toString() +
                          "/" +
                          value.month.toString() +
                          "/" +
                          value.year.toString();
                      print(admissionDate);
                    },
                    dateFormat: DateFormat.yMd(),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      errorStyle: TextStyle(color: Colors.redAccent),
                      icon: Icon(Icons.event_note),
                      labelText: 'Admission Date',
                      hintText: 'mm/dd/yyyy',
                    ),
                    mode: DateTimeFieldPickerMode.date,
                    autovalidateMode: AutovalidateMode.always,
                  ),
                ),
              ),
              Card(
                // elevation: 7,
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .10,
                    vertical: 5),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: registrationNo,
                    enabled: false,
                    decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        labelText: "Registration Number",
                        border: InputBorder.none),
                  ),
                ),
              ),
              Card(
                //elevation: 7,
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .10,
                    vertical: 5),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: scholarId,
                    decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        hintText: "Scholar Id",
                        labelText: "Scholar Id",
                        border: InputBorder.none),
                  ),
                ),
              ),
              Card(
                //elevation: 7,
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .10,
                    vertical: 5),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        hintText: "Name",
                        labelText: "Name",
                        border: InputBorder.none),
                  ),
                ),
              ),
              Card(
                //elevation: 7,
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .10,
                    vertical: 5),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: boardRegNo,
                    decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        hintText: "Board Reg. Number",
                        labelText: "Board Reg. Number",
                        border: InputBorder.none),
                  ),
                ),
              ),
              Card(
                // elevation: 7,
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .10,
                    vertical: 5),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: TextFormField(
                    controller: aadharCard,
                    decoration: InputDecoration(
                        icon: Icon(Icons.calendar_today),
                        hintText: "Aadhar Card",
                        labelText: "Aadhar Card",
                        border: InputBorder.none),
                  ),
                ),
              ),
              Card(
                // elevation: 7,
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .10,
                    vertical: 5),
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0, top: 10),
                          child: Text(
                            "Gender:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Radio(
                                value: "Male",
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value.toString();
                                    print(gender);
                                  });
                                }),
                            Text("Male:"),
                            Radio(
                                value: "Female",
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value.toString();
                                    print(gender);
                                  });
                                }),
                            Text("Female:"),
                            Radio(
                                value: "Other",
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value.toString();
                                    print(gender);
                                  });
                                }),
                            Text("Other"),
                          ],
                        ),
                      ],
                    )),
              ),
              Card(
                // elevation: 7,
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .10,
                    vertical: 5),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Category:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 45, right: 20),
                            child: DropdownButton(
                              isExpanded: true,
                              underline: Text(""),
                              hint: Text("Select Category"),
                              value: category,
                              items: categoryList
                                  .map<DropdownMenuItem<String>>((e) {
                                return DropdownMenuItem<String>(
                                  child: Text(e),
                                  value: e,
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  category = value.toString();
                                  print(category);
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              Card(
                // elevation: 7,
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .10,
                    vertical: 5),
                child: DateTimeFormField(
                  dateFormat: DateFormat.yMd(),
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.black, fontSize: 16),
                      border: InputBorder.none,
                      errorStyle: TextStyle(color: Colors.redAccent),
                      prefixIcon: Icon(Icons.event_note),
                      hintText: 'mm/dd/yyyy',
                      labelText: "Date of Birth"),
                  mode: DateTimeFieldPickerMode.date,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (e) =>
                      (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                  onDateSelected: (DateTime value) {
                    dob = value.day.toString() +
                        "/" +
                        value.month.toString() +
                        "/" +
                        value.year.toString();
                  },
                ),
              ),
              Card(
                // elevation: 7,
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .10,
                    vertical: 5),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Group:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 60, right: 20),
                            child: DropdownButton(
                              isExpanded: true,
                              underline: Text(""),
                              hint: Text("Select Group"),
                              value: group,
                              items:
                                  groupList.map<DropdownMenuItem<String>>((e) {
                                return DropdownMenuItem<String>(
                                  child: Text(e),
                                  value: e,
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  group = value.toString();
                                  print(group);
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              Card(
                // elevation: 7,
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .10,
                    vertical: 5),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Blood Groop:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            child: DropdownButton(
                              isExpanded: true,
                              underline: Text(""),
                              hint: Text("Select Blood Group"),
                              value: bloodGroup,
                              items: bloodGroupList.map((e) {
                                return DropdownMenuItem(
                                  value: e.toString(),
                                  child: Text(e),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  bloodGroup = value.toString();
                                  print(bloodGroup);
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              Card(
                // elevation: 7,
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .10,
                    vertical: 5),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Religion:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 45, right: 20),
                            child: DropdownButton(
                              isExpanded: true,
                              underline: Text(""),
                              hint: Text("Select Religion"),
                              value: religion,
                              items: religionList
                                  .map<DropdownMenuItem<String>>((e) {
                                return DropdownMenuItem<String>(
                                  child: Text(e),
                                  value: e,
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  religion = value.toString();
                                  print(religion);
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.1,
                    vertical: 5),
                child: error != ""
                    ? Text(
                        error,
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                        textAlign: TextAlign.left,
                      )
                    : Text(""),
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
                    uploadPersonalInfo();
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
                height: 30,
              ),
              //ElevatedButton(onPressed: (){}, child: Text("Submit")),
            ],
          ),
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        chooseImageFromGalary();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      chooseImageFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> chooseImageFromGalary() async {
    XFile? choosedimage = await picker.pickImage(source: ImageSource.gallery);
    //set source: ImageSource.camera to get image from camera
    setState(() {
      uploadimage = choosedimage!;
    });
  }

  Future<void> chooseImageFromCamera() async {
    XFile? choosedimage = await picker.pickImage(source: ImageSource.camera);
    //set source: ImageSource.camera to get image from camera
    setState(() {
      uploadimage = choosedimage!;
    });
  }
}

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_portal_app/HomePage/Admin_Portal/Student_card/Student_Admission/GuardianDetail/gaurdianDetail.dart';

class OfficialStudentInfo extends StatefulWidget {
  OfficialStudentInfo({Key? key}) : super(key: key);

  @override
  _OfficialStudentInfoState createState() => _OfficialStudentInfoState();
}

class _OfficialStudentInfoState extends State<OfficialStudentInfo> {
  XFile? birthCertificate;
  XFile? previousMarksheet;
  XFile? transferCertificate;
  XFile? collectImage;
  List transportList = ["A+", "B+", "O-", "O+", "Other"];
  List gameList = ["A+", "B+", "O-", "O+", "Other"];
  List classList = ["A+", "B+", "O-", "O+", "Other"];
  List sectionList = ["A+", "B+", "O-", "O+", "Other"];
  String? transport;
  String? gameName;
  String? className;
  String? section;
  String error = "";
  bool isLoading = false;
  ImagePicker picker = new ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFBCEBEB),
      appBar: AppBar(
        backgroundColor: Color(0xFF097272),
        title: Text("Official Information"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.1, vertical: 40),
        width: MediaQuery.of(context).size.width * 0.8,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: Icon(
                            Icons.photo_album,
                            color: Colors.black,
                            size: 24,
                          )),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: birthCertificate == null
                            ? Text("Upload Birth Certificate")
                            : Text(birthCertificate!.path),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: IconButton(
                          icon: Icon(Icons.upload),
                          onPressed: () {
                            _showDocumentPicker(context);
                            setState(() {
                              birthCertificate = collectImage;
                              collectImage = null;
                            });
                          },
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
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: Icon(
                            Icons.photo_album,
                            color: Colors.black,
                            size: 24,
                          )),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: previousMarksheet == null
                            ? Text("Upload Previous Marksheet")
                            : Text(previousMarksheet!.path),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: IconButton(
                          icon: Icon(Icons.upload),
                          onPressed: () {
                            _showDocumentPicker(context);
                            previousMarksheet = collectImage;
                            setState(() {
                              collectImage = null;
                            });
                          },
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
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: Icon(
                            Icons.photo_album,
                            color: Colors.black,
                            size: 24,
                          )),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: transferCertificate == null
                              ? Text("Upload Transfer Certificate")
                              : Text(transferCertificate!.path)),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: IconButton(
                          icon: Icon(Icons.upload),
                          onPressed: () {
                            _showDocumentPicker(context);
                            setState(() {
                              transferCertificate = collectImage;
                              collectImage = null;
                            });
                          },
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
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Transport:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 45, right: 20),
                          child: DropdownButton(
                            isExpanded: true,
                            underline: Text(""),
                            hint: Text("Select Transport"),
                            value: transport,
                            items: transportList
                                .map<DropdownMenuItem<String>>((e) {
                              return DropdownMenuItem<String>(
                                child: Text(e),
                                value: e,
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                transport = value.toString();
                                print(transport);
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
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Game:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 45, right: 20),
                          child: DropdownButton(
                            isExpanded: true,
                            underline: Text(""),
                            hint: Text("Select Game Name"),
                            value: gameName,
                            items: gameList.map<DropdownMenuItem<String>>((e) {
                              return DropdownMenuItem<String>(
                                child: Text(e),
                                value: e,
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                gameName = value.toString();
                                print(gameName);
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
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Class:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 45, right: 20),
                          child: DropdownButton(
                            isExpanded: true,
                            underline: Text(""),
                            hint: Text("Select Your Class"),
                            value: className,
                            items: classList.map<DropdownMenuItem<String>>((e) {
                              return DropdownMenuItem<String>(
                                child: Text(e),
                                value: e,
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                className = value.toString();
                                print(className);
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
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Section:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 45, right: 20),
                          child: DropdownButton(
                            isExpanded: true,
                            underline: Text(""),
                            hint: Text("Select Section"),
                            value: section,
                            items:
                                sectionList.map<DropdownMenuItem<String>>((e) {
                              return DropdownMenuItem<String>(
                                child: Text(e),
                                value: e,
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                section = value.toString();
                                print(section);
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
                height: 5,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 5,
                ),
                width: MediaQuery.of(context).size.width * 0.9,
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
                            builder: (context) => GaurdianDetail()));
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

  void _showDocumentPicker(context) {
    //XFile fileData = context;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      title: new Text('Gallery'),
                      leading: new Icon(Icons.photo_library),
                      onTap: () {
                        chooseDocumentFromGalary();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    title: new Text('Camera'),
                    leading: new Icon(Icons.photo_camera),
                    onTap: () {
                      chooseDocumentFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  // void _uploadMarksheetPicker(context) {
  //   //XFile fileData = context;
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext bc) {
  //         return SafeArea(
  //           child: Container(
  //             child: new Wrap(
  //               children: <Widget>[
  //                 new ListTile(
  //                     title: new Text('Gallery'),
  //                     leading: new Icon(Icons.photo_library),
  //                     onTap: () {
  //                       chooseDocumentFromGalary(birthCertificate);
  //                       Navigator.of(context).pop();
  //                     }),
  //                 new ListTile(
  //                   title: new Text('Camera'),
  //                   leading: new Icon(Icons.photo_camera),
  //                   onTap: () {
  //                     chooseDocumentFromCamera(birthCertificate);
  //                     Navigator.of(context).pop();
  //                   },
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }

  // void _uploadTransferCertificatePicker(context) {
  //   //XFile fileData = context;
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext bc) {
  //         return SafeArea(
  //           child: Container(
  //             child: new Wrap(
  //               children: <Widget>[
  //                 new ListTile(
  //                     title: new Text('Gallery'),
  //                     leading: new Icon(Icons.photo_library),
  //                     onTap: () {
  //                       chooseDocumentFromGalary(birthCertificate);
  //                       Navigator.of(context).pop();
  //                     }),
  //                 new ListTile(
  //                   title: new Text('Camera'),
  //                   leading: new Icon(Icons.photo_camera),
  //                   onTap: () {
  //                     chooseDocumentFromCamera(birthCertificate);
  //                     Navigator.of(context).pop();
  //                   },
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }

  Future<void> chooseDocumentFromCamera() async {
    XFile? choosedimage = await picker.pickImage(source: ImageSource.camera);
    //set source: ImageSource.camera to get image from camera
    setState(() {
      collectImage = choosedimage!;
    });
  }

  Future<void> chooseDocumentFromGalary() async {
    XFile? choosedimage = await picker.pickImage(source: ImageSource.gallery);
    //set source: ImageSource.camera to get image from camera
    setState(() {
      collectImage = choosedimage!;
    });
  }
}

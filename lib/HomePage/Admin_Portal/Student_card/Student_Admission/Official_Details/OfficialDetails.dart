import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class OfficialDetailsPage extends StatefulWidget {
  OfficialDetailsPage({Key? key}) : super(key: key);

  @override
  _OfficialDetailsPageState createState() => _OfficialDetailsPageState();
}

class _OfficialDetailsPageState extends State<OfficialDetailsPage> {
  XFile? uploadimage;
  ImagePicker picker = new ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFBCEBEB),
      appBar: AppBar(
        backgroundColor: Color(0xFF097272),
        title: Text(
          "Official Details",
          style: TextStyle(
            color: Color(0xFFFFFFFF),
          ),
        ),
      ),
      body: Container(
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
                              : null),
                    ),
                  ),
                  Positioned(
                      top: 100,
                      left: 120,
                      child: RawMaterialButton(
                        fillColor: Color(0xFF097272),
                        onPressed: () {
                          _showDocumentPicker(context);
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
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 30,
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
                              : null),
                    ),
                  ),
                  Positioned(
                    top: 130,
                    left: 120,
                    child: RawMaterialButton(
                      fillColor: Color(0xFF097272),
                      onPressed: () {
                        _showDocumentPicker(context);
                      },
                      child: Icon(
                        Icons.add_a_photo,
                        color: Color(0xFFFFFFFF),
                      ),
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(10.0),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 30,
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
                              : null),
                    ),
                  ),
                  Positioned(
                    top: 130,
                    left: 120,
                    child: RawMaterialButton(
                      fillColor: Color(0xFF097272),
                      onPressed: () {
                        _showDocumentPicker(context);
                      },
                      child: Icon(
                        Icons.add_a_photo,
                        color: Color(0xFFFFFFFF),
                      ),
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(10.0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }

  void _showDocumentPicker(context) {
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
                        chooseBirthCertificateFromGalary();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    title: new Text('Camera'),
                    leading: new Icon(Icons.photo_camera),
                    onTap: () {
                      chooseBirthCertificateFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  // void _showPreviousMarksheetPicker(context) {
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
  //                       chooseBirthCertificateFromGalary();
  //                       Navigator.of(context).pop();
  //                     }),
  //                 new ListTile(
  //                   title: new Text('Camera'),
  //                   leading: new Icon(Icons.photo_camera),
  //                   onTap: () {
  //                     chooseBirthCertificateFromCamera();
  //                     Navigator.of(context).pop();
  //                   },
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }

  // void _showTransferCertificatePicker(context) {
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
  //                       chooseBirthCertificateFromGalary();
  //                       Navigator.of(context).pop();
  //                     }),
  //                 new ListTile(
  //                   title: new Text('Camera'),
  //                   leading: new Icon(Icons.photo_camera),
  //                   onTap: () {
  //                     chooseBirthCertificateFromCamera();
  //                     Navigator.of(context).pop();
  //                   },
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }

  Future<void> chooseBirthCertificateFromGalary() async {
    XFile? choosedimage = await picker.pickImage(source: ImageSource.gallery);
    //set source: ImageSource.camera to get image from camera
    setState(() {
      uploadimage = choosedimage!;
    });
  }

  Future<void> chooseBirthCertificateFromCamera() async {
    XFile? choosedimage = await picker.pickImage(source: ImageSource.camera);
    //set source: ImageSource.camera to get image from camera
    setState(() {
      uploadimage = choosedimage!;
    });
  }

  Future<void> choosePreviousMarksheetFromGalary() async {
    XFile? choosedimage = await picker.pickImage(source: ImageSource.gallery);
    //set source: ImageSource.camera to get image from camera
    setState(() {
      uploadimage = choosedimage!;
    });
  }

  Future<void> choosePreviousMarksheetFromCamera() async {
    XFile? choosedimage = await picker.pickImage(source: ImageSource.camera);
    //set source: ImageSource.camera to get image from camera
    setState(() {
      uploadimage = choosedimage!;
    });
  }

  Future<void> chooseTransferCertificateFromGalary() async {
    XFile? choosedimage = await picker.pickImage(source: ImageSource.gallery);
    //set source: ImageSource.camera to get image from camera
    setState(() {
      uploadimage = choosedimage!;
    });
  }

  Future<void> chooseTransferCertificateFromCamera() async {
    XFile? choosedimage = await picker.pickImage(source: ImageSource.camera);
    //set source: ImageSource.camera to get image from camera
    setState(() {
      uploadimage = choosedimage!;
    });
  }
}

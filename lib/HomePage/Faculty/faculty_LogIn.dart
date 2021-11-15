
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_portal_app/HomePage/Faculty/faculty_dashboard/facultyDashboard.dart';
import 'package:student_portal_app/component/alertdilog.dart';
class FacultyLogIn extends StatefulWidget {
  FacultyLogIn({Key? key}) : super(key: key);
  @override
  _FacultyLogInState createState() => _FacultyLogInState();
}
class _FacultyLogInState extends State<FacultyLogIn> {
  void initState(){
    super.initState();
    initPlatformState();
  }
  String ?token;
  String deviceName="";
  String deviceVersion="";
  String deviceIdentifier="";
  String deviceOs="";
  String deviceToken = "";
  bool isloading = false;
  String error = "";
  var obj;
  late SharedPreferences Facultylogindata;
  late bool loginstatus;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future loginForm() async {
    if (_usernameController.text.isEmpty && _passwordController.text.isEmpty) {
      setState(() {
        error = "Please Filled All Empty Fields";
      });
    }
    else {
      setState(() {
        error = "";
        isloading = true;
      });
      // Store all data with Param Name.
      print("Username:" + _usernameController.text);
      print("password:" + _passwordController.text);
      var data = {
        "username": _usernameController.text,
        "password": _passwordController.text,
        "device_name": deviceName,
        "device_ver": deviceVersion,
        "device_id": deviceIdentifier,
        "device_os": deviceOs,
        "device_token":token
      };
      // Starting App API Call.
      var response = await http.post(
          Uri.parse(
              "http://sniic.co.in/admin/school_app/login/faculty_login_verification.php"),
          body: json.encode(data)).catchError((e){
            showMyDialog("Error", e.toString(), context);
      });
      // Getting Server response into variable.
      setState(() {
        obj = jsonDecode(response.body);
      });
      if (obj['result'] == "S") {
        setState(() {
          isloading = false;
        });
        String id = obj['id'];
        Facultylogindata = await SharedPreferences.getInstance();
        await Facultylogindata.setString("fregNo", id);
        await Facultylogindata.setBool('flogin', true);
        await Facultylogindata.setString("fname", obj["name"]);
        await Facultylogindata.setString("femptype", obj["emptype"]);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => FacultyDashboard())
        ).then((value) => Navigator.pop(context));
      } else {
        setState(() {
          isloading = false;
          error =
          "Username or password are invalid";
        });
      }
    }
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFBCEBEB),
      body: Container(
        width: MediaQuery.of(context).size.width * 1,
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 1,
                height: 180,
                child: Image.asset("assets/images/top.jpg",fit: BoxFit.fill,),
              ),
              Card(
                color: Color(0xFFFDFAFF),
                elevation: 0.0,
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(20.0)),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.98,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 150,
                        child: Image.asset("assets/images/collage_logo.png"),
                      ),
                      // CircleAvatar(
                      //   backgroundImage:
                      //   AssetImage("assets/images/collage_logo.png"),
                      //   radius: 80,
                      //   backgroundColor: Colors.white,
                      // ),
                      SizedBox(
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 30,
                          ),
                          child: Text(
                            "Welcome To SNIIC",
                            style: TextStyle(
                                color: Color(0xFF5A5858),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextFormField(
                          controller: _usernameController,
                          //maxLength: 10,
                          //keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.person,
                              color: Colors.blueGrey[200],
                              size: 24,
                            ),
                            hintText: "Enter Username",
                            labelText: "Username",
                            labelStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextFormField(
                          controller: _passwordController,
                          //maxLength: 10,
                          obscureText: true,
                          //keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.lock,
                              color: Colors.blueGrey[200],
                              size: 24,
                            ),
                            hintText: "Enter Password",
                            labelText: "Password",
                            labelStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: error != ""
                              ? Text(
                            error,
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                            textAlign: TextAlign.left,
                          )
                              : Text("")),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Material(
                          //elevation: 10,
                          color: Color(0xFF097272),
                          borderRadius: BorderRadius.circular(15),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                            child: ButtonTheme(
                              minWidth: double.infinity,
                              child: MaterialButton(
                                onPressed: () {
                                  loginForm();
                                  // Navigator.of(context).push(
                                  //   MaterialPageRoute(
                                  //     builder: (context) => FacultyDashboard(),
                                  //   ),
                                  // );
                                },
                                child: (isloading == true
                                    ? Text(
                                  "Loading .....",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                                    : Text(
                                  "Continue",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> initPlatformState() async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
     token=preferences.getString("MobileToken");
    // showMyDialog("Token", token.toString(), context);
    // print("+++++++++++++++++++++++++");
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        // getAxisDirectionFromAxisReverseAndDirectionality(await deviceInfoPlugin.androidInfo);
        getAndroidDeviceInfo(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        getIOSDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      // deviceData = <String, dynamic>{
      // 'Error:': 'Failed to get platform version.'
    };

  }

  void getAndroidDeviceInfo(AndroidDeviceInfo build)
  {
    print("Android");
    deviceOs="Android";
    deviceName = build.model.toString();
    deviceVersion = build.version.release.toString();
    deviceIdentifier = build.androidId.toString();

    print("Device Name:"+deviceName);
    print("Device Version:"+deviceVersion);
    print("Device ID:"+deviceIdentifier);
  }

  void getIOSDeviceInfo(IosDeviceInfo data)
  {
    print("IOS");
    deviceOs="IOS";
    deviceName = data.name.toString();
    deviceVersion = data.systemVersion.toString();
    deviceIdentifier = data.identifierForVendor.toString();
    print("Device Name:"+deviceName);
    print("Device Version:"+deviceVersion);
    print("Device ID:"+deviceIdentifier);
  }
}

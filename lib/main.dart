import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:student_portal_app/Splashpage/SplashPage.dart';
import 'package:student_portal_app/component/alertdilog.dart';

import 'HomePage/Admin_Portal/Student_card/Student_Admission/Personal_info/personal_info.dart';
import 'HomePage/Admin_Portal/Student_card/Student_search_card/studentAlldetail/student_detail.dart';
const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.max,
    playSound: true);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // print('A bg message just showed up :  ${message.messageId}');
}
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GetTokenPage(),
    );
  }
}
class GetTokenPage extends StatefulWidget {
  const GetTokenPage({Key? key}) : super(key: key);
  @override
  _GetTokenPageState createState() => _GetTokenPageState();
}
class _GetTokenPageState extends State<GetTokenPage> {
  void showNotification() {

    flutterLocalNotificationsPlugin.show(
        0,
        "Testing ",
        "How you doin ?",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name, channel.description,
                importance: Importance.high,
                color: Colors.amber,
                playSound: true,
                sound: RawResourceAndroidNotificationSound('iphone_sms'),
                icon: '@mipmap/ic_launcher')));
  }
  @override
  void initState() {
    super.initState();
    firebaseCloudMessagingListeners();
    //this call when app is open or foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
                  sound: RawResourceAndroidNotificationSound('iphone_sms.mp3'),
              ),
            ));
      }
    });
    // called when app is closed and user tab on notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        if(notification.title=="Attendance")
          Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPersonalInfo()));
          // showMyDialog("Attendance", "Attendance marked sccefully", context);
        // showDialog(
        //     context: context,
        //     builder: (_) {
        //       return AlertDialog(
        //         title: Text(notification.title!),
        //         content: SingleChildScrollView(
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [Text(notification.body!)],
        //           ),
        //         ),
        //       );
        //     });
      }
    });
  }
  String token1 = "";
  Future<void> firebaseCloudMessagingListeners() async {
    String? token = await FirebaseMessaging.instance.getToken();
    //token1 = token!;
    print("Token1:" +token!);
  }
  @override
  Widget build(BuildContext context) {
    return SplashPage();
  }
}
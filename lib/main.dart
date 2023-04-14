import 'dart:async';
import 'package:rider_app/cupertimer.dart';
import 'package:time_range_picker/time_range_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rider_app/AllScreens/loginScreen.dart';
import 'package:rider_app/AllScreens/mainscreen.dart';
import 'package:rider_app/AllScreens/registerationScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import 'package:rider_app/AllScreens/loginScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rider_app/AllScreens/mainscreen.dart';
import 'package:rider_app/main.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rider_app/timer.dart';
import 'Diya_timer.dart';
import 'SlotBooking.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
DatabaseReference userRef = FirebaseDatabase.instance.reference().child("users");
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parked',

      theme: ThemeData(
        fontFamily: "Brand Bold",
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: LoginScreen.idScreen,
      routes: {
        RScreen.idScreen:(context)=>RScreen(),
        LoginScreen.idScreen:(context)=>LoginScreen(),
        MainScreen.idScreen:(context)=>MainScreen(),
        TimerScreen.idScreen:(Context)=>TimerScreen(),
        MyHomePage.idScreen:(Context)=>MyHomePage(title: 'MyHomePage',),
        TimerScreenS.idScreen:(Context)=>TimerScreenS(),
        MyButtons.idScreen:(Context)=>MyButtons()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}



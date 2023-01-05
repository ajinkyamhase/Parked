import 'dart:core';
import 'package:time_range_picker/time_range_picker.dart';
import 'package:flutter/cupertino.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
import "package:flutter/material.dart";
// import 'package:rider_app/AllScreens/loginScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
//  import 'package:rider_app/AllScreens/mainscreen.dart';
// import 'package:rider_app/Allwidgets/progressDialog.dart';
// import 'package:rider_app/main.dart';
import 'main.dart';
import 'variables.dart';
import 'count2.dart';

class TimerScreenS extends StatefulWidget {
  static const String idScreen = "register";

  @override
  State<TimerScreenS> createState() => TimerScreenState();
}

class TimerScreenState extends State<TimerScreenS> {

  // late int timeDiff;
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime =
  TimeOfDay.fromDateTime(DateTime.now().add(const Duration(hours: 3)));
  bool On=false;

  // ignore: deprecated_member_use
  //final dbR = FirebaseDatabase.instance.reference();

  TextEditingController nameTextEditingController = TextEditingController();

  TextEditingController emailTextEditingController = TextEditingController();

  TextEditingController phoneTextEditingController = TextEditingController();

  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Divider(),
              // Text(
              //   'As a regular widget:',
              //   style: Theme.of(context).textTheme.headline6,
              //   textAlign: TextAlign.center,
              // ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Start: ${startTime.format(context)}"),
                  Text("End: ${endTime.format(context)}"),
                ],
              ),
              SizedBox(
                height: 400,
                child: TimeRangePicker(
                  hideButtons: true,
                  hideTimes: true,
                  paintingStyle: PaintingStyle.fill,
                  backgroundColor: Colors.grey.withOpacity(0.2),
                  labels: [
                    ClockLabel.fromTime(
                        time: const TimeOfDay(hour: 7, minute: 0),
                        text: "Start Work"),
                    ClockLabel.fromTime(
                        time: const TimeOfDay(hour: 18, minute: 0), text: "Go Home")
                  ],
                  start: startTime,
                  end: endTime,
                  ticks: 8,
                  strokeColor: Theme.of(context).primaryColor.withOpacity(0.5),
                  ticksColor: Theme.of(context).primaryColor,
                  labelOffset: 15,
                  padding: 60,
                  onStartChange: (start) {
                    setState(() {
                      startTime = start;
                    });
                  },
                  onEndChange: (end) {
                    setState(() {
                      endTime = end;
                    });
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // Container(
                    //   child: Text('$_startTime'),
                    // ),
                    // Container(
                    //   child: Text('$_endTime'),
                    // ),
                    SizedBox(height: 30.0,),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.yellowAccent),

                          shape: MaterialStatePropertyAll
                            (
                            RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(24.0),
                            ),
                          )
                      ),
                      child: Container(
                        height: 40.0,
                        child: Center(
                          child: Text(
                            "Create Account",
                            style: TextStyle(
                                fontSize: 18.0, fontFamily: "Brand Bold"),
                          ),
                        ),
                      ),
                      onPressed: () {
                        print("login button clicked");
                      },
                    )
                  ],
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  bool result;
                  TimeOfDay currentTime= TimeOfDay.now();
                  int currentTimeInt = (currentTime.hour * 60 + currentTime.minute) * 60;
                  int startTimeInt = (startTime.hour * 60 + startTime.minute) * 60;
                  int endTimeInt = (endTime.hour * 60 + endTime.minute) * 60;
                  timeDiff = (endTimeInt - startTimeInt);
                  print(timeDiff);

                  Navigator.push(context, MaterialPageRoute(builder: (context) => const CountdownTimerDemo()),);
                }, child: Text("Confirm"),
              ),



            ],
          ),
        ),
      ),
    );
  }

// final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

// void registerNewUser(BuildContext context) async
// {
//   showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context)
//       {
//         return ProgressDialog(message: "Registering,Please Wait....",);
//       }
//   );

// final User? firebaseUser = (await _firebaseAuth.createUserWithEmailAndPassword(
//     email: emailTextEditingController.text,
//     password: passwordTextEditingController.text).catchError((errMsg) {
//   Navigator.pop(context);
//   displayToastMessage("error:" + errMsg.toString(), context);
// })).user;
// if (firebaseUser != null) {
//
//   //save user info to database
//
//   Map userDataMap = {
//     "name": nameTextEditingController.text.trim(),
//     "email": emailTextEditingController.text.trim(),
//     "phone": phoneTextEditingController.text.trim(),
//   };
//   userRef.child(firebaseUser.uid).set(userDataMap);
//   displayToastMessage("account created successfully", context);
//   Navigator.pushNamedAndRemoveUntil(
//       context, MainScreen.idScreen, (route) => false);
// }
// else {
//   Navigator.pop(context);
//   displayToastMessage("acc not created", context);
// }
// final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
// void registerNewUser(BuildContext context) async
// {
//   final F
// }
}

displayToastMessage(String message,BuildContext context)
{
  Fluttertoast.showToast(msg: message);
}

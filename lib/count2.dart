import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rider_app/variables.dart';
import 'AllScreens/loginScreen.dart';
import 'Diya_timer.dart';

class CountdownTimerDemo extends StatefulWidget {
  const CountdownTimerDemo({super.key});

  @override
  _CountdownTimerDemoState createState() => _CountdownTimerDemoState();
}

class _CountdownTimerDemoState extends State<CountdownTimerDemo> {
  bool On=false;
  bool x= false;
  Timer? countdownTimer;
  Duration myDuration = Duration(seconds: timeDiff);
  final dbR = FirebaseDatabase.instance.reference();
  @override
  void initState() {
    //startState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      TimeOfDay currentTime = TimeOfDay.now();
      nowTimeInt = (currentTime.hour * 60 + currentTime.minute) * 60;
      print("Loop");
      if (nowTimeInt >= startTimeInt) {
        finaltimeDiff = endTimeInt - nowTimeInt ;
        startTimer();
        print("started timer");
        timer.cancel();
      }
    });


    super.initState();
  }
  void startState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      TimeOfDay currentTime= TimeOfDay.now();
      nowTimeInt = (currentTime.hour * 60 + currentTime.minute) * 60;
      if(nowTimeInt>=startTimeInt){
        startTimer();
      }
      if(nowTimeInt<=startTimeInt){
        finaltimeDiff = endTimeInt - nowTimeInt;
      }
    });
  }
  void startTimer() {
    x= true;
    print("x set true");
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }
  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTimer(),
              const SizedBox(height: 80),
              buildButtons(),
            ],
          ),
        ),

      );


  Widget buildButtons() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      // ElevatedButton(
      //   onPressed: startTimer,
      //   child: Text(
      //     'Start',
      //     style: TextStyle(
      //       fontSize: 30,
      //     ),
      //   ),
      // ),
      SizedBox(width: 10,),
      ElevatedButton(
        onPressed: () {
          bool result;
          TimeOfDay currentTime= TimeOfDay.now();
          int currentTimeInt = (currentTime.hour * 60 + currentTime.minute) * 60;
          //print(startTimeInt);
          //print(endTimeInt);
          print(finaltimeDiff);
          if(currentTimeInt>=startTimeInt){
            if(currentTimeInt<=endTimeInt){
              dbR.child("Light").set({"Switch":!On});
              setState((){
                On= !On;
              });
            }
          }
          else{
            dbR.child("P4").set({"Slot4":!On});
            setState((){
              On= !On;
            });
            Navigator.pushNamedAndRemoveUntil(
                context, LoginScreen.idScreen, (route) => false);
          }
        },
        child: Text(
          'On/Off',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
      SizedBox(width: 10,),
      ElevatedButton(
        onPressed: () {
          Navigator.pop(context, MaterialPageRoute(builder: (context) => TimerScreenS()),);
        },
        child: Text(
          'Extend',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
      SizedBox(width: 10,),
    ],
  );
  Widget buildTimer() =>
      SizedBox(
          width: 250,
          height: 250,
          child: Stack(
            fit: StackFit.expand,
            children: [
              const CircularProgressIndicator(
                value: 5,
                valueColor: AlwaysStoppedAnimation(Colors.grey),
                strokeWidth: 12,
                backgroundColor: Colors.greenAccent,
              ),
              Center(child: buildTime()),
            ],
          )
      );
  Widget buildTime() {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final hours = strDigits(myDuration.inHours.remainder(24));
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));


    return Text(
      '$hours:$minutes:$seconds',
      style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 50),
    );
  }
}
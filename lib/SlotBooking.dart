import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rider_app/Diya_timer.dart';
import 'main.dart';
class MyButtons extends StatefulWidget {
  static const String idScreen ="Booking";
  @override
  _MyButtonsState createState() => _MyButtonsState();
}

class _MyButtonsState extends State<MyButtons> {
  bool On=false;

  // ignore: deprecated_member_use
  final dbR = FirebaseDatabase.instance.reference();

  int selectedButtonIndex = -1; // initialize with -1, which means no button is selected

  void _onButtonPressed(int index) {
    setState(() {
      selectedButtonIndex = index;
    });
  }

  void _onSubmitPressed() {
    if (selectedButtonIndex != -1) {
      print('Selected button index: $selectedButtonIndex');
    } else {
      print('No button is selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Slot'),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  width: 100,
                  height: 200,
                  child: ElevatedButton(
                    onPressed: (){
                      _onButtonPressed(0);
                    },
                    child: Text('Slot 1'),
                    style: selectedButtonIndex == 0
                        ? ElevatedButton.styleFrom(backgroundColor: Colors.green)
                        : ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  ),
                ),
                SizedBox(
                  width: 100,
                  height: 200,
                  child: ElevatedButton(
                    onPressed: (){
                      _onButtonPressed(1);
                    },
                    child: Text('Slot 2'),
                    style: selectedButtonIndex == 1
                        ? ElevatedButton.styleFrom(backgroundColor: Colors.green)
                        : ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  ),
                ),
                SizedBox(
                  width: 100,
                  height: 200,
                  child: ElevatedButton(
                    onPressed: (){
                      _onButtonPressed(2);
                    },
                    child: Text('Slot 3'),
                    style: selectedButtonIndex == 2
                        ? ElevatedButton.styleFrom(backgroundColor: Colors.green)
                        : ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  ),
                ),
              ],
            ),
            SizedBox(
              width:100 ,
              height:50 ,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  width: 100,
                  height: 200,
                  child: ElevatedButton(
                    onPressed: (){
                      _onButtonPressed(3);
                      print(selectedButtonIndex);
                    },
                    child: Text('Slot 4'),
                    style: selectedButtonIndex == 3
                        ? ElevatedButton.styleFrom(backgroundColor: Colors.green)
                        : ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  ),
                ),
                SizedBox(
                  width: 100,
                  height: 200,
                  child: ElevatedButton(
                    onPressed: (){
                      _onButtonPressed(4);
                    },
                    child: Text('Slot 5'),
                    style: selectedButtonIndex == 4
                        ? ElevatedButton.styleFrom(backgroundColor: Colors.green)
                        : ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  ),
                ),
                SizedBox(
                  width: 100,
                  height: 200,
                  child: ElevatedButton(
                    onPressed: (){
                      _onButtonPressed(5);
                    },
                    child: Text('Slot 6'),
                    style: selectedButtonIndex == 5
                        ? ElevatedButton.styleFrom(backgroundColor: Colors.green)
                        : ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            SizedBox(
              width: 150,
              height: 70,
              child: ElevatedButton(
                onPressed: (){
                  if (selectedButtonIndex == -1) {
                    print('Please select a slot');
                  }
                  if (selectedButtonIndex == 3) {
                    dbR.child("P4").set({"Slot4":!On});
                    setState((){
                      On= !On;
                    });
                    print('Please select a slot');
                    Navigator.pushNamedAndRemoveUntil(
                        context, TimerScreenS.idScreen, (route) => false);
                  }
                  else {
                    print('Please select a slot');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                ),
                child: Text('Confirm Slot'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
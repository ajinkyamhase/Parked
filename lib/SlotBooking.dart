import 'package:flutter/material.dart';
import 'main.dart';
import 'Diya_timer.dart';
class MyButtons extends StatefulWidget {
  @override
  _MyButtonsState createState() => _MyButtonsState();
}

class _MyButtonsState extends State<MyButtons> {
  static const String idScreen ="Booking";
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
                    onPressed: () => _onButtonPressed(0),
                    child: Text('Slot 1'),
                    style: selectedButtonIndex == 0
                        ? ElevatedButton.styleFrom(primary: Colors.green)
                        : ElevatedButton.styleFrom(primary: Colors.grey),
                  ),
                ),
                SizedBox(
                  width: 100,
                  height: 200,
                  child: ElevatedButton(
                    onPressed: () => _onButtonPressed(1),
                    child: Text('Slot 2'),
                    style: selectedButtonIndex == 1
                        ? ElevatedButton.styleFrom(primary: Colors.green)
                        : ElevatedButton.styleFrom(primary: Colors.grey),
                  ),
                ),
                SizedBox(
                  width: 100,
                  height: 200,
                  child: ElevatedButton(
                    onPressed: () => _onButtonPressed(2),
                    child: Text('Slot 3'),
                    style: selectedButtonIndex == 2
                        ? ElevatedButton.styleFrom(primary: Colors.green)
                        : ElevatedButton.styleFrom(primary: Colors.grey),
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
                    onPressed: () => _onButtonPressed(3),
                    child: Text('Slot 4'),
                    style: selectedButtonIndex == 3
                        ? ElevatedButton.styleFrom(primary: Colors.green)
                        : ElevatedButton.styleFrom(primary: Colors.grey),
                  ),
                ),
                SizedBox(
                  width: 100,
                  height: 200,
                  child: ElevatedButton(
                    onPressed: () => _onButtonPressed(4),
                    child: Text('Slot 5'),
                    style: selectedButtonIndex == 4
                        ? ElevatedButton.styleFrom(primary: Colors.green)
                        : ElevatedButton.styleFrom(primary: Colors.grey),
                  ),
                ),
                SizedBox(
                  width: 100,
                  height: 200,
                  child: ElevatedButton(
                    onPressed: () => _onButtonPressed(5),
                    child: Text('Slot 6'),
                    style: selectedButtonIndex == 5
                        ? ElevatedButton.styleFrom(primary: Colors.green)
                        : ElevatedButton.styleFrom(primary: Colors.grey),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            SizedBox(
              width: 150,
              height: 70,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TimerScreenS()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary:Colors.indigo,
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
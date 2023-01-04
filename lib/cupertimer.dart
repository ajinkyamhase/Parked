import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:rider_app/variables.dart';
import 'round-button.dart';
import 'timer.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  static const String idScreen = "MyHomePage";

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  late TimeOfDay time;
  int difference=timeDiff;
  late TimeOfDay picked;
  DateTime dt1 = DateTime.parse("2021-12-23 11:47:00");
  DateTime dt2 = DateTime.parse("2021-12-23 11:47:00");
  var _intervals = ['1', '2', '3', '4', '5', '6', '7'];
  var _currentItemSelected = '1';
  late AnimationController controller;

  bool isPlaying = false;

  String get countText {
    Duration count = controller.duration! * controller.value;
    return controller.isDismissed
        ? '${controller.duration!.inHours}:${(controller.duration!.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.duration!.inSeconds % 60).toString().padLeft(2, '0')}'
        : '${count.inHours}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  double progress = 1.0;

  void notify() {
    if (countText == '0:00:01') {
      FlutterRingtonePlayer.playNotification();
    }
    //if(dt1.compareTo(dt2) == 0){
    //FlutterRingtonePlayer.playNotification();
    //}
  }

  @override
  void initState() {
    super.initState();
    time = TimeOfDay.now();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3600),
    );

    controller.addListener(() {
      notify();
      if (controller.isAnimating) {
        setState(() {
          progress = controller.value;
        });
      } else {
        setState(() {
          progress = 1.0;
          isPlaying = false;
        });
      }
    });
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }



  get child => null;

  // @override
  // void initState() {
  //   super.initState();
  //   time = TimeOfDay.now();
  // }

  Future<void> selectTime (BuildContext context) async {
    picked = (await showTimePicker(
        context: context,
        initialTime: time
    ))!;

    // ignore: unnecessary_null_comparison
    if(picked != null) {
      setState(() {
        time = picked;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
            children: <Widget>[
              IconButton(
                  icon: const Icon(Icons.access_time),
                  iconSize: 40,
                  onPressed: () {
                    selectTime(context);
                    if (kDebugMode) {
                      print(time);
                    }
                  }
              ),
              const Text('Start Time', style: TextStyle(fontSize: 20)),
              Text('Time ${time.hour}:${time.minute}', style: const TextStyle(fontSize: 25)),
              DropdownButton<String> (
                items: _intervals.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(),
                onChanged: (newValueSelected) {
                  _onDropDownItemSelected(newValueSelected!);
                },
                value: _currentItemSelected,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    height: 300,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.grey.shade300,
                      value: progress,
                      strokeWidth: 6,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (controller.isDismissed) { //Time picker roundmiddle
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                            height: 300,
                            child: CupertinoTimerPicker(
                              initialTimerDuration: controller.duration!,
                              onTimerDurationChanged: (time) {
                                setState(() {
                                  controller.duration = time;
                                });
                              },
                            ),
                          ),
                        );
                      }
                    },
                    child: AnimatedBuilder(
                      animation: controller,
                      builder: (context, child) => Text(
                        countText,
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      GestureDetector(
                        onTap: () {
                          if (controller.isAnimating) {
                            controller.stop();
                            setState(() {
                              isPlaying = false;
                            });
                          } else {
                            controller.reverse(
                                from: controller.value == 0 ? 1.0 : controller.value);
                            setState(() {
                              isPlaying = true;
                            });
                          }
                        },
                        child: RoundButton(
                          icon: isPlaying == true ? Icons.pause : Icons.play_arrow,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.reset();
                          setState(() {
                            isPlaying = false;
                          });
                        },
                        child: RoundButton(
                          icon: Icons.stop,
                        ),
                      ),
                    ]
                ),
              ),
            ]
        ),

      ),
    );
  }
  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected!;
    });
  }
}


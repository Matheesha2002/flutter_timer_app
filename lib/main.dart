import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  static const duration = Duration(seconds: 1);

  int secondsPassed = 0;
  bool isActive = false;
  late Timer timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(duration, (Timer t) {
      handleTick();
    });
  }

  void handleTick() {
    if (isActive) {
      setState(() {
        secondsPassed = secondsPassed + 1;
      });
    }
  }

  void resetTimer() {
    setState(() {
      secondsPassed = 0;
      isActive = false;
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int seconds = secondsPassed % 60;
    int minutes = secondsPassed ~/ 60;
    int hours = secondsPassed ~/ (60 * 60);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Timer App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Timer App'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomTextContainer(
                    label: 'Hours',
                    value: hours.toString().padLeft(2, '0'),
                  ),
                  CustomTextContainer(
                    label: 'Minutes',
                    value: minutes.toString().padLeft(2, '0'),
                  ),
                  CustomTextContainer(
                    label: 'Seconds',
                    value: seconds.toString().padLeft(2, '0'),
                  ),
                ],
              ),

              SizedBox(height: 20),

              ElevatedButton(
                child: Text(isActive ? 'STOP' : 'START'),
                onPressed: () {
                  setState(() {
                    isActive = !isActive;
                  });
                },
              ),

              SizedBox(height: 10),

              ElevatedButton(
                child: Text('RESET'),
                onPressed: resetTimer,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextContainer extends StatelessWidget {
  final String label;
  final String value;

  CustomTextContainer({
    this.label = 'XX',
    this.value = 'XX',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
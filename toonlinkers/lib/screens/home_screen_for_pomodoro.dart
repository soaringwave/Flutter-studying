import 'package:flutter/material.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMin = 1500;
  int totalTime = twentyFiveMin;
  bool isRunnig = false;
  int totalPomodoros = 0;
  late Timer timer;

  void onTiktok(Timer timer) {
    if (totalTime == 0) {
      setState(() {
        isRunnig = false;
        timer.cancel();
        totalTime = twentyFiveMin;
        totalPomodoros = totalPomodoros + 1;
      });
    } else {
      setState(() {
        totalTime = totalTime - 1;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTiktok,
    );
    setState(() {
      isRunnig = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunnig = false;
    });
  }

  void onResetPressed() {
    timer.cancel();
    setState(() {
      isRunnig = false;
      totalTime = twentyFiveMin;
    });
  }

  String timeFormat(int sec) {
    String result = Duration(seconds: sec).toString().substring(2, 7);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Flexible(
            flex: 3,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                timeFormat(totalTime),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              alignment: Alignment.center,
              child: isRunnig
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            iconSize: 70,
                            onPressed: onPausePressed,
                            icon: Icon(
                              Icons.pause_circle_filled_rounded,
                              color: Theme.of(context).cardColor,
                            )),
                        IconButton(
                          iconSize: 70,
                          onPressed: onResetPressed,
                          icon: Icon(Icons.replay_circle_filled_rounded,
                              color: Theme.of(context).cardColor),
                        ),
                      ],
                    )
                  : IconButton(
                      iconSize: 70,
                      onPressed: onStartPressed,
                      icon: Icon(
                        Icons.play_circle_fill_rounded,
                        color: Theme.of(context).cardColor,
                      ),
                    ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Theme.of(context).cardColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pomodors',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '$totalPomodoros',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                            fontSize: 50,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

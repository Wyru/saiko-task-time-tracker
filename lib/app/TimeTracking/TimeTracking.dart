import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:maidttt/model/Task.dart';

class TimeTracking extends StatefulWidget {
  const TimeTracking({super.key});

  @override
  State<TimeTracking> createState() => _TimeTrackingState();
}

class _TimeTrackingState extends State<TimeTracking> {
  Task? task;
  late Timer oneSecondTimer;

  String durationText = '00:00:00';

  @override
  void initState() {
    oneSecondTimer = scheduleTimeout();
    super.initState();
  }

  Timer scheduleTimeout([int seconds = 1]) =>
      Timer.periodic(Duration(seconds: seconds), onAfterOneSecond);

  void onAfterOneSecond(Timer timer) {
    int secondsUntilNow = DateTime.now().difference(task!.start).inSeconds;

    int hours = (secondsUntilNow ~/ (60 * 60));
    int min = (secondsUntilNow % (60 * 60)) ~/ 60;
    int seconds = (secondsUntilNow % (60 * 60)) % 60;

    setState(() {
      durationText =
          '${hours.toString().padLeft(2, '0')}:${min.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    });
  }

  @override
  Widget build(BuildContext context) {
    task = ModalRoute.of(context)!.settings.arguments as Task;

    return Scaffold(
      appBar: AppBar(title: const Text('Hora de focar, Goshujin-sama! (≧∇≦)ﾉ')),
      body: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                durationText,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 75),
              ),
            )
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  task?.description ?? 'Não informado!',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Ink(
                decoration: const ShapeDecoration(
                  color: Colors.blue,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  iconSize: 48,
                  color: Colors.white,
                  onPressed: () {},
                  icon: const Icon(Icons.stop),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

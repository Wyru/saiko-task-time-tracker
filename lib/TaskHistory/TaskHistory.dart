import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskHistoryRoute extends StatefulWidget {
  const TaskHistoryRoute({super.key});

  @override
  State<TaskHistoryRoute> createState() => _TaskHistoryRouteState();
}

class _TaskHistoryRouteState extends State<TaskHistoryRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorias'),
      ),
      body: Container(),
    );
  }
}

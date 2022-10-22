import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saikottt/Categories/Categories.dart';
import 'package:saikottt/Home/home.dart';
import 'package:saikottt/TaskHistory/TaskHistory.dart';

void main() {
  runApp(MaterialApp(initialRoute: '/', routes: {
    '/': (context) => const SaikoTTT(),
    '/categories': (context) => const CategoriesRoute(),
    '/taskHistory': (context) => const TaskHistoryRoute(),
  }));
}

class SaikoTTT extends StatelessWidget {
  const SaikoTTT({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(child: Screen());
  }
}

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Home();
  }
}

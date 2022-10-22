import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saikottt/Home/home.dart';

void main() {
  runApp(const MaterialApp(home: SaikoTTT()));
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

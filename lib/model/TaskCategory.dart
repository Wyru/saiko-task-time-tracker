import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskCategory {
  static int lastIndex = 0;

  int id = 0;
  String name;
  Color color;
  IconData icon;

  TaskCategory(this.name, this.color, this.icon) {
    id = lastIndex + 1;
    lastIndex++;
  }

  Color getTextColor() =>
      color.computeLuminance() > 0.6 ? Colors.black87 : Colors.white;
}

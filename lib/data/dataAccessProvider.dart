import 'package:flutter/material.dart';
import 'package:maindttt/model/Task.dart';
import 'package:maindttt/model/TaskCategory.dart';

class DataAccessProvider {
  static final DataAccessProvider instance = DataAccessProvider._();

  List<TaskCategory> categories = [
    TaskCategory("Trabalho", Colors.redAccent, Icons.work),
    TaskCategory("Faculdade", Colors.blueAccent, Icons.book),
    TaskCategory("Estudos", Colors.greenAccent, Icons.bookmark),
    TaskCategory("Leitura", Colors.purpleAccent, Icons.bookmark_add_outlined),
  ];

  List<Task> tasks = [];

  DataAccessProvider._();
}

import 'package:flutter/material.dart';
import 'package:maidttt/app/TimeTracking/TimeTracking.dart';
import 'package:maidttt/data/dataAccessProvider.dart';
import 'package:provider/provider.dart';
import 'package:maidttt/app/Categories/Categories.dart';
import 'package:maidttt/app/Home/Home.dart';
import 'package:maidttt/app/TaskHistory/TaskHistory.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => DataAccessProvider.instance)
    ],
    child: MaterialApp(initialRoute: '/', routes: {
      '/': (context) => const maidTTT(),
      '/categories': (context) => const CategoriesRoute(),
      '/timeTracking': (context) => const TimeTracking(),
      '/taskHistory': (context) => const TaskHistoryRoute(),
    }),
  ));
}

class maidTTT extends StatelessWidget {
  const maidTTT({super.key});

  @override
  Widget build(BuildContext context) {
    return Home();
  }
}

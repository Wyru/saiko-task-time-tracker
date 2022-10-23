import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:maidttt/app/Categories/Categories.dart';
import 'package:maidttt/app/Home/Home.dart';
import 'package:maidttt/app/TaskHistory/TaskHistory.dart';
import 'package:maidttt/data/DataAccessProvider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [
      Provider<DataAccessProvider>(create: (_) => DataAccessProvider.instance)
    ],
    child: MaterialApp(initialRoute: '/', routes: {
      '/': (context) => const maidTTT(),
      '/categories': (context) => const CategoriesRoute(),
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

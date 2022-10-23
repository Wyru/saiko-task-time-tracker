import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:maindttt/app/Categories/Categories.dart';
import 'package:maindttt/app/Home/Home.dart';
import 'package:maindttt/app/TaskHistory/TaskHistory.dart';
import 'package:maindttt/data/DataAccessProvider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [
      Provider<DataAccessProvider>(create: (_) => DataAccessProvider.instance)
    ],
    child: MaterialApp(initialRoute: '/', routes: {
      '/': (context) => const maindTTT(),
      '/categories': (context) => const CategoriesRoute(),
      '/taskHistory': (context) => const TaskHistoryRoute(),
    }),
  ));
}

class maindTTT extends StatelessWidget {
  const maindTTT({super.key});

  @override
  Widget build(BuildContext context) {
    return Home();
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:maidttt/app/TimeTracking/TimeTracking.dart';
import 'package:maidttt/data/dataAccessProvider.dart';
import 'package:provider/provider.dart';
import 'package:maidttt/app/Categories/Categories.dart';
import 'package:maidttt/app/Home/Home.dart';
import 'package:maidttt/app/TaskHistory/TaskHistory.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Window.initialize();

  if (defaultTargetPlatform == TargetPlatform.windows) {
    await Window.showWindowControls();
  }

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => DataAccessProvider.instance)
    ],
    child: MaterialApp(
        theme: ThemeData(
          splashFactory: InkRipple.splashFactory,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const maidTTT(),
          '/categories': (context) => const CategoriesRoute(),
          '/timeTracking': (context) => const TimeTracking(),
          '/taskHistory': (context) => const TaskHistoryRoute(),
        }),
  ));

  if (defaultTargetPlatform == TargetPlatform.windows) {
    doWhenWindowReady(() {
      appWindow
        ..minSize = const Size(640, 360)
        ..maxSize = const Size(640, 360)
        ..size = const Size(640, 360)
        ..alignment = Alignment.center
        ..show();
    });
  }
}

class maidTTT extends StatelessWidget {
  const maidTTT({super.key});

  @override
  Widget build(BuildContext context) {
    return Home();
  }
}

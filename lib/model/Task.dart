import 'package:maidttt/data/dataAccessProvider.dart';
import 'package:provider/provider.dart';

class Task {
  String description;
  int categoryId;

  late final DateTime start;
  DateTime? end;

  Task(this.description, this.categoryId) {
    start = DateTime.now();
  }

  void EndTask() {
    end = DateTime.now();
  }

  bool isRunning() => (end == null);

  int getDurationInHours() {
    if (end == null) {
      return 0;
    }

    return end!.difference(start).inHours;
  }
}

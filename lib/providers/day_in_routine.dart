import 'package:organizer_app/providers/task.dart';

class DayInRoutine {
  final String weekDay;
  final List<Task> tasks;

  DayInRoutine({required this.weekDay, required this.tasks});
}
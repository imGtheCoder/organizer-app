import 'package:flutter/material.dart';
import 'package:organizer_app/providers/task.dart';
import '../providers/day_in_routine.dart';

class Routine with ChangeNotifier {
  final String id;
  bool active;
  final String title;
  final String description;
  final List<DayInRoutine> days;

  Routine({
    this.active = false,
    required this.description,
    required this.id,
    required this.title,
    required this.days,
  });
}

import 'package:flutter/material.dart';

class Goal with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final Duration todayTimeSpent;
  final Duration totalTimeSpent;
  bool currentlyWorkingOnIt;
  final DateTime addedAt;
  DateTime startedAt;
  DateTime stoppedAt;
  final DateTime finishDate;
  bool expanded;

  Goal(
      {required this.todayTimeSpent,
      required this.stoppedAt,
      required this.addedAt,
      this.currentlyWorkingOnIt = false,
      required this.totalTimeSpent,
      required this.startedAt,
      required this.id,
      required this.title,
      required this.description,
      required this.finishDate,
      required this.expanded});
}

import 'package:flutter/material.dart';

class Goal with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final Duration totalTimeSpent;
  final DateTime finishDate;
  bool expanded;

  Goal(
      {required this.totalTimeSpent,
      required this.id,
      required this.title,
      required this.description,
      required this.finishDate,
      required this.expanded});
}

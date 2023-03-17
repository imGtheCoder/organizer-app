import 'package:flutter/material.dart';

class Task with ChangeNotifier{
  final String id;
  final String title;
  final Duration duration;
  bool completed;

  Task({required this.id, required this.title, required this.duration, this.completed = false});
}
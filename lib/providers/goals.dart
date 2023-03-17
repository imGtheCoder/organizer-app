import 'package:flutter/material.dart';
import 'package:organizer_app/providers/goal.dart';

class Goals with ChangeNotifier {
  List<Goal> get goals {
    return [..._goals];
  }

  final List<Goal> _goals = [
    Goal(
        totalTimeSpent: Duration(minutes: 100),
        description: 'very cool thing ',
        title: 'Learn Flutter programming',
        id: '1',
        finishDate: DateTime.now(),
        expanded: false),
    Goal(
        totalTimeSpent: Duration(minutes: 100),
        description: 'very cool thing ',
        title: 'Learn app development',
        id: '2',
        finishDate: DateTime.now(),
        expanded: false),
    Goal(
        totalTimeSpent: Duration(minutes: 100),
        description: 'very cool thing ',
        title: 'Learn to do a backflip',
        id: '3',
        finishDate: DateTime.now(),
        expanded: false),
    Goal(
        totalTimeSpent: Duration(minutes: 100),
        description: 'very cool thing ' * 10,
        title: 'Learn some trick on skate',
        id: '4',
        finishDate: DateTime.now(),
        expanded: false),
    Goal(
        totalTimeSpent: Duration(minutes: 100),
        description: 'very cool thing ' * 10,
        title: 'Learn to wash tha dishez',
        id: '5',
        finishDate: DateTime.now(),
        expanded: false),
  ];
}

import 'package:flutter/material.dart';
import 'package:organizer_app/providers/goal.dart';

class Goals with ChangeNotifier {
  List<Goal> get goals {
    return [..._goals];
  }

  void toggleWorking(String goalId) {
    final currentGoal = _goals.firstWhere((element) => element.id == goalId);
    currentGoal.currentlyWorkingOnIt = !currentGoal.currentlyWorkingOnIt;
  }

  void addToTotalTimeSpent(String goalId, Duration duration) {
    final index = _goals.indexWhere((element) => element.id == goalId);
    print('${duration.inSeconds} from goals');
    _goals[index] = Goal(
        addedAt: _goals[index].addedAt,
        totalTimeSpent: _goals[index].totalTimeSpent + duration,
        startedAt: _goals[index].startedAt,
        id: _goals[index].id,
        title: _goals[index].title,
        description: _goals[index].description,
        finishDate: _goals[index].finishDate,
        expanded: _goals[index].expanded);
    print('${_goals[index].totalTimeSpent.inSeconds} from goals time spent');
    ;
  }

  final List<Goal> _goals = [
    Goal(
        addedAt: DateTime.now(),
        totalTimeSpent: Duration.zero,
        startedAt: DateTime.now(),
        description: 'very cool thing ',
        title: 'Learn Flutter programming',
        id: '1',
        finishDate: DateTime.now(),
        expanded: false),
    Goal(
        addedAt: DateTime.now(),
        totalTimeSpent: Duration.zero,
        startedAt: DateTime.now(),
        description: 'very cool thing ',
        title: 'Learn app development',
        id: '2',
        finishDate: DateTime.now(),
        expanded: false),
    Goal(
        addedAt: DateTime.now(),
        totalTimeSpent: Duration.zero,
        startedAt: DateTime.now(),
        description: 'very cool thing ',
        title: 'Learn to do a backflip',
        id: '3',
        finishDate: DateTime.now(),
        expanded: false),
    Goal(
        addedAt: DateTime.now(),
        totalTimeSpent: Duration.zero,
        startedAt: DateTime.now(),
        description: 'very cool thing ' * 10,
        title: 'Learn some trick on skate',
        id: '4',
        finishDate: DateTime.now(),
        expanded: false),
    Goal(
        addedAt: DateTime.now(),
        totalTimeSpent: Duration.zero,
        startedAt: DateTime.now(),
        description: 'very cool thing ' * 10,
        title: 'Learn to wash tha dishez',
        id: '5',
        finishDate: DateTime.now(),
        expanded: false),
  ];
}

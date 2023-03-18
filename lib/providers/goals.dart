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

  DateTime todayAt00() {
    return DateTime.utc(
        DateTime.now().year, DateTime.now().month, DateTime.now().day);
  }

  void addToTodayTimeSpent(String goalId) {
    final index = _goals.indexWhere((element) => element.id == goalId);
    final todayAt0 = todayAt00();
    // final todayAt00 = DateTime.utc(
    //     DateTime.now().year, DateTime.now().month, DateTime.now().day);
    //print('${duration.inSeconds} from goals');
    if (_goals[index].stoppedAt.isBefore(todayAt0)) {
      _goals[index] = Goal(
          stoppedAt: DateTime.now(),
          addedAt: _goals[index].addedAt,
          totalTimeSpent:
              _goals[index].totalTimeSpent + _goals[index].todayTimeSpent,
          todayTimeSpent: Duration.zero +
              DateTime.now().difference(_goals[index].startedAt),
          startedAt: _goals[index].startedAt,
          id: _goals[index].id,
          title: _goals[index].title,
          description: _goals[index].description,
          finishDate: _goals[index].finishDate,
          expanded: _goals[index].expanded);
      notifyListeners();
    } else {
      _goals[index] = Goal(
          stoppedAt: _goals[index].stoppedAt,
          addedAt: _goals[index].addedAt,
          totalTimeSpent: _goals[index].totalTimeSpent,
          todayTimeSpent: _goals[index].todayTimeSpent +
              DateTime.now().difference(_goals[index].startedAt),
          startedAt: _goals[index].startedAt,
          id: _goals[index].id,
          title: _goals[index].title,
          description: _goals[index].description,
          finishDate: _goals[index].finishDate,
          expanded: _goals[index].expanded);
    }

    //print('${_goals[index].totalTimeSpent.inSeconds} from goals time spent');
  }

  Duration getTodayTimeSpent(String goalId, DateTime currentDate) {
    final currentGoal = _goals.firstWhere((element) => element.id == goalId);
    final totalTimeSpent = currentGoal.totalTimeSpent;
    //DateTime.now().year
    //if(toda)
    final todayAt0 = DateTime.utc(
        DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final durationToday =
        totalTimeSpent - todayAt0.difference(currentGoal.startedAt);
    return durationToday;
  }

  void addNewGoal(
      String title, String description, DateTime targetDate, DateTime addedAt) {
    _goals.add(Goal(
        stoppedAt: DateTime(2000),
        addedAt: addedAt,
        totalTimeSpent: Duration.zero,
        todayTimeSpent: Duration.zero,
        startedAt: DateTime(2000),
        id: DateTime.now().toString(),
        title: title,
        description: description,
        finishDate: targetDate,
        expanded: false));
    notifyListeners();
  }

  void editGoal(String goalId, String title, String description,
      ) {
    final index = _goals.indexWhere((element) => element.id == goalId);
    _goals[index] =Goal(
        stoppedAt: _goals[index].stoppedAt,
        addedAt: _goals[index].addedAt,
        totalTimeSpent: _goals[index].todayTimeSpent,
        todayTimeSpent: _goals[index].todayTimeSpent,
        startedAt: _goals[index].startedAt,
        id: _goals[index].id,
        title: title,
        description: description,
        finishDate: _goals[index].finishDate,
        expanded: _goals[index].expanded);
    notifyListeners();
  }

  void deleteGoal(String id){
    final index = _goals.indexWhere((element) => element.id == id);
    _goals.removeAt(index);
    notifyListeners();
  }

  Goal emptyGoal = Goal(
      stoppedAt: DateTime(2000),
      addedAt: DateTime(2000),
      totalTimeSpent: Duration.zero,
      todayTimeSpent: Duration.zero,
      startedAt: DateTime(2000),
      id: '',
      title: '',
      description: '',
      finishDate: DateTime(2000),
      expanded: false);

  final List<Goal> noGoals = [];

  final List<Goal> _goals = [
    Goal(
        addedAt: DateTime.now(),
        totalTimeSpent: Duration.zero,
        todayTimeSpent: Duration.zero,
        startedAt: DateTime.now(),
        stoppedAt: DateTime.now(),
        description: 'very cool thing ',
        title: 'Learn Flutter programming',
        id: '1',
        finishDate: DateTime.now(),
        expanded: false),
    Goal(
        addedAt: DateTime.now(),
        totalTimeSpent: Duration.zero,
        todayTimeSpent: Duration.zero,
        startedAt: DateTime.now(),
        stoppedAt: DateTime.now(),
        description: 'very cool thing ',
        title: 'Learn app development',
        id: '2',
        finishDate: DateTime.now(),
        expanded: false),
    Goal(
        addedAt: DateTime.now(),
        totalTimeSpent: Duration.zero,
        todayTimeSpent: Duration.zero,
        startedAt: DateTime.now(),
        stoppedAt: DateTime.now(),
        description: 'very cool thing ',
        title: 'Learn to do a backflip',
        id: '3',
        finishDate: DateTime.now(),
        expanded: false),
    Goal(
        addedAt: DateTime.now(),
        totalTimeSpent: Duration.zero,
        todayTimeSpent: Duration.zero,
        startedAt: DateTime.now(),
        stoppedAt: DateTime.now(),
        description: 'very cool thing ' * 10,
        title: 'Learn some trick on skate',
        id: '4',
        finishDate: DateTime.now(),
        expanded: false),
    Goal(
        addedAt: DateTime.now(),
        totalTimeSpent: Duration.zero,
        todayTimeSpent: Duration.zero,
        startedAt: DateTime.now(),
        stoppedAt: DateTime.now(),
        description: 'very cool thing ' * 10,
        title: 'Learn to wash tha dishez',
        id: '5',
        finishDate: DateTime.now(),
        expanded: false),
  ];
}

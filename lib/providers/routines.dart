// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:organizer_app/providers/routine.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/day_in_routine.dart';
import '../providers/task.dart';

class Routines with ChangeNotifier {
  // List<Task> _tasks = [
  //   Task(duration: Duration(hours: 1), title: 'Do homework', id: '0'),
  //   Task(
  //       id: '1',
  //       title: 'Clean my room',
  //       duration: Duration(hours: 2, minutes: 30)),
  //   Task(id: '2', title: 'Learn at math', duration: Duration(minutes: 20)),
  //   Task(id: '3', title: 'Go shopping', duration: Duration(hours: 3)),
  //   Task(id: '4', title: 'Bake a cake', duration: Duration(minutes: 30)),
  // ];

  // List<Task> tasks(String day, int i) {
  //   return [..._routines[i]];
  // }
  int itemsLeft(List<Task> tasks) {
    int itmLft = tasks.length;
    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i].completed) {
        itmLft--;
      }
    }
    return itmLft;
  }

  Duration averageDuration(List<Task> tasks) {
    if(tasks.isNotEmpty){
      return Duration(
        seconds: (totalDuration(tasks).inSeconds / tasks.length).floor());
    }else {
      return Duration.zero;
    }
    
  }

  Duration _maxAvgDuration(List<DayInRoutine> alldays) {
    Duration maxDur = Duration.zero;
    for (int i = 0; i < alldays.length; i++) {
      if (averageDuration(alldays[i].tasks) > maxDur) {
        maxDur = averageDuration(alldays[i].tasks);
      }
    }
    return maxDur;
  }

  Duration averageDurationOverTheWeek(List<DayInRoutine> alldays) {
    Duration allDur = Duration.zero;
    int count = 0;
    for (int i = 0; i < alldays.length; i++) {
      if (averageDuration(alldays[i].tasks).inSeconds >
          0.7 * _maxAvgDuration(alldays).inSeconds) {
        allDur = allDur + totalDuration(alldays[i].tasks);
        count++;
      }
    }
    return Duration(seconds: (allDur.inSeconds / count).floor());
  }

  Duration totalDuration(List<Task> tasks) {
    Duration totalDur = Duration.zero;
    if(tasks.isNotEmpty) {
      for (int i = 0; i < tasks.length; i++) {
      totalDur = totalDur + tasks[i].duration;
    }
    return totalDur;
    } else {
      return Duration.zero;
    }   
    
  }

  Duration remainingDuration(List<Task> tasks) {
    Duration totalDur = Duration.zero;
    for (int i = 0; i < tasks.length; i++) {
      if (!tasks[i].completed) totalDur = totalDur + tasks[i].duration;
    }
    return totalDur;
  }

  String donePercent(List<Task> tasks) {
    return ((1 -
                (remainingDuration(tasks).inSeconds /
                    totalDuration(tasks).inSeconds)) *
            100)
        .toStringAsFixed(1);
  }

  List<Task> remainingItems(List<Task> tasks) {
    List<Task> remaining = [];
    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i].completed) {
        remaining.add(tasks[i]);
      }
    }
    return remaining;
  }

  String printDuration(Duration duration) {
    String twoDigits(int n) => n.toString(); //.padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    //String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (twoDigitMinutes == '0') {
      return "${twoDigits(duration.inHours)}h";
    } else if (twoDigits(duration.inHours) == '0') {
      return "${twoDigitMinutes}m";
    }
    return "${twoDigits(duration.inHours)}h ${twoDigitMinutes}m";
  }

  List<Routine> get routines {
    return [..._routines];
  }

  List<Task> get activeTasks {
    return [..._activeTasks];
  }

  List<Routine> getActiveRoutines() {
    List<Routine> eligible = [];
    for (int i = 0; i < _routines.length; i++) {
      if (_routines[i].active) {
        eligible.add(_routines[i]);
      }
    }
    return eligible;
  }

  List<Task> getTodaysTasks(DateTime currentDate) {
    List<Routine> activeRoutines = [];
    _activeTasks.clear();
    for(int i = 0; i< _routines.length; i++){
      if (_routines[i].active == true) {
        activeRoutines.add(_routines[i]);
      }
    } 
    //getActiveRoutines(routines);
    for (int i = 0; i < activeRoutines.length; i++) {
      final task = activeRoutines[i]
          .days
          .firstWhere((element) =>
              element.weekDay == DateFormat('EEEE').format(currentDate))
          .tasks;
      for (int j = 0; j < task.length; j++) {
        _activeTasks.add(task[j]);
      }
    }
    //notifyListeners();
    return _activeTasks;
  }

  void updateInfo(){
    notifyListeners();
  }

  void addNewRoutine(String id, String title,String description, List<DayInRoutine> days){
    _routines.add(Routine(id: id, title: title, days: days, description: description));
    notifyListeners();
  }

  void editRoutine(String id, String title,String description, List<DayInRoutine> days, bool active){
    final index = _routines.indexWhere((element) => element.id ==id); 
    _routines[index]=Routine(id: _routines[index].id, title: title, days: days, description: description, active: active);
    notifyListeners();
  }

  void deleteSingleTask(String routineId, String weekday, String taskId){
    final currentWeekdayTasks = _routines.firstWhere((element) => element.id == routineId).days.firstWhere((element) => element.weekDay == weekday).tasks;
    final index = currentWeekdayTasks.indexWhere((element) => element.id ==taskId);
    _routines.firstWhere((element) => element.id == routineId).days.firstWhere((element) => element.weekDay == weekday).tasks.removeAt(index);
  }

  void toggleActive(String routineId){
    final currentRoutine = _routines.firstWhere((element) => element.id == routineId);
    currentRoutine.active = !currentRoutine.active;
    notifyListeners();
  }

  final emptyRoutine = Routine(description: '', id: DateTime.now().toString(), title: '', days: [
    DayInRoutine(weekDay: 'Monday', tasks: []),
    DayInRoutine(weekDay: 'Tuesday', tasks: []),
    DayInRoutine(weekDay: 'Wednesday', tasks: []),
    DayInRoutine(weekDay: 'Thursday', tasks: []),
    DayInRoutine(weekDay: 'Friday', tasks: []),
    DayInRoutine(weekDay: 'Saturday', tasks: []),
    DayInRoutine(weekDay: 'Sunday', tasks: []),
  ]);

  final List<Task> _activeTasks = [];

  final List<Routine> _routines = [
    Routine(
      id: '0',
      active: true,
      title: 'Routine 1',
      description: 'This is the routine I will use for school',
      days: [
        DayInRoutine(
          weekDay: 'Monday',
          tasks: [
            Task(duration: Duration(hours: 1), title: 'Do homework', id: '0'),
            Task(
                id: '1',
                title: 'Clean my room',
                duration: Duration(hours: 2, minutes: 30)),
            Task(
                id: '2',
                title: 'Learn at math',
                duration: Duration(minutes: 20)),
            Task(
                id: '3',
                title: 'Go shopping',
                duration: Duration(hours: 2, minutes: 35)),
            Task(
                id: '4', title: 'Bake a cake', duration: Duration(minutes: 30)),
          ],
        ),
        DayInRoutine(
          weekDay: 'Tuesday',
          tasks: [
            Task(
                duration: Duration(hours: 1),
                title: 'Do homework yeeee',
                id: '0'),
            Task(
                id: '1',
                title: 'Clean my room blabblabla',
                duration: Duration(hours: 2, minutes: 30)),
            Task(
                id: '2',
                title: 'Learn at math yeeeeee',
                duration: Duration(minutes: 20)),
            Task(
                id: '3',
                title: 'Go shoppingyeeee',
                duration: Duration(hours: 3)),
            Task(
                id: '4',
                title: 'Bake a cake yeeee',
                duration: Duration(minutes: 30)),
          ],
        ),
        DayInRoutine(
          weekDay: 'Wednesday',
          tasks: [
            Task(duration: Duration(hours: 1), title: 'Do homework', id: '0'),
            Task(
                id: '1',
                title: 'Clean my room',
                duration: Duration(hours: 2, minutes: 30)),
            Task(
                id: '2',
                title: 'Learn at math',
                duration: Duration(minutes: 20)),
            Task(id: '3', title: 'Go shopping', duration: Duration(hours: 3)),
            Task(
                id: '4', title: 'Bake a cake', duration: Duration(minutes: 30)),
          ],
        ),
        DayInRoutine(
          weekDay: 'Thursday',
          tasks: [
            Task(duration: Duration(hours: 1), title: 'Do homework', id: '0'),
            Task(
                id: '1',
                title: 'Clean my room',
                duration: Duration(hours: 2, minutes: 30)),
            Task(
                id: '2',
                title: 'Learn at math',
                duration: Duration(minutes: 20)),
            Task(id: '3', title: 'Go shopping', duration: Duration(hours: 3)),
            Task(
                id: '4', title: 'Bake a cake', duration: Duration(minutes: 30)),
          ],
        ),
        DayInRoutine(
          weekDay: 'Friday',
          tasks: [
            Task(duration: Duration(hours: 1), title: 'Do homework', id: '0'),
            Task(
                id: '1',
                title: 'Clean my room',
                duration: Duration(hours: 2, minutes: 30)),
            Task(
                id: '2',
                title: 'Learn at math',
                duration: Duration(minutes: 20)),
            Task(id: '3', title: 'Go shopping', duration: Duration(hours: 3)),
            Task(
                id: '4', title: 'Bake a cake', duration: Duration(minutes: 30)),
          ],
        ),
        DayInRoutine(
          weekDay: 'Saturday',
          tasks: [
            Task(duration: Duration(hours: 1), title: 'Do homework', id: '0'),
            Task(
                id: '1',
                title: 'Clean my room',
                duration: Duration(hours: 2, minutes: 30)),
            Task(
                id: '2',
                title: 'Learn at math',
                duration: Duration(minutes: 20)),
            Task(id: '3', title: 'Go shopping', duration: Duration(hours: 3)),
            Task(
                id: '4', title: 'Bake a cake', duration: Duration(minutes: 30)),
          ],
        ),
        DayInRoutine(
          weekDay: 'Sunday',
          tasks: [
            Task(duration: Duration(hours: 1), title: 'Do homework', id: '0'),
            Task(
                id: '1',
                title: 'Clean my room',
                duration: Duration(hours: 2, minutes: 30)),
            Task(
                id: '2',
                title: 'Learn at math',
                duration: Duration(minutes: 20)),
            Task(id: '3', title: 'Go shopping', duration: Duration(hours: 3)),
            Task(
                id: '4', title: 'Bake a cake', duration: Duration(minutes: 30)),
          ],
        )
      ],
    ),
    Routine(
      id: '1',
      title: 'Routine 2',
      description: 'I will use this for part time hobbies.',
      days: [
        DayInRoutine(
          weekDay: 'Monday',
          tasks: [
            Task(duration: Duration(hours: 1), title: 'Do homework', id: '0'),
            Task(
                id: '1',
                title: 'Clean my room',
                duration: Duration(hours: 2, minutes: 30)),
            Task(
                id: '2',
                title: 'Learn at math',
                duration: Duration(minutes: 20)),
            Task(id: '3', title: 'Go shopping', duration: Duration(hours: 3)),
            Task(
                id: '4', title: 'Bake a cake', duration: Duration(minutes: 30)),
          ],
        ),
        DayInRoutine(
          weekDay: 'Tuesday',
          tasks: [
            Task(duration: Duration(hours: 1), title: 'Do homework', id: '0'),
            Task(
                id: '1',
                title: 'Clean my room',
                duration: Duration(hours: 2, minutes: 30)),
            Task(
                id: '2',
                title: 'Learn at math',
                duration: Duration(minutes: 20)),
            Task(id: '3', title: 'Go shopping', duration: Duration(hours: 3)),
            Task(
                id: '4', title: 'Bake a cake', duration: Duration(minutes: 30)),
          ],
        ),
        DayInRoutine(
          weekDay: 'Wednesday',
          tasks: [
            Task(duration: Duration(hours: 1), title: 'Do homework', id: '0'),
            Task(
                id: '1',
                title: 'Clean my room',
                duration: Duration(hours: 2, minutes: 30)),
            Task(
                id: '2',
                title: 'Learn at math',
                duration: Duration(minutes: 20)),
            Task(id: '3', title: 'Go shopping', duration: Duration(hours: 3)),
            Task(
                id: '4', title: 'Bake a cake', duration: Duration(minutes: 30)),
          ],
        ),
        DayInRoutine(
          weekDay: 'Thursday',
          tasks: [
            Task(duration: Duration(hours: 1), title: 'Do homework', id: '0'),
            Task(
                id: '1',
                title: 'Clean my room',
                duration: Duration(hours: 2, minutes: 30)),
            Task(
                id: '2',
                title: 'Learn at math',
                duration: Duration(minutes: 20)),
            Task(id: '3', title: 'Go shopping', duration: Duration(hours: 3)),
            Task(
                id: '4', title: 'Bake a cake', duration: Duration(minutes: 30)),
          ],
        ),
        DayInRoutine(
          weekDay: 'Friday',
          tasks: [
            Task(duration: Duration(hours: 1), title: 'Do homework', id: '0'),
            Task(
                id: '1',
                title: 'Clean my room',
                duration: Duration(hours: 2, minutes: 30)),
            Task(
                id: '2',
                title: 'Learn at math',
                duration: Duration(minutes: 20)),
            Task(id: '3', title: 'Go shopping', duration: Duration(hours: 3)),
            Task(
                id: '4', title: 'Bake a cake', duration: Duration(minutes: 30)),
          ],
        ),
        DayInRoutine(
          weekDay: 'Saturday',
          tasks: [
            Task(duration: Duration(hours: 1), title: 'Do homework', id: '0'),
            Task(
                id: '1',
                title: 'Clean my room',
                duration: Duration(hours: 2, minutes: 30)),
            Task(
                id: '2',
                title: 'Learn at math',
                duration: Duration(minutes: 20)),
            Task(id: '3', title: 'Go shopping', duration: Duration(hours: 3)),
            Task(
                id: '4', title: 'Bake a cake', duration: Duration(minutes: 30)),
          ],
        ),
        DayInRoutine(
          weekDay: 'Sunday',
          tasks: [
            Task(duration: Duration(hours: 1), title: 'Do homework', id: '0'),
            Task(
                id: '1',
                title: 'Clean my room',
                duration: Duration(hours: 2, minutes: 30)),
            Task(
                id: '2',
                title: 'Learn at math',
                duration: Duration(minutes: 20)),
            Task(id: '3', title: 'Go shopping', duration: Duration(hours: 3)),
            Task(
                id: '4', title: 'Bake a cake', duration: Duration(minutes: 30)),
          ],
        )
      ],
    ),
    Routine(
      id: '2',
      title: 'Routine 3',
      description: 'This is for holiday.',
      days: [
        DayInRoutine(
          weekDay: 'Monday',
          tasks: [
            Task(duration: Duration(hours: 1), title: 'Do homework', id: '0'),
            Task(
                id: '1',
                title: 'Clean my room',
                duration: Duration(hours: 2, minutes: 30)),
            Task(
                id: '2',
                title: 'Learn at math',
                duration: Duration(minutes: 20)),
            Task(id: '3', title: 'Go shopping', duration: Duration(hours: 3)),
            Task(
                id: '4', title: 'Bake a cake', duration: Duration(minutes: 30)),
          ],
        ),
        DayInRoutine(
          weekDay: 'Tuesday',
          tasks: [
            Task(duration: Duration(hours: 1), title: 'Do homework', id: '0'),
            Task(
                id: '1',
                title: 'Clean my room',
                duration: Duration(hours: 2, minutes: 30)),
            Task(
                id: '2',
                title: 'Learn at math',
                duration: Duration(minutes: 20)),
            Task(id: '3', title: 'Go shopping', duration: Duration(hours: 3)),
            Task(
                id: '4', title: 'Bake a cake', duration: Duration(minutes: 30)),
          ],
        ),
        DayInRoutine(
          weekDay: 'Wednesday',
          tasks: [
            Task(duration: Duration(hours: 1), title: 'Do homework', id: '0'),
            Task(
                id: '1',
                title: 'Clean my room',
                duration: Duration(hours: 2, minutes: 30)),
            Task(
                id: '2',
                title: 'Learn at math',
                duration: Duration(minutes: 20)),
            Task(id: '3', title: 'Go shopping', duration: Duration(hours: 3)),
            Task(
                id: '4', title: 'Bake a cake', duration: Duration(minutes: 30)),
          ],
        ),
        DayInRoutine(
          weekDay: 'Thursday',
          tasks: [
            Task(duration: Duration(hours: 1), title: 'Do homework', id: '0'),
            Task(
                id: '1',
                title: 'Clean my room',
                duration: Duration(hours: 2, minutes: 30)),
            Task(
                id: '2',
                title: 'Learn at math',
                duration: Duration(minutes: 20)),
            Task(id: '3', title: 'Go shopping', duration: Duration(hours: 3)),
            Task(
                id: '4', title: 'Bake a cake', duration: Duration(minutes: 30)),
          ],
        ),
        DayInRoutine(
          weekDay: 'Friday',
          tasks: [
            Task(duration: Duration(hours: 1), title: 'Do homework', id: '0'),
            Task(
                id: '1',
                title: 'Clean my room',
                duration: Duration(hours: 2, minutes: 30)),
            Task(
                id: '2',
                title: 'Learn at math',
                duration: Duration(minutes: 20)),
            Task(id: '3', title: 'Go shopping', duration: Duration(hours: 3)),
            Task(
                id: '4', title: 'Bake a cake', duration: Duration(minutes: 30)),
          ],
        ),
        DayInRoutine(
          weekDay: 'Saturday',
          tasks: [
            Task(duration: Duration(hours: 1), title: 'Do homework', id: '0'),
            Task(
                id: '1',
                title: 'Clean my room',
                duration: Duration(hours: 2, minutes: 30)),
            Task(
                id: '2',
                title: 'Learn at math',
                duration: Duration(minutes: 20)),
            Task(id: '3', title: 'Go shopping', duration: Duration(hours: 3)),
            Task(
                id: '4', title: 'Bake a cake', duration: Duration(minutes: 30)),
          ],
        ),
        DayInRoutine(
          weekDay: 'Sunday',
          tasks: [
            Task(duration: Duration(hours: 1), title: 'Do homework', id: '0'),
            Task(
                id: '1',
                title: 'Clean my room',
                duration: Duration(hours: 2, minutes: 30)),
            Task(
                id: '2',
                title: 'Learn at math',
                duration: Duration(minutes: 20)),
            Task(id: '3', title: 'Go shopping', duration: Duration(hours: 3)),
            Task(
                id: '4', title: 'Bake a cake', duration: Duration(minutes: 30)),
          ],
        )
      ],
    ),
  ];
}

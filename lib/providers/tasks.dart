import 'package:flutter/material.dart';
import 'package:organizer_app/providers/task.dart';

String printDuration(Duration duration) {
  String twoDigits(int n) => n.toString();//.padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  //String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  if(twoDigitMinutes == '0'){
    return "${twoDigits(duration.inHours)}h";
  } else if(twoDigits(duration.inHours) == '0'){
    return "${twoDigitMinutes}m";
  }
  return "${twoDigits(duration.inHours)}h ${twoDigitMinutes}m";
}



class Tasks with ChangeNotifier{
  final List<Task> _tasks = [
  Task(duration: const Duration(hours: 1), title:'Do homework' , id:'0'),
  Task(id: '1',title:'Clean my room', duration: const Duration(hours: 2, minutes: 30)),
  Task(id: '2',title:'Learn at math', duration: const Duration(minutes: 20)),
  Task(id: '3',title:'Go shopping', duration: const Duration(hours: 3)),
  Task(id: '4',title:'Bake a cake', duration: const Duration(minutes: 30)),
  ];

  List<Task> get tasks{
    return [..._tasks];
  }
}
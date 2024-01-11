import 'package:flutter/material.dart';
import 'package:organizer_app/providers/routines.dart';
import 'package:organizer_app/providers/task.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class HomeProgressBar extends StatelessWidget {
  const HomeProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<Routines>(context).activeTasks;
    final remainingItems = Provider.of<Routines>(context).remainingItems(tasks);
    final _remainingDuration = Provider.of<Routines>(context).remainingDuration;
    final _totalDuration = Provider.of<Routines>(context).totalDuration;
    final _donePercent = Provider.of<Routines>(context).donePercent;
    return Padding(
      padding: const EdgeInsets.only(right: 10, top: 9, left: 5, bottom: 8),
      child: LinearPercentIndicator(
        animation: true,
        lineHeight: 13.5,
        percent: 1 -
            (_remainingDuration(tasks).inSeconds /
                _totalDuration(tasks).inSeconds),
        center: Text(
          (_remainingDuration(tasks).inSeconds /
                      _totalDuration(tasks).inSeconds) ==
                  0
              ? 'All tasks completed!'
              : "${remainingItems.length}/${tasks.length}",
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF141721)),
        ),
        progressColor: Color(0xFF74ae6b),
        backgroundColor: Color(0xFFADB7D2),
        // linearGradient: LinearGradient(colors: [
        //   Color(0xFF74ae6b),
        //   Color(0xFF666038),
        // ]),

        barRadius: const Radius.circular(10),
      ),
    );
  }
}

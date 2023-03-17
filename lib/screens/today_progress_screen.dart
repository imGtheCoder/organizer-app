import 'package:flutter/material.dart';
import 'package:organizer_app/providers/routines.dart';
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:organizer_app/providers/task.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../providers/tasks.dart';

class TodayProgressScreen extends StatefulWidget {
  const TodayProgressScreen(
      {super.key, required this.title, required this.currentDate});
  static const pageRoute = '/today-progress-screen';

  final String title;
  final DateTime currentDate;

  @override
  State<TodayProgressScreen> createState() => _TodayProgressScreenState();
}

class _TodayProgressScreenState extends State<TodayProgressScreen> {
  @override
  Widget build(BuildContext context) {
    //final routineData = Provider.of<Routines>(context).routines.firstWhere((element) => element.id == widget.routineId).days.firstWhere((element) => element.weekDay == DateFormat('EEEE').format(widget.currentDate)).tasks;
    final tasks = Provider.of<Routines>(context).activeTasks;
    final _remainingDuration = Provider.of<Routines>(context).remainingDuration;
    final _totalDuration = Provider.of<Routines>(context).totalDuration;
    final _donePercent = Provider.of<Routines>(context).donePercent;
    final _itemsLeft = Provider.of<Routines>(context).itemsLeft;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        //backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.close),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(DateFormat('MMMMd').format(widget.currentDate)),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircularPercentIndicator(
                  animation: true,
                  radius: 50.0,
                  lineWidth: 12.0,
                  percent: 1 -
                      (_remainingDuration(tasks).inSeconds /
                          _totalDuration(tasks).inSeconds),
                  center: Text("${_donePercent(tasks)}%"),
                  progressColor: Colors.amber,
                  circularStrokeCap: CircularStrokeCap.round,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Items left: ${_itemsLeft(tasks)}'),
                    Text((_donePercent(tasks) != '100.0')
                        ? 'Time left: ${printDuration(_remainingDuration(tasks))}'
                        : 'All tasks completed!'),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: (45.0) * 10,
              child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, i) {
                    return Container(
                      margin: const EdgeInsets.only(top: 10, left: 3, right: 3),
                      alignment: Alignment.center,
                      //height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.18),
                            blurRadius: 3,
                            spreadRadius: 0,
                            blurStyle: BlurStyle.outer,
                          )
                        ],
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          setState(() {
                            Provider.of<Routines>(context, listen: false)
                                .updateInfo();
                            tasks[i].completed = !tasks[i].completed;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: tasks[i].completed
                                ? const Color.fromRGBO(0, 255, 0, 0.1)
                                : null,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  tasks[i].completed
                                      ? Icons.check_circle_outline
                                      : Icons.circle_outlined,
                                  color: Color(0xFF5C5470),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(tasks[i].title),
                                const Expanded(child: SizedBox()),
                                Text(printDuration(tasks[i].duration)),
                                const SizedBox(
                                  width: 15,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

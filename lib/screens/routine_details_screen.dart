import 'package:flutter/material.dart';
import 'package:organizer_app/providers/routines.dart';
import 'package:organizer_app/screens/add_routine_screen.dart';
import 'package:provider/provider.dart';
import 'package:organizer_app/widgets/weekdays_divider.dart';

class RoutineDetailScreen extends StatefulWidget {
  const RoutineDetailScreen({
    super.key,
    required this.routineId,
  });

  final String routineId;

  @override
  State<RoutineDetailScreen> createState() => _RoutineDetailScreenState();
}

enum ChosenDay {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday
}

class _RoutineDetailScreenState extends State<RoutineDetailScreen> {
  ChosenDay chosenDay = ChosenDay.monday;
  @override
  Widget build(BuildContext context) {
    String expectedDay(ChosenDay chsD) {
      switch (chsD) {
        case ChosenDay.monday:
          return 'Monday';
        case ChosenDay.tuesday:
          return 'Tuesday';
        case ChosenDay.wednesday:
          return 'Wednesday';
        case ChosenDay.thursday:
          return 'Thursday';
        case ChosenDay.friday:
          return 'Friday';
        case ChosenDay.saturday:
          return 'Saturday';
        case ChosenDay.sunday:
          return 'Sunday';
      }
    }

    final tasks = Provider.of<Routines>(context)
        .routines
        .firstWhere((element) => element.id == widget.routineId)
        .days
        .firstWhere((element) => element.weekDay == expectedDay(chosenDay))
        .tasks;
    final title = Provider.of<Routines>(context)
        .routines
        .firstWhere((element) => element.id == widget.routineId)
        .title;
    final description = Provider.of<Routines>(context)
        .routines
        .firstWhere((element) => element.id == widget.routineId)
        .description;

    var toggleActive = Provider.of<Routines>(context, listen: false).toggleActive ;
    //print(expectedDay(chosenDay));
    return Scaffold(
      
      appBar: AppBar(
        actions: [
          Switch(value: Provider.of<Routines>(context, listen: false).routines.firstWhere((element) => element.id == widget.routineId).active, onChanged: (value){
            setState(() {
              toggleActive(widget.routineId);
              Provider.of<Routines>(context, listen: false).updateInfo();
            });            
          }),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddRoutineScreen(
                            editing: true,
                            routineWaitingAdding: Provider.of<Routines>(context)
                                .routines
                                .firstWhere((element) =>
                                    element.id == widget.routineId))));
              },
              icon: Icon(Icons.edit))
        ],
        title: Text(title),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.18),
                        blurRadius: 4,
                        spreadRadius: 0,
                        blurStyle: BlurStyle.outer)
                  ],
                ),
                height: 40,
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        child: InkWell(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                            onTap: () {
                              setState(() {
                                chosenDay = ChosenDay.monday;
                              });
                            },
                            child: Ink(
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10)),
                                  color: chosenDay == ChosenDay.monday
                                      ? Color(0xFFD6CCC6)
                                      : null),
                              child: const Align(
                                  alignment: Alignment.center,
                                  child: Text('Mon')),
                            ))),
                    const VerticalDivider(
                      width: 1,
                    ),
                    Expanded(
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                chosenDay = ChosenDay.tuesday;
                              });
                            },
                            child: Ink(
                              color: chosenDay == ChosenDay.tuesday
                                  ? Color(0xFFD6CCC6)
                                  : null,
                              child: const Align(
                                  alignment: Alignment.center,
                                  child: Text('Tue')),
                            ))),
                    const VerticalDivider(
                      width: 1,
                    ),
                    Expanded(
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                chosenDay = ChosenDay.wednesday;
                              });
                            },
                            child: Ink(
                              color: chosenDay == ChosenDay.wednesday
                                  ? Color(0xFFD6CCC6)
                                  : null,
                              child: const Align(
                                  alignment: Alignment.center,
                                  child: Text('Wed')),
                            ))),
                    const VerticalDivider(
                      width: 1,
                    ),
                    Expanded(
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                chosenDay = ChosenDay.thursday;
                              });
                            },
                            child: Ink(
                              color: chosenDay == ChosenDay.thursday
                                  ? Color(0xFFD6CCC6)
                                  : null,
                              child: const Align(
                                  alignment: Alignment.center,
                                  child: Text('Thu')),
                            ))),
                    const VerticalDivider(
                      width: 1,
                    ),
                    Expanded(
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                chosenDay = ChosenDay.friday;
                              });
                            },
                            child: Ink(
                              color: chosenDay == ChosenDay.friday
                                  ? Color(0xFFD6CCC6)
                                  : null,
                              child: const Align(
                                  alignment: Alignment.center,
                                  child: Text('Fri')),
                            ))),
                    const VerticalDivider(
                      width: 1,
                    ),
                    Expanded(
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                chosenDay = ChosenDay.saturday;
                              });
                            },
                            child: Ink(
                              color: chosenDay == ChosenDay.saturday
                                  ? Color(0xFFD6CCC6)
                                  : null,
                              child: const Align(
                                  alignment: Alignment.center,
                                  child: Text('Sat')),
                            ))),
                    const VerticalDivider(
                      width: 1,
                    ),
                    Expanded(
                      child: InkWell(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        onTap: () {
                          setState(() {
                            chosenDay = ChosenDay.sunday;
                          });
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              color: chosenDay == ChosenDay.sunday
                                  ? Color(0xFFD6CCC6)
                                  : null),
                          child: const Align(
                              alignment: Alignment.center, child: Text('Sun')),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '  ${description}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Tasks: ',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
              ),
              SizedBox(
                height: tasks.length * 56,
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, i) {
                    return Container(
                      margin: const EdgeInsets.only(
                        top: 15,
                      ),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.18),
                              blurRadius: 2,
                              spreadRadius: 0,
                              blurStyle: BlurStyle.outer)
                        ],
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                tasks[i].title,
                                style: TextStyle(fontSize: 16),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    Provider.of<Routines>(context)
                                        .printDuration(tasks[i].duration),
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:organizer_app/providers/day_in_routine.dart';
import 'package:organizer_app/providers/routine.dart';
import 'package:organizer_app/providers/routines.dart';
import 'package:organizer_app/providers/task.dart';
import 'package:provider/provider.dart';
import 'package:organizer_app/screens/routine_details_screen.dart';

class AddRoutineScreen extends StatefulWidget {
  const AddRoutineScreen(
      {super.key, required this.routineWaitingAdding, this.editing = false});

  static const pageRoute = '/add-routine-screen';

  final Routine routineWaitingAdding;
  final bool editing;

  @override
  State<AddRoutineScreen> createState() => _AddRoutineScreenState();
}

class _AddRoutineScreenState extends State<AddRoutineScreen> {
  var _allDays = false;
  TextEditingController routineTitleController = TextEditingController();
  TextEditingController routineDescController = TextEditingController();
  TextEditingController taskNameController = TextEditingController();
  Duration? pickedDur;
  ChosenDay chosenDay = ChosenDay.monday;

  @override
  void initState() {
    routineTitleController.text = widget.routineWaitingAdding.title;
    routineDescController.text = widget.routineWaitingAdding.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final printDuration = Provider.of<Routines>(context).printDuration;
    final deleteSingleTask = Provider.of<Routines>(context).deleteSingleTask;

    bool isEveryDayComplete(Routine routine) {
      bool complete = true;
      routine.days.forEach((element) {
        if (element.tasks.isEmpty) {
          complete = false;
        }
      });
      return complete;
    }

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

    void addATask(String title, Duration duration, ChosenDay chsd) {
      widget.routineWaitingAdding.days
          .firstWhere((element) => element.weekDay == expectedDay(chsd))
          .tasks
          .add(Task(
              id: DateTime.now().toString(), title: title, duration: duration));
    }

    void showMBSheet(
      ChosenDay chosenDay1,
    ) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setModalState) {
            //print(chosenDay);
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Add a new task:',
                        style: TextStyle(fontSize: 20, fontFamily: 'TiltNeon'),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextField(
                        controller: taskNameController,
                        cursorColor: const Color(0xFF5C5470),
                        style: const TextStyle(fontSize: 16),
                        decoration: const InputDecoration(
                            hintText: 'Title',
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(92, 84, 112, 0.5),
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(92, 84, 112, 1))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(92, 84, 112, 1)))),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Duration: ${pickedDur == null ? 'No dur. picked' : printDuration(pickedDur as Duration)}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              showDurationPicker(
                                      context: context,
                                      initialTime: const Duration(minutes: 30))
                                  .then(
                                (value) {
                                  if (value == null) {
                                    return;
                                  }
                                  setModalState(() {
                                    pickedDur = value;
                                  });
                                },
                              );
                              //print(printDuration(pickedDur_ as Duration))
                            },
                            child: const Text(
                              'Pick Duration',
                              style: TextStyle(fontSize: 17),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          const Expanded(child: SizedBox()),
                          TextButton(
                              onPressed: taskNameController.text != '' &&
                                      pickedDur != null
                                  ? () {
                                      addATask(taskNameController.text,
                                          pickedDur as Duration, chosenDay1);
                                      setState(() {});
                                      Navigator.of(context).pop();
                                    }
                                  : null,
                              child: const Text('Done')),
                          const Expanded(child: SizedBox()),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          });
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                if (/*isEveryDayComplete(widget.routineWaitingAdding) &&*/
                    routineTitleController.text != '') {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Congrats!')));
                  if (widget.editing) {
                    Provider.of<Routines>(context, listen: false).editRoutine(
                        widget.routineWaitingAdding.id,
                        routineTitleController.text,
                        routineDescController.text,
                        widget.routineWaitingAdding.days,
                        widget.routineWaitingAdding.active);
                    Navigator.of(context).pop();
                    return;
                  } else {
                    Provider.of<Routines>(context, listen: false).addNewRoutine(
                        widget.routineWaitingAdding.id,
                        routineTitleController.text,
                        routineDescController.text,
                        widget.routineWaitingAdding.days);
                  }
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('You have missing days')));
                }
                //add routine to general routines
              },
              icon: Icon(Icons.check))
        ],
        leading: IconButton(
            onPressed: () {
              Provider.of<Routines>(context, listen: false).updateInfo();
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close)),
        title: Text(widget.editing ? 'Edit routine' : 'Add a new routine'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                                    ? const Color(0xFFD6CCC6)
                                    : null),
                            child: const Align(
                                alignment: Alignment.center, child: Text('Mon')),
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
                                ? const Color(0xFFD6CCC6)
                                : null,
                            child: const Align(
                                alignment: Alignment.center, child: Text('Tue')),
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
                                ? const Color(0xFFD6CCC6)
                                : null,
                            child: const Align(
                                alignment: Alignment.center, child: Text('Wed')),
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
                                ? const Color(0xFFD6CCC6)
                                : null,
                            child: const Align(
                                alignment: Alignment.center, child: Text('Thu')),
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
                                ? const Color(0xFFD6CCC6)
                                : null,
                            child: const Align(
                                alignment: Alignment.center, child: Text('Fri')),
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
                                ? const Color(0xFFD6CCC6)
                                : null,
                            child: const Align(
                                alignment: Alignment.center, child: Text('Sat')),
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
                                ? const Color(0xFFD6CCC6)
                                : null),
                        child: const Align(
                            alignment: Alignment.center, child: Text('Sun')),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              child: Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: TextField(
                      controller: routineTitleController,
                      cursorColor: const Color(0xFF5C5470),
                      style: const TextStyle(fontSize: 16),
                      decoration: const InputDecoration(
                          icon: Icon(
                            Icons.edit_square,
                            color: Color(0xFF5C5470),
                          ),
                          hintText: 'Title',
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(92, 84, 112, 0.5),
                              fontSize: 16),
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Color.fromRGBO(0, 0, 0, 0))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(92, 84, 112, 1)))),
                    ),
                  ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              child: Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: TextField(
                      controller: routineDescController,
                      cursorColor: const Color(0xFF5C5470),
                      maxLines: 1,
                      style: const TextStyle(fontSize: 16),
                      decoration: const InputDecoration(
                          icon: Icon(
                            Icons.edit_square,
                            color: Color(0xFF5C5470),
                          ),
                          hintText: 'Short description',
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(92, 84, 112, 0.5),
                              fontSize: 16),
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Color.fromRGBO(0, 0, 0, 0))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(92, 84, 112, 1)))),
                    ),
                  )),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              'Tasks:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            TextButton.icon(
                label: const Text('Add a new task'),
                onPressed: () {
                  taskNameController.text = '';
                  pickedDur = null;
                  showMBSheet(chosenDay);
                },
                icon: const Icon(Icons.add)),
            SizedBox(
              height: (40 + 10.0) *
                  widget.routineWaitingAdding.days
                      .firstWhere(
                          (element) => element.weekDay == expectedDay(chosenDay))
                      .tasks
                      .length,
              child: ListView.builder(
                  itemCount: (widget.routineWaitingAdding.days
                          .firstWhere((element) =>
                              element.weekDay == expectedDay(chosenDay))
                          .tasks
                          .isNotEmpty)
                      ? widget.routineWaitingAdding.days
                          .firstWhere((element) =>
                              element.weekDay == expectedDay(chosenDay))
                          .tasks
                          .length
                      : 1,
                  itemBuilder: (context, i) {
                    return (widget.routineWaitingAdding.days
                            .firstWhere((element) =>
                                element.weekDay == expectedDay(chosenDay))
                            .tasks
                            .isNotEmpty)
                        ? Container(
                            height: 35,
                            margin: const EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(0, 0),
                                    blurRadius: 2,
                                    spreadRadius: 0,
                                    blurStyle: BlurStyle.outer)
                              ],
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onLongPress: () {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content:
                                      Text('Do you want to delete this item?'),
                                  action: SnackBarAction(
                                      label: 'YES',
                                      onPressed: () {
                                        deleteSingleTask(
                                          widget.routineWaitingAdding.id,
                                          widget.routineWaitingAdding.days
                                              .firstWhere((element) =>
                                                  element.weekDay ==
                                                  expectedDay(chosenDay))
                                              .weekDay,
                                          widget.routineWaitingAdding.days
                                              .firstWhere((element) =>
                                                  element.weekDay ==
                                                  expectedDay(chosenDay))
                                              .tasks[i]
                                              .id,
                                        );
                                        setState(() {});
                                      }),
                                ));
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(widget.routineWaitingAdding.days
                                        .firstWhere((element) =>
                                            element.weekDay ==
                                            expectedDay(chosenDay))
                                        .tasks[i]
                                        .title),
                                    Text(printDuration(widget
                                        .routineWaitingAdding.days
                                        .firstWhere((element) =>
                                            element.weekDay ==
                                            expectedDay(chosenDay))
                                        .tasks[i]
                                        .duration)),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : const Text('No tasks added yet');
                  }),
            ),
          ]),
        ),
      ),
    );
  }
}

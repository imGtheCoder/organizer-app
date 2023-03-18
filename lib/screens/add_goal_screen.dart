import 'package:flutter/material.dart';
import 'package:organizer_app/providers/goals.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:organizer_app/providers/goal.dart';

class AddGoalScreen extends StatefulWidget {
  const AddGoalScreen(
      {super.key, required this.goalWaitingAdding, required this.editing});

  final Goal goalWaitingAdding;
  final bool editing;

  @override
  State<AddGoalScreen> createState() => _AddGoalScreenState();
}

class _AddGoalScreenState extends State<AddGoalScreen> {
  TextEditingController goalTitleController = TextEditingController();
  TextEditingController goalDescController = TextEditingController();
  DateTime? pickedTargetDate;

  @override
  void initState() {
    goalTitleController.text = widget.goalWaitingAdding.title;
    goalDescController.text = widget.goalWaitingAdding.description;
    super.initState();
  }

  Widget _customTextField(
      String placeholder, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: TextField(
        controller: controller,
        cursorColor: const Color(0xFF5C5470),
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
            icon: const Icon(
              Icons.edit_square,
              color: Color(0xFF5C5470),
            ),
            hintText: placeholder,
            hintStyle: const TextStyle(
                color: Color.fromRGBO(92, 84, 112, 0.5), fontSize: 16),
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0))),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color.fromRGBO(92, 84, 112, 1)))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.close),
        ),
        actions: [
          IconButton(
              onPressed: () {
                //TODO: ADD THE GOAL
                if (!widget.editing) {
                  if (goalTitleController.text != '' &&
                      goalDescController.text != '' &&
                      pickedTargetDate != null) {
                    Provider.of<Goals>(context, listen: false).addNewGoal(
                        goalTitleController.text,
                        goalDescController.text,
                        pickedTargetDate as DateTime,
                        DateTime.now());
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('You have empty fields!')));
                  }
                } else {
                  if (goalTitleController.text != '' &&
                      goalDescController.text != '') {
                    Provider.of<Goals>(context, listen: false).editGoal(
                        widget.goalWaitingAdding.id,
                        goalTitleController.text,
                        goalDescController.text);
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('You have empty fields!')));
                  }
                }
              },
              icon: const Icon(Icons.check))
        ],
        //backgroundColor: Colors.white,
        title: Text(widget.editing ? 'Edit goal' : 'Add a new goal'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _customTextField('Title', goalTitleController),
              const SizedBox(
                height: 5,
              ),
              _customTextField('Description', goalDescController),
              const SizedBox(
                height: 15,
              ),
              if (!widget.editing)
                Row(
                  children: [
                    const Text(
                      'Target: ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      pickedTargetDate == null
                          ? 'Choose a completion date.'
                          : DateFormat('d/M/y')
                              .format(pickedTargetDate as DateTime),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                            onPressed: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2050),
                                builder: (context, child) {
                                  return Theme(
                                      data: Theme.of(context).copyWith(
                                        dialogBackgroundColor:
                                            const Color(0xFFEAE0DA),
                                        colorScheme: Theme.of(context)
                                            .colorScheme
                                            .copyWith(
                                                // Title, selected date and day selection background (dark and light mode)
                                                surface:
                                                    const Color(0xFF5C5470),
                                                primary:
                                                    const Color(0xFF5C5470),
                                                // Title, selected date and month/year picker color (dark and light mode)
                                                onSurface:
                                                    const Color(0xFF5C5470),
                                                onPrimary: Colors
                                                    .white //Color(0xFF5C5470),
                                                ),
                                      ),
                                      child: child!);
                                },
                              ).then((value) {
                                setState(() {
                                  pickedTargetDate = value;
                                });
                              });
                            },
                            icon: const Icon(
                              Icons.calendar_month,
                              color: Color(0xFF5C5470),
                            )),
                      ),
                    )
                  ],
                )
            ],
          )),
    );
  }
}

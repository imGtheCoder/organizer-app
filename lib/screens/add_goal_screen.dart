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
          IconButton(onPressed: (){
            //TODO: ADD THE GOAL
            Provider.of<Goals>(context, listen: false).addNewGoal(goalTitleController.text, goalDescController.text, pickedTargetDate as DateTime, DateTime.now());
          }, icon: Icon(Icons.check))
        ],
        //backgroundColor: Colors.white,
        title: Text(widget.editing ? 'Edit goal' : 'Add a new goal'),
      ),
      body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              _customTextField('Title', goalTitleController),
              SizedBox(
                height: 5,
              ),
              _customTextField('Description', goalDescController),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    'Target: ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
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
                                      dialogBackgroundColor: Color(0xFFEAE0DA),
                                      colorScheme: Theme.of(context)
                                          .colorScheme
                                          .copyWith(
                                              // Title, selected date and day selection background (dark and light mode)
                                              surface: Color(0xFF5C5470),
                                              primary: Color(0xFF5C5470),
                                              // Title, selected date and month/year picker color (dark and light mode)
                                              onSurface: Color(0xFF5C5470),
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
                          icon: Icon(Icons.calendar_month, color: Color(0xFF5C5470),)),
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}

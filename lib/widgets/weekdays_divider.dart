import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class WeekdaysDivider extends StatefulWidget {
  const WeekdaysDivider({super.key});

  static ChosenDay chosenDay = ChosenDay.monday;

  @override
  State<WeekdaysDivider> createState() => _WeekdaysDividerState();
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

class _WeekdaysDividerState extends State<WeekdaysDivider> {
  //ChosenDay chosenDay = ChosenDay.monday;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        WeekdaysDivider.chosenDay = ChosenDay.monday;
                      });
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
                            color: WeekdaysDivider.chosenDay == ChosenDay.monday ? Color(0xFFD6CCC6) : null
                      ),
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
                        WeekdaysDivider.chosenDay = ChosenDay.tuesday;
                      });
                    },
                    child: Ink(
                      color: WeekdaysDivider.chosenDay == ChosenDay.tuesday ? Color(0xFFD6CCC6) : null,
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
                        WeekdaysDivider.chosenDay = ChosenDay.wednesday;
                      });
                    },
                    child: Ink(
                      color: WeekdaysDivider.chosenDay == ChosenDay.wednesday ? Color(0xFFD6CCC6) : null,
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
                        WeekdaysDivider.chosenDay = ChosenDay.thursday;
                      });
                    },
                    child: Ink(
                      color: WeekdaysDivider.chosenDay == ChosenDay.thursday ? Color(0xFFD6CCC6) : null,
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
                        WeekdaysDivider.chosenDay = ChosenDay.friday;
                      });
                    },
                    child: Ink(
                      color: WeekdaysDivider.chosenDay == ChosenDay.friday ? Color(0xFFD6CCC6) : null,
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
                       WeekdaysDivider.chosenDay = ChosenDay.saturday;
                      });
                    },
                    child: Ink(
                      color: WeekdaysDivider.chosenDay == ChosenDay.saturday ? Color(0xFFD6CCC6) : null,
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
                        WeekdaysDivider.chosenDay = ChosenDay.sunday;
                      });
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                            color: WeekdaysDivider.chosenDay == ChosenDay.sunday ? Color(0xFFD6CCC6) : null
                      ),
                      child: const Align(
                          alignment: Alignment.center, child: Text('Sun')),
                    ))),
          ],
        ));
  }
}

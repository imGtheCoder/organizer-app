import 'package:flutter/material.dart';

class WeekdaysDivider extends StatefulWidget {
  const WeekdaysDivider({super.key, required this.chosenDay});
  final ChosenDay chosenDay;

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
  ChosenDay chosenDay = ChosenDay.monday;
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
    );
  }
}

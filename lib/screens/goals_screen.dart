import 'package:flutter/material.dart';
import 'package:organizer_app/providers/goal.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:organizer_app/providers/routines.dart';
import 'package:organizer_app/screens/add_goal_screen.dart';
import '../providers/goals.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});
  static const pageRoute = '/goals-screen';

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  @override
  Widget build(BuildContext context) {
    final goals = Provider.of<Goals>(context).goals;
    //Provider.of<Goals>(context).getTodayTimeSpent(goals[0].id, DateTime.now());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddGoalScreen(
                            goalWaitingAdding:
                                Provider.of<Goals>(context).emptyGoal,
                            editing: false)));
                //Navigator.of(context).pushNamed(AddGoalScreen.pageRoute);
              },
              icon: const Icon(Icons.add))
        ],
        //backgroundColor: Colors.white,
        title: const Text('Goals'),
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: goals.isNotEmpty
              ? ListView.builder(
                  itemCount: goals.length,
                  itemBuilder: (ctx, i) {
                    //goals[i].expanded = false;
                    return itemInList(goals, i, context);
                  },
                )
              : const Center(
                  child: Text(
                  'You have not added any goal yet. To see something here, you may add a goal.',
                  textAlign: TextAlign.center,
                ))),
    );
  }

  Container itemInList(List<Goal> goals, int i, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15, right: 3, left: 3),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.18),
              blurRadius: 3,
              spreadRadius: 0,
              blurStyle: BlurStyle.outer)
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          setState(() {
            goals[i].expanded = !goals[i].expanded;
          });
        },
        onLongPress: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text('Warning!'),
                    content: Text(
                      'Are you sure you want to permanently delete this goal?',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Provider.of<Goals>(context, listen: false)
                                .deleteGoal(goals[i].id);
                            Navigator.pop(context);
                          },
                          child: const Text('Yes')),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('No'))
                    ],
                  ));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  if (goals[i].currentlyWorkingOnIt)
                    const Icon(
                      Icons.circle,
                      size: 15,
                      color: Color.fromRGBO(0, 255, 0, 0.2),
                    ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    goals[i].title,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        !goals[i].expanded
                            ? Icons.expand_more
                            : Icons.expand_less,
                        color: const Color(0xFF5C5470),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  )
                ],
              ),
              if (goals[i].expanded)
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        goals[i].description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Started on: ',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(DateFormat('d/M/y').format(goals[i].addedAt))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Total time spent: ${Provider.of<Routines>(context, listen: false).printDuration(goals[i].totalTimeSpent)}',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Target completion date: ',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(DateFormat('d/M/y').format(goals[i].finishDate)),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddGoalScreen(
                                          goalWaitingAdding: goals[i],
                                          editing: true)));
                            },
                            icon: const Icon(
                              Icons.edit,
                              size: 16,
                              color: Color(0xFF5C5470),
                            ),
                          ),
                          Text('Edit this goal')
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            child: Text(!goals[i].currentlyWorkingOnIt
                                ? 'Work on this'
                                : 'Stop'),
                            onPressed: () {
                              if (goals[i].currentlyWorkingOnIt) {
                                setState(() {
                                  goals[i].currentlyWorkingOnIt = false;
                                });
                                Provider.of<Goals>(context, listen: false)
                                    .addToTodayTimeSpent(
                                  goals[i].id,
                                );
                              } else {
                                goals[i].startedAt = DateTime.now();
                                setState(() {
                                  goals[i].currentlyWorkingOnIt = true;
                                });
                              }
                            },
                          ),
                          Text(
                              'Time spent today: ${Provider.of<Routines>(context, listen: false).printDuration(goals[i].todayTimeSpent)}')
                        ],
                      ),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

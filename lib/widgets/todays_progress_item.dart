import 'package:flutter/material.dart';
import 'package:organizer_app/widgets/home_progress_bar.dart';
import 'package:provider/provider.dart';
import '../providers/routines.dart';
import 'package:organizer_app/screens/today_progress_screen.dart';

class TodaysProgressItem extends StatelessWidget {
  const TodaysProgressItem({
    super.key,
    required this.currentDate,
  });

  final DateTime currentDate;

  @override
  Widget build(BuildContext context) {
    Provider.of<Routines>(context).getTodaysTasks(currentDate);
    final activeRoutines =Provider.of<Routines>(context).getActiveRoutines();
    final todayTasks = Provider.of<Routines>(context).activeTasks;

    final remainingDuration = Provider.of<Routines>(context, listen: false)
        .printDuration(Provider.of<Routines>(context, listen: false)
            .remainingDuration(todayTasks));

    final completedTasks = [];
    for (var element in todayTasks) {
      if (element.completed == true) {
        completedTasks.add(element);
      }
    }

    return AspectRatio(
      aspectRatio: 3.5 / 2,
      child: Container(
        margin: const EdgeInsets.all(15),
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.18),
                blurRadius: 4,
                spreadRadius: 0,
                blurStyle: BlurStyle.outer)
          ],
        ),
        child: InkWell(
          onTap: todayTasks.isNotEmpty? () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TodayProgressScreen(
                    title: 'What\'s left for today?',
                    currentDate: DateTime.now(),
                  ),
                ));
            //Navigator.of(context).pushNamed(TodayProgressScreen.pageRoute);
          }: null,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0, right: 15, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    'What\'s left for today?',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: todayTasks.isNotEmpty
                          ? ListView.builder(
                              itemBuilder: (ctx, i) {
                                return SizedBox(
                                  height: 20,
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.chevron_right,
                                        size: 10,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        todayTasks[i].title,
                                        style: TextStyle(
                                            decoration: completedTasks
                                                    .contains(todayTasks[i])
                                                ? TextDecoration.lineThrough
                                                : null,
                                            fontSize: 16.0,
                                            color: const Color(
                                                0xFF5C5470)), //Theme.of(context).textTheme.bodyMedium,
                                      )
                                      //Text('Hello')
                                    ],
                                  ),
                                );
                              },
                              itemCount: todayTasks
                                  .length, // TODO: Implement ITEM BUILDER
                            )
                          :Text(
                              activeRoutines.isEmpty ?'You do not have any active routine. To see something here, you should activate at least one routine.': 'Yaaay! No tasks for today! :)')),
                ),
                todayTasks.isNotEmpty
                    ? Row(
                        children: [
                          const Expanded(
                            child: HomeProgressBar(),
                          ),
                          Text(remainingDuration,
                              style: Theme.of(context).textTheme.titleMedium),
                        ],
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

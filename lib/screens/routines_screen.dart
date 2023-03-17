import 'package:flutter/material.dart';
import 'package:organizer_app/screens/routine_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:organizer_app/providers/task.dart';
import 'package:organizer_app/screens/add_routine_screen.dart';
import '../providers/routines.dart';

class RoutinesScreen extends StatelessWidget {
  const RoutinesScreen({super.key});

  static const pageRoute = '/routines-screen';

  Widget _gridItem(BuildContext context, String title, String description,
      int i, String routineId, String avgDuration) {
    return Container(
      margin: EdgeInsets.only(
          top: 15,
          right: (i % 2 == 0) ? 7.5 : 15,
          left: (i % 2 == 0) ? 15 : 7.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.18),
              blurRadius: 4,
              spreadRadius: 0,
              blurStyle: BlurStyle.outer)
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      RoutineDetailScreen(routineId: routineId)));
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (Provider.of<Routines>(context).routines[i].active)
                    Icon(
                      Icons.circle,
                      color: Color.fromRGBO(
                        0,
                        255,
                        0,
                        0.1,
                      ),
                      size: 15,
                      shadows: [
                        BoxShadow(
                          blurRadius: 1,
                          blurStyle: BlurStyle.outer,
                          color: Color.fromRGBO(0, 0, 0, 0.2),
                        )
                      ],
                    ),
                  SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: (MediaQuery.of(context).size.width - 150) / 2,
                    child: Text(
                      
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  )
                ],
              ),
              Text(
                description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Expanded(child: SizedBox()),
              Text('Avg. duration/day: \n$avgDuration')
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final routines = Provider.of<Routines>(context).routines;
    final printDuration = Provider.of<Routines>(context).printDuration;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Routines'),
        //backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddRoutineScreen(
                            routineWaitingAdding:
                                Provider.of<Routines>(context, listen: false)
                                    .emptyRoutine)));
                //open add routine screen
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: GridView.builder(
          itemCount: routines.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (context, i) {
            final averageDuration = Provider.of<Routines>(context)
                .averageDurationOverTheWeek(routines[i].days);
            return _gridItem(
                context,
                routines[i].title,
                routines[i].description,
                i,
                routines[i].id,
                printDuration(averageDuration));
          }),
    );
  }
}

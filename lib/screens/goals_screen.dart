import 'package:flutter/material.dart';
import 'package:organizer_app/screens/add_goal_screen.dart';
import '../providers/goals.dart' as GOALS;

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});
  static const pageRoute = '/goals-screen';

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  @override
  Widget build(BuildContext context) {
    final items = GOALS.goals;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddGoalScreen.pageRoute);
              },
              icon: Icon(Icons.add))
        ],
        //backgroundColor: Colors.white,
        title: const Text('Goals'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (ctx, i) {
            //items[i].expanded = false;
            return Container(
              margin: const EdgeInsets.only(top: 15),
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
                    items[i].expanded = !items[i].expanded;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.bolt),
                          Text(
                            items[i].title,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Icon(!items[i].expanded
                                  ? Icons.expand_more
                                  : Icons.expand_less, color: Color(0xFF5C5470),),
                            ),
                          ),
                          SizedBox(width: 10,)
                        ],
                      ),
                      if (items[i].expanded)
                        Container(
                          padding:
                              EdgeInsets.only(right: 20, left: 20, top: 15),
                          child: Text(
                            items[i].description,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      if (items[i].expanded)
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15, right: 15, left: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                child: Text('Work on this'),
                                onPressed: () {},
                              ),
                              Text('20/02/2056')
                            ],
                          ),
                        )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

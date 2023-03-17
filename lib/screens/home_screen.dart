import 'package:flutter/material.dart';
import 'package:organizer_app/providers/routines.dart';
import 'package:organizer_app/screens/wallpaper_screen.dart';
import 'package:organizer_app/widgets/home_drawer.dart';
import 'package:provider/provider.dart';
import 'package:organizer_app/screens/goals_screen.dart';
import 'package:organizer_app/screens/help_screen.dart';
import 'package:organizer_app/screens/routines_screen.dart';

//widgets
import 'package:organizer_app/widgets/home_progress_bar.dart';
import 'package:organizer_app/widgets/todays_progress_item.dart';
import 'package:organizer_app/widgets/square_item.dart';

//providers


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context){

   
    // final remainingItems = Provider.of<Routines>(context).remainingItems();
     return Scaffold(
      drawer: const HomeDrawer(),
      appBar: AppBar(
        title: const Text('Welcome back, USER'),
        //backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          //const HomeProgressBar(),
          TodaysProgressItem(
            currentDate: DateTime.now(),
          ),
          Row(
            children: const [
              Expanded(
                  child: SquareItem(
                icon: Icons.favorite_outline,
                title: 'HELP',
                destination: HelpScreen.pageRoute,
              )),
              Expanded(
                  child: SquareItem(
                icon: Icons.calendar_month,
                title: 'ROUTINES',
                isLast: true,
                destination: RoutinesScreen.pageRoute,
              )),
            ],
          ),
          Row(
            children: const [
              Expanded(
                  child: SquareItem(
                icon: Icons.star_outline,
                title: 'GOALS',
                destination: GoalsScreen.pageRoute,
              )),
              Expanded(
                  child: SquareItem(
                icon: Icons.landscape_outlined,
                title: 'WALLPAPER',
                isLast: true,
                destination: WallpaperScreen.pageRoute,
              )),
            ],
          )
        ]),
      ),
    );
  }
}

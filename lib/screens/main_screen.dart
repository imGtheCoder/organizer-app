import 'package:flutter/material.dart';
import 'package:organizer_app/screens/goals_screen.dart';
import 'package:organizer_app/screens/help_screen.dart';
import 'package:organizer_app/screens/routines_screen.dart';
import 'package:organizer_app/screens/wallpaper_screen.dart';
import 'package:organizer_app/widgets/square_item.dart';
import 'package:organizer_app/widgets/todays_progress_item.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
    );
  }
}

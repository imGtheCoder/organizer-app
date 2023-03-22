import 'package:flutter/material.dart';
import 'package:organizer_app/widgets/everyday_stat_table.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(children: [
        EverydayStatTable()
      ],),
    );
  }
}

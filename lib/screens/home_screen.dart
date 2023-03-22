import 'package:flutter/material.dart';
import 'package:organizer_app/screens/main_screen.dart';
import 'package:organizer_app/screens/statistics_screen.dart';

import 'package:organizer_app/widgets/home_drawer.dart';
//providers

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum SelectedItem { home, stats }

class _HomeScreenState extends State<HomeScreen> {
  var selectedItem = SelectedItem.home;
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HomeDrawer(),
      appBar: AppBar(
        title: const Text('Welcome back, USER'),
        //backgroundColor: Colors.white,
      ),
      bottomNavigationBar: bottomNavBar(),
      body:
          selectedItem == SelectedItem.home ? MainScreen() : StatisticsScreen(),
    );
  }

  SizedBox bottomNavBar() {
    return SizedBox(
      height: 90,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Divider(
          //   height: 0,
          //   indent: 50,
          //   endIndent: 50,
          //   thickness: 1,
          //   //color: Color(0xFF5C5470),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      setState(() {
                        selectedItem = SelectedItem.home;
                      });
                    },
                    icon: Icon(
                      Icons.home,
                      size: selectedItem == SelectedItem.home ? 40 : 30,
                      color: Color(0xFF5C5470),
                    ),
                  ),
                  if (selectedItem == SelectedItem.home)
                    Container(
                      height: 2,
                      width: 40,
                      color: const Color(0xFF5C5470),
                    )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      setState(() {
                        selectedItem = SelectedItem.stats;
                      });
                    },
                    icon: Icon(
                      Icons.bar_chart,
                      size: selectedItem == SelectedItem.stats ? 40 : 30,
                      color: Color(0xFF5C5470),
                    ),
                  ),
                  if (selectedItem == SelectedItem.stats)
                    Container(
                      height: 2,
                      width: 40,
                      decoration: BoxDecoration(
                          color: const Color(0xFF5C5470),
                          borderRadius: BorderRadius.circular(5)),
                    )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

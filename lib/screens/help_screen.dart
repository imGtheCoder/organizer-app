import 'package:flutter/material.dart';
import '../providers/help_items.dart';

class HelpScreen extends StatelessWidget {
  static const String pageRoute = '/help-screen';
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.white,
        title: const Text('What\'s bothering you?'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: helpItems.length,
          itemBuilder: (ctx, i) {
            return Container(
              margin: const EdgeInsets.only(top: 15,),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3,
                      spreadRadius: 0,
                      blurStyle: BlurStyle.outer)
                ],
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                              children: [
                                Icon(Icons.bolt),
                                Text(
                                  helpItems[i],
                                  style: TextStyle(fontSize: 20),
                                ),
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

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class EverydayStatTable extends StatelessWidget {
  const EverydayStatTable({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3/2,
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.18),
                blurRadius: 3,
                spreadRadius: 0,
                blurStyle: BlurStyle.outer)
          ],
        ),
        child: Column(children: [
          Text('Time spent on goals'),
          Expanded(
            child: GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
              itemCount: 31,
              itemBuilder: (context, index) {
                return AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    //child: Text(index.toString()),
                    margin: EdgeInsets.all(1),
                    color: Colors.green,
                  ),
                );
              },
            ),
          )
        ]),
      ),
    );
  }
}

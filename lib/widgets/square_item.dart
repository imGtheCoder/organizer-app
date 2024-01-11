import 'package:flutter/material.dart';

class SquareItem extends StatelessWidget {
  const SquareItem({
    super.key,
    required this.title,
    this.isLast = false,
    required this.destination,
    required this.icon,
  });

  final String title;
  final IconData icon;
  final String destination;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        margin: EdgeInsets.only(
            left: !isLast ? 15 : 7.5,
            top: 0,
            bottom: 15,
            right: isLast ? 15 : 7.5),
        //height: 170, //TODO: USE MEDIAQUERY??

        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Color(0xFF141721),
          boxShadow: [
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
            Navigator.pushNamed(context, destination);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 80,
                  color: Color(0xFF4D724E),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

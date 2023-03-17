import 'package:flutter/material.dart';

class AddGoalScreen extends StatelessWidget {
  const AddGoalScreen({super.key, required this.title});
  static const pageRoute = '/add-goal-screen';

  final String title;

  Widget _customTextField(String placeholder) {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 3),
        margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
        decoration: const BoxDecoration(
          //color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 4),
                blurRadius: 2,
                spreadRadius: 2,
                blurStyle: BlurStyle.outer)
          ],
        ),
        child: TextFormField(
          decoration: InputDecoration(
            label: Text(placeholder),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.close),
        ),
        //backgroundColor: Colors.white,
        title: Text(title),
      ),
      body: Form(
          child: Column(
        children: [
          _customTextField('Title'),
          _customTextField('Description'),
          _customTextField('Select target date'),
          //showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2004), lastDate: DateTime(2050)),
        ],
      )),
    );
  }
}

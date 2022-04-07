import 'package:flutter/material.dart';

class BaseAlertDialog extends StatelessWidget {
  const BaseAlertDialog(
      {Key? key,
      required this.title,
      required this.content,
      required this.yesOnPressed,
      required this.noOnPressed,
      this.yes = "Yes",
      this.no = "No"})
      : super(key: key);

  final String title;
  final String content;
  final String yes;
  final String no;
  final VoidCallback yesOnPressed;
  final VoidCallback noOnPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: Colors.white,
      actions: [
        ElevatedButton(
          onPressed: noOnPressed,
          child: Text(no),
        ),
        ElevatedButton(
          onPressed: yesOnPressed,
          child: Text(yes),
        ),
      ],
    );
  }
}

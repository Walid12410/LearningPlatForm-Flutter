import 'package:flutter/material.dart';
import 'package:learningplatformapp/colors/color.dart';


void ShowDialog(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close',style: TextStyle(
                fontWeight: FontWeight.bold,color: tdBlue
            ),),
          ),
        ],
      );
    },
  );
}
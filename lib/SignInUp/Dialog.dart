import 'package:flutter/material.dart';
import 'package:learningplatformapp/colors/color.dart';
import '../generated/l10n.dart';


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
            child: Text(S.of(context).Close,style:const TextStyle(
                fontWeight: FontWeight.bold,color: tdBlue
            ),),
          ),
        ],
      );
    },
  );
}
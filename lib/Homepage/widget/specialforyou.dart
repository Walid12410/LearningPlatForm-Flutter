import 'package:flutter/material.dart';
import 'package:learningplatformapp/colors/color.dart';

import '../../generated/l10n.dart';


class Specialforyou extends StatelessWidget {
  const Specialforyou({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);
  final String text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              color: tdBlue,
            ),
          ),
          GestureDetector(
            onTap: press,
            child:  Text(
             S.of(context).SeeMore,
              style: const TextStyle(color: tdBlue),
            ),
          )
        ],
      ),
    );
  }
}

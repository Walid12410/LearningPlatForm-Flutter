import 'package:flutter/material.dart';
import 'package:learningplatformapp/colors/color.dart';


class TileList extends StatelessWidget {
  const TileList({
    super.key,
    required this.name,
    required this.press,
    required this.requiredIcon
  });

  final String name;
  final VoidCallback press;
  final IconData requiredIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: press,
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: tdbrown),
            child: ListTile(
              title: Text(
                name,
                style:
                const TextStyle(color: tdBlue, fontWeight: FontWeight.bold),
              ),
              trailing: Icon(requiredIcon,color: Colors.black,
                  size: 20,)

            )
        ),
      ),
    );
  }
}

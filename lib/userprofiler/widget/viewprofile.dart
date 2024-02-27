import 'package:flutter/material.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/userprofiler/editprofile.dart';


class Profileview extends StatelessWidget {
  const Profileview({
    super.key,
    required this.title,
    required this.desc,
  });

  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: tdBGColor
        ),
        child: ListTile(
          title: Text(
            title,
            style: const TextStyle(color: tdBlue, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            desc,
            style: const TextStyle(color: tdBlue),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateProfileScreen()));
            },
          ),
        ),
      ),
    );
  }
}

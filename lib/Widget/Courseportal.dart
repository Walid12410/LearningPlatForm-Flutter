import 'package:flutter/material.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/AllClass/portal.dart';
import 'package:learningplatformapp/HomePages/CoursePage.dart';

class CoursePortal extends StatelessWidget {
  const CoursePortal({
    super.key,
    required this.portals,
  });

  final Portal portals;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.zero,
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.zero,
          ),
          color: tdbrown),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 160,
                height: 40,
                child: Container(
                    decoration: const BoxDecoration(
                      color: tdlightbrown,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.zero,
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.zero,
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          portals.portalName,
                          style: const TextStyle(color: tdBlue, fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
              )
            ],
          ),
          const SizedBox(height: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 40,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    portals.portalDescription,
                    style: const TextStyle(color: tdBlue),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 10,),
              const Text('Show Courses',style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.bold,
                  color: tdBlue
              ),),
              const SizedBox(width: 10),
              IconButton(
                color: tdBlue,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                      CourseListView(portalid: portals.portalID),
                  ));
                },
                icon: const Icon(Icons.arrow_circle_right_rounded),
                iconSize:40,
              ),
            ],
          )
        ],
      ),
    );
  }
}
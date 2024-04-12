import 'package:flutter/material.dart';
import 'package:learningplatformapp/colors/color.dart';

import '../generated/l10n.dart';

class CustomTabBarView extends StatelessWidget {
  final TabController tabController;
  final List<Widget> tabViews;

  const CustomTabBarView({
    required this.tabController,
    required this.tabViews,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: tdbrown,
          child: TabBar(
            controller: tabController,
            indicatorColor:
                Colors.black, // Change the color of the indicator to black
            tabs: [
              Tab(
                child: Text(
                  S.of(context).InfoCourse,
                  style: const TextStyle(
                    color: tdBlue,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  S.of(context).Chapters,
                  style: const TextStyle(color: tdBlue),
                ),
              ),
              Tab(
                child: Text(
                  S.of(context).Quiz,
                  style: const TextStyle(
                    color: tdBlue,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height -
              kToolbarHeight -
              kBottomNavigationBarHeight -
              200.0,
          child: TabBarView(
            controller: tabController,
            children: tabViews,
          ),
        ),
      ],
    );
  }
}

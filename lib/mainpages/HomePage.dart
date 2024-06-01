import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningplatformapp/userprofiler/profile.dart';
import '../Homepage/MainPage.dart';
import 'package:learningplatformapp/UserCourses/UserCourse.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/SearchCourse/Search.dart';

import '../generated/l10n.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const MainPage(),
      const UserCoursePage(),
      const SearchCourse(),
      const Profile()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: tdbrown,
      child: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: tdbrown,
          selectedItemColor: tdBlue,
          unselectedItemColor:
              tdBGColor,
          onTap: (int newIndex) {
            setState(() {
              _selectedIndex = newIndex;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon:  Icon(Icons.home,size: 20.w), label: S.of(context).HomePage),
            BottomNavigationBarItem(
                icon:  Icon(Icons.school,size: 20.w), label: S.of(context).MyCourse),
            BottomNavigationBarItem(
                icon:  Icon(Icons.search,size: 20.w,), label: S.of(context).Search),
            BottomNavigationBarItem(
                icon:  Icon(Icons.account_circle,size: 20.w,),
                label: S.of(context).Profile)
          ],
        ),
      ),
    );
  }
}

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

    return Scaffold(
        backgroundColor: Colors.white,
        body: _pages[_selectedIndex],
        bottomNavigationBar: Builder(builder: (context) {
          final mediaQuery = MediaQuery.of(context);
          return MediaQuery(
            data: mediaQuery.removeViewPadding(
              removeBottom: true,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                right: 8 + mediaQuery.viewPadding.right,
                left: 8 + mediaQuery.viewPadding.left,
                bottom: 12 + mediaQuery.viewPadding.bottom,
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(200).w,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(200).w,
                  child: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: tdbrown,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    selectedLabelStyle: const TextStyle(fontSize: 0),
                    unselectedLabelStyle: const TextStyle(fontSize: 0),
                    onTap: (newIndex) {
                      setState(() {
                        _selectedIndex = newIndex;
                      });
                    },
                    currentIndex: _selectedIndex,
                    items:  [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home, color: Colors.black,size: 30.w),
                        label: '',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.school_outlined,
                            color: Colors.black, size: 30.w),
                        label: '',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.search_outlined,
                            color: Colors.black, size: 30.w),
                        label: '',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.account_box, color: Colors.black,size: 30.w,),
                        label: '',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
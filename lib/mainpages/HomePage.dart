import 'package:flutter/material.dart';
import 'package:learningplatformapp/userprofiler/profile.dart';
import '../Homepage/MainPage.dart';
import 'package:learningplatformapp/UserCourses/UserCourse.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'PortalPage.dart';
import 'package:learningplatformapp/SearchCourse/Search.dart';

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
      const UserCourse(),
      const SearchCourse(),
      const Profile()
    ];
  }

  void _onPageTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: tdbrown, // Set your desired background color here
      child: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: tdbrown, // Set the background color here
          selectedItemColor: tdBlue, // Set the selected item color if needed
          unselectedItemColor:
              tdBGColor, // Set the unselected item color if needed
          onTap: (int newIndex) {
            setState(() {
              _selectedIndex = newIndex;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.school), label: 'MyCourse'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), label: 'Profile')
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'MainPage.dart';
import 'Trainer.dart';
import 'setting.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'PortalPage.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const MainPage(),
    const PortalPage(),
    const TrainerPage(),
    const Setting(),
  ];

  void _onPageTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: ClipRRect(
        child: GNav(
          backgroundColor: tdbrown,
          selectedIndex: _selectedIndex,
          onTabChange: _onPageTapped,
          activeColor: tdBlue,
          color: tdBlue,
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.category,
              text: 'Categories',
            ),
            GButton(
              icon:Icons.assignment_ind_outlined,
              text: 'Instructor',
            ),
            GButton(
              icon: Icons.settings,
              text: 'Setting',
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:learningplatformapp/SignInUp/signin.dart';
import 'pageviewdetails.dart';
import 'package:learningplatformapp/colors/color.dart';

class PageViewScreen extends StatefulWidget {
  const PageViewScreen({Key? key}) : super(key: key);

  @override
  _PageViewScreenState createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  int _currentPage = 0;
  late PageController _pageController;
  List<page> _slides = [];

  @override
  void initState() {
    super.initState();
    _slides = [
      page("assets/image2.png", "StudyLink: Your Ultimate Education Destination Online"),
      page("assets/image1.png", "SmartStudy: Your Comprehensive Digital Learning Platform"),
      page("assets/image3.png", "SkillBoost: Empowering You with Dynamic Online Education"),
      page("assets/image4.png", 'LearnX: Your Gateway to Innovative Digital Learning'),
    ];
    _pageController = PageController(initialPage: _currentPage);
  }

  Widget _buildSlide(page slide) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(32),
            child: Image.asset(slide.Image, fit: BoxFit.contain),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            slide.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(
        _slides.length,
            (index) => _buildPageIndicatorItem(index),
      ).expand((widget) => [widget, const SizedBox(width: 12)]).toList(),
    );
  }

  Widget _buildPageIndicatorItem(int index) {
    return Container(
      width: index == _currentPage ? 8 : 5,
      height: index == _currentPage ? 8 : 5,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: index == _currentPage ? tdbrown : Colors.grey,
      ),
    );
  }

  void _onPageChanged(int page) {
    setState(() => _currentPage = page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                physics: const BouncingScrollPhysics(),
                children: _slides.map(_buildSlide).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildPageIndicator(),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      // Add your callback function here
                    },
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: tdbrown,
                      ),
                      child: const Center(
                        child: Text(
                          "About Our App",
                          style:  TextStyle(
                            letterSpacing: 1,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity, // Set width to fill available space
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SignIn()));
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: tdbrown,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

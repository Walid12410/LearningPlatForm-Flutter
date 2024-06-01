import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningplatformapp/SignInUp/signin.dart';
import 'package:learningplatformapp/aboutapp/aboutapp.dart';
import '../generated/l10n.dart';
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
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _slides = [
      page("assets/image2.png", S.of(context).getStartP1),
      page("assets/image1.png", S.of(context).getStartP2),
      page("assets/image3.png", S.of(context).getStartP3),
      page("assets/image4.png", S.of(context).getStartP4),
    ];

    _pageController = PageController(initialPage: _currentPage);
  }

  Widget _buildSlide(page slide) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(25).w,
            child: Image.asset(slide.Image, fit: BoxFit.contain),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20).w,
          child: Text(
            slide.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List<Widget>.generate(
        _slides.length,
        (index) => _buildPageIndicatorItem(index),
      ).expand((widget) => [widget, SizedBox(width: 5.w)]).toList(),
    );
  }

  Widget _buildPageIndicatorItem(int index) {
    return Container(
      width: index == _currentPage ? 8.w : 5.w,
      height: index == _currentPage ? 8.h : 5.h,
      margin: const EdgeInsets.symmetric(horizontal: 6).w,
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
              padding: const EdgeInsets.all(12).w,
              child: Column(
                children: [
                  _buildPageIndicator(),
                  SizedBox(height: 12.h),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const About()));
                    },
                    child: Container(
                      height: 40.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20).w,
                        color: tdbrown,
                      ),
                      child: Center(
                        child: Text(
                          S.of(context).aboutOurApp,
                          style: TextStyle(
                            letterSpacing: 1,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    height: 40.h,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignIn()));
                      },
                      child: Text(
                        S.of(context).signIn,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: tdbrown,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20).w,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12).w,
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

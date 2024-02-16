import 'package:flutter/material.dart';
import 'package:learningplatformapp/SignInUp/signin.dart';
import 'pageviewdetails.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PageViewScreen extends StatefulWidget {
  const PageViewScreen({Key? key}) : super(key: key);

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  PageController _controller = PageController();
  int currentPage = 0;

  final List<Color> pageColors = [tdbrown, tdBlue, tdbrown, tdBlue];

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      setState(() {
        currentPage = _controller.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            itemCount: pages.length,
            controller: _controller,
            itemBuilder: (_, i) {
              return Container(
                color: pageColors[i],
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          pages[i].Image,
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.3,
                          fit: BoxFit.fill,
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: pages[i].title,
                                  style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 15,),
                        Text(
                          pages[i].Description,
                          style: const TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget? child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          pages.length,
                              (i) => IconButton(
                            onPressed: () {
                              _controller.animateToPage(i,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                            },
                            icon: SvgPicture.asset(
                              'assets/icon/fast-forward-svgrepo-com.svg',
                              width: 30,
                              height: 50,
                              color: i == currentPage ? Colors.white : Colors.white54,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: pageColors[currentPage], // Set button background color dynamically
                      height: 60,
                      margin: const EdgeInsets.all(40),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>
                          const SignIn()));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                        child: const Text(
                          'GET START',
                          style: TextStyle(color:tdBlue,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

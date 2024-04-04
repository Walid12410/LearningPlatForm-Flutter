import 'package:flutter/material.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/mainpages/HomePage.dart';
import 'package:provider/provider.dart';
import '../provider/provider_data.dart';

class ResultQuiz extends StatefulWidget {
  const ResultQuiz({Key? key, required this.score}) : super(key: key);
  final double score;

  @override
  State<ResultQuiz> createState() => _ResultQuizState();
}

class _ResultQuizState extends State<ResultQuiz> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<AppDataProvider>(context, listen: false);
      int userID = provider.userId;
      provider.getTrainer(userID);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppDataProvider>(context, listen: false);
    var users = provider.users;
    return Scaffold(
      body: widget.score >= 50 ? SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/congrats.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(users[0].picture), // Assuming you have imageUrl in your users object
                  ),
                  const SizedBox(height: 10),
                  Text(
                    users[0].toString(),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Score: ${widget.score.toStringAsFixed(2)}',
                    style:const TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Congratulations!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'You have successfully passed the exam. Well done!',
                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  ElevatedButton.icon(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomePage()));
                    },
                    icon: const Icon(
                      Icons.home,
                      color: Colors.black,
                    ),
                    label: const Text(
                      'Back To HomePage',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: tdbrown,
                      minimumSize: const Size(
                          150, 40),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ) : Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/badluck.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(users[0].picture),
                ),
                const SizedBox(height: 10),
                Text(
                  users[0].toString(),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 10),
                Text(
                  'Score: ${widget.score.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Sorry, you did not pass the exam.',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.replay,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Back To HomePage',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: tdbrown, // Change the background color here
                    minimumSize: const Size(
                        150, 40), // Set the minimum width and height
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:learningplatformapp/Widget/ContainerDetails.dart';
import 'package:learningplatformapp/Widget/TrainerInfo.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/AllClass/trainer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class TrainerPage extends StatefulWidget {
  const TrainerPage({super.key});

  @override
  State<TrainerPage> createState() => _TrainerPageState();
}

class _TrainerPageState extends State<TrainerPage> {
  List<Trainer> trainers = [];
  String Instructor = 'Instructor';

  @override
  void initState() {
    super.initState();
    getTrainer();
  }

  Future<void> getTrainer() async {
    try {
      Uri url = Uri.parse('http://192.168.1.13/EduPlatForm/CMS/api/TrainerCrudOperation.php?operation=SelectAll');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> portalJsonList = jsonDecode(response.body);
        List<Trainer> fetchedPortals = portalJsonList.map((json) => Trainer.fromJson(json)).toList();
        setState(() {
          trainers = fetchedPortals;
        });
      } else {
        throw Exception('Failed to load portals');
      }
    } catch (e) {
      print('Error fetching portals: $e');
      setState(() {
        trainers = [];
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFEC9D52),
                  Color(0xFF004296),
                ],
              ),
            ),
          ),
          Positioned(
            top: 50.0,
            left: 20.0,
            right: 20.0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF004296), Color(0xFFEC9D52)], // Define your gradient colors here
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ContainerDetails(name: 'Instructor', number: trainers.length),
            ),
          ),

          Positioned(
            top: 190,
            left: 20.0,
            right: 20.0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: tdBGColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const TextField(
                cursorColor: tdbrown,
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search,color: tdBlue,),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 250.0),
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                    itemCount: trainers.length ,
                    itemBuilder: (context , i){
                      return TrainerInfo(trainers: trainers[i]);
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



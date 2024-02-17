import 'package:flutter/material.dart';
import 'package:learningplatformapp/Widget/ContainerDetailsPortal_Instructor.dart';
import 'package:learningplatformapp/Widget/TrainerInfo.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/AllClass/trainer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TrainerPage extends StatefulWidget {
  const TrainerPage({Key? key}) : super(key: key);

  @override
  State<TrainerPage> createState() => _TrainerPageState();
}

class _TrainerPageState extends State<TrainerPage> {
  List<Trainer> trainers = [];
  List<Trainer> filteredTrainers = [];

  @override
  void initState() {
    super.initState();
    getTrainer();
  }

  Future<void> getTrainer() async {
    try {
      Uri url = Uri.parse('http://192.168.1.13/EduPlatform/CMS/api/TrainersCrudOperation.php?operation=SelectAll');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> portalJsonList = jsonDecode(response.body);
        List<Trainer> fetchedPortals = portalJsonList.map((json) => Trainer.fromJson(json)).toList();
        setState(() {
          trainers = fetchedPortals;
          filteredTrainers = fetchedPortals;
        });
      } else {
        throw Exception('Failed to load trainer');
      }
    } catch (e) {
      print('Error fetching trainer: $e');
    }
  }

  void filterTrainers(String searchText) {
    setState(() {
      filteredTrainers = trainers.where((trainer) => trainer.fname.toLowerCase().contains(searchText.toLowerCase()) ||
          trainer.lname.toLowerCase().contains(searchText.toLowerCase())).toList();
    });
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
          DetailsForPortal_Instructor(name: 'Instructor', number: trainers.length),
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
              child: TextField(
                cursorColor: tdbrown,
                decoration: const InputDecoration(
                  hintText: 'Search',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search,color: tdBlue,),
                ),
                onChanged: (value){
                  filterTrainers(value);
                },
              ),
            ),
          ),
          if (trainers.isEmpty)
            const Center(
              child: CircularProgressIndicator(),
            )
          else
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
                      itemCount: filteredTrainers.length,
                      itemBuilder: (context , i){
                        final trainer = filteredTrainers[i];
                        return TrainerInfo(trainers: trainer);
                      }),
                ),
              ),
            ),
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:learningplatformapp/Widget/ContainerDetailsPortal_Instructor.dart';
import 'package:learningplatformapp/Widget/TrainerInfo.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/AllClass/trainer.dart';


class TrainerPage extends StatefulWidget {
  const TrainerPage({Key? key}) : super(key: key);

  @override
  State<TrainerPage> createState() => _TrainerPageState();
}

class _TrainerPageState extends State<TrainerPage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchTrainer();
  }

  Future<void> _fetchTrainer() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
    });
    try {
      await getTrainer();
    } catch (e) {
      print(e);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void filterTrainers(String searchText) {
    setState(() {
      filteredTrainers = trainers.where((trainer) =>
      trainer.fname.toLowerCase().contains(searchText.toLowerCase()) ||
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
            top: 180.0,
            left: 20.0,
            right: 20.0,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // Assuming you are inside a BuildContext
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0), // Adjust padding as needed
                    decoration: BoxDecoration(
                      color: Colors.white, // Choose your desired background color
                      borderRadius: BorderRadius.circular(20.0), // Adjust border radius as needed
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: tdBlue, // You can change the color of the icon as needed
                    ),
                  ),
                ),
                const SizedBox(width: 5,),
                Expanded(
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
                        prefixIcon: Icon(Icons.search, color: tdBlue),
                      ),
                      onChanged: (value) {
                        filterTrainers(value);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_isLoading) // Show CircularProgressIndicator if isLoading is true
            const Center(
                child: SizedBox(width: 150, height: 150,
                    child: CircularProgressIndicator(
                      color: tdbrown,
                    ))
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


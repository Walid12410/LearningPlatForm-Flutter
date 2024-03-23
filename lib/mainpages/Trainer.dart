import 'package:flutter/material.dart';
import 'package:learningplatformapp/Widget/TrainerInfo.dart';
import 'package:provider/provider.dart';
import 'package:learningplatformapp/provider/provider_data.dart';

class TrainerPage extends StatefulWidget {
  const TrainerPage({Key? key}) : super(key: key);

  @override
  State<TrainerPage> createState() => _TrainerPageState();
}

class _TrainerPageState extends State<TrainerPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AppDataProvider provider = Provider.of<AppDataProvider>(context, listen: false);
      provider.getAllTrainer();
    });
  }
  @override
  Widget build(BuildContext context) {
    AppDataProvider appDataProvider = Provider.of<AppDataProvider>(context, listen: true);
    var trainers = appDataProvider.trainers;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFEC9D52),
                    Color(0xFF000000),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: const Icon(Icons.arrow_back_ios,
                    color: Colors.black,size: 25,)),
                    const Text('Go Back',style: TextStyle(fontWeight: FontWeight.bold,
                    color: Colors.black,fontSize: 30),)
                  ],
                )
              ],
            ),
            if(trainers.isEmpty)
              const Center(
                child: Text(
                  'No Instructor available',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
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
                        itemCount: trainers.length,
                        itemBuilder: (context , i){
                          return TrainerInfo(trainers: trainers[i]);
                        }),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}


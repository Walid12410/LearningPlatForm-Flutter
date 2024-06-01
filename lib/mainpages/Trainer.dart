import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningplatformapp/Widget/TrainerInfo.dart';
import 'package:provider/provider.dart';
import 'package:learningplatformapp/provider/provider_data.dart';

import '../generated/l10n.dart';

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
      AppDataProvider provider =
          Provider.of<AppDataProvider>(context, listen: false);
      provider.getAllTrainer();
    });
  }

  @override
  Widget build(BuildContext context) {
    AppDataProvider appDataProvider =
        Provider.of<AppDataProvider>(context, listen: true);
    var trainers = appDataProvider.trainers;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                      size: 20.w,
                    )),
                Text(
                  S.of(context).GoBack,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18.sp),
                )
              ],
            ),
            if (trainers.isEmpty)
              Center(
                child: Text(
                  S.of(context).NoTrainerAvailable,
                  style: TextStyle(fontSize: 12.sp, color: Colors.black),
                ),
              )
            else
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(15).w,
                        topRight: const Radius.circular(15).w,
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0).w,
                    child: ListView.builder(
                      itemCount: trainers
                          .where((trainer) => trainer.usertype == 'TR')
                          .length,
                      itemBuilder: (context, i) {
                        final filteredTrainers = trainers
                            .where((trainer) => trainer.usertype == 'TR')
                            .toList();
                        if (filteredTrainers.isEmpty) {
                          return Text(S.of(context).NoTrainerAvailable);
                        } else {
                          return TrainerInfo(trainers: filteredTrainers[i]);
                        }
                      },
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

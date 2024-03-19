import 'package:flutter/material.dart';
import 'package:learningplatformapp/AllClass/trainer.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/futureapi/TrainerApi.dart';
import 'widget/viewprofile.dart';
import 'package:learningplatformapp/provider/provider_data.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Information extends StatefulWidget {
  const Information({Key? key}) : super(key: key);

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  @override
  void initState() {
    super.initState();
    getData(context);
  }

  void getData(BuildContext context) {
    final provider = Provider.of<AppDataProvider>(context, listen: false);
    fetchTrainers(context, provider.userId);
  }

  @override
  Widget build(BuildContext context) {
    AppDataProvider appDataProvider =
        Provider.of<AppDataProvider>(context, listen: true);
    List<Trainer> users = appDataProvider.users;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Profile',
          style: TextStyle(fontWeight: FontWeight.bold, color: tdBlue),
        ),
        centerTitle: true,
        backgroundColor: tdbrown,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: Container(
                      child: users.isNotEmpty? ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: users[0].tpicture,
                          placeholder: (context, url) =>const CircularProgressIndicator(
                            color: tdbrown,
                          ),
                          errorWidget: (context, url, error) => Image.asset('assets/user.png'),
                          fit: BoxFit.cover,
                        ),
                      ):const CircularProgressIndicator(color: tdbrown),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Profileview(title: 'Name', desc: users[0].toString()),
              Profileview(title: 'Email', desc: users[0].email),
              Profileview(title: 'Phone Number', desc: users[0].telephone),
            ],
          ),
        ),
      ),
    );
  }
}

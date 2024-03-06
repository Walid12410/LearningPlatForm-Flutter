import 'package:flutter/material.dart';
import 'package:learningplatformapp/AllClass/trainer.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/futureapi/TrainerApi.dart';
import 'widget/viewprofile.dart';
import 'package:learningplatformapp/provider/provider_data.dart';
import 'package:provider/provider.dart';

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
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: users.isEmpty && users[0].tpicture != null
                            ? Image.network(
                                users[0].tpicture!,
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return const CircularProgressIndicator();
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/user.png',
                                    fit: BoxFit.cover,
                                  );
                                },
                              )
                            : Image.asset(
                                'assets/user.png',
                                fit: BoxFit.cover,
                              ),
                      ),
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

import 'package:flutter/material.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/futureapi/TrainerApi.dart';
import 'package:learningplatformapp/pageroute/LeftToRight.dart';
import 'package:learningplatformapp/userprofiler/information.dart';
import 'package:learningplatformapp/userprofiler/editprofile.dart';
import 'widget/profilemenu.dart';
import 'package:learningplatformapp/AllClass/trainer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:learningplatformapp/SignInUp/signin.dart';
import 'package:learningplatformapp/provider/provider_data.dart';
import 'package:provider/provider.dart';

class ProfileSetting extends StatefulWidget {
  const ProfileSetting({Key? key}) : super(key: key);

  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {

@override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<AppDataProvider>(context, listen: false);
      provider.getTrainer(provider.userId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppDataProvider>(context, listen: false);
    var user = provider.users;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: user != null && user.isNotEmpty
              ? _buildProfile(user[0])
              : const Center(child: Text('Loading profile...')),
        ),
      ),
    );
  }

  Widget _buildProfile(Trainer user) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                    size: 30,
                  )),
              const Text(
                'Setting & Profile',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          const Divider(),
          const SizedBox(
            height: 20,
          ),
          ProfileMenuWidget(
              icon: Icons.language,
              text: 'Language',
              onPressed: () {},
              textColor: tdBlue),
          const SizedBox(height: 10),
          ProfileMenuWidget(
              icon: Icons.person,
              text: 'Information',
              onPressed: () {
                Navigator.push(
                    context, CustomPageRoute(child: const Information()));
              },
              textColor: tdBlue),
          const SizedBox(height: 10),
          ProfileMenuWidget(
              icon: Icons.assignment,
              text: 'My Courses',
              onPressed: () {},
              textColor: tdBlue),
          const SizedBox(height: 10),
          const Divider(),
          ProfileMenuWidget(
              icon: Icons.password,
              text: 'Change Password',
              onPressed: () {},
              endIcon: false,
              textColor: Colors.red),
          const SizedBox(height: 10),
          ProfileMenuWidget(
              icon: Icons.logout_outlined,
              text: 'logout',
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.clear(); // Clear all stored preferences
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const SignIn()),
                  (route) => false,
                );
              },
              endIcon: false,
              textColor: Colors.red)
        ],
      ),
    );
  }
}

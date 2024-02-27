import 'package:flutter/material.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/futureapi/TrainerApi.dart';
import 'package:learningplatformapp/userprofiler/information.dart';
import 'package:learningplatformapp/userprofiler/editprofile.dart';
import 'widget/profilemenu.dart';
import 'package:learningplatformapp/AllClass/trainer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:learningplatformapp/SignInUp/signin.dart';
import 'package:learningplatformapp/provider/provider_data.dart';
import 'package:provider/provider.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<List<Trainer>>? _userFuture;


  void getData(BuildContext context) {
    final provider = Provider.of<AppDataProvider>(context, listen: true);
    _userFuture = fetchTrainers(context, provider.userId);
  }

  @override
  Widget build(BuildContext context) {
    getData(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: tdBlue),
        ),
        centerTitle: true,
        backgroundColor: tdbrown,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<List<Trainer>>(
          future: _userFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return _buildProfile(snapshot.data![0]);
            } else {
              return const Center(child: Text('No user data available'));
            }
          },
        ),
      ),
    );
  }
  Widget _buildProfile(Trainer user) {
    return Container(
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: user.tpicture != null
                      ? Image.network(
                          user.tpicture!,fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const CircularProgressIndicator();
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset('assets/user.png',fit: BoxFit.cover,);
                          },
                        )
                      : Image.asset('assets/user.png',fit: BoxFit.cover,),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            user.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            user.email,
            style: const TextStyle(fontSize: 15),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                 UpdateProfileScreen()));
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: tdbrown,
                  side: BorderSide.none,
                  shape: const StadiumBorder()),
              child: const Text(
                'Edit Profile',
                style: TextStyle(
                    color: tdBlue, fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(),
          const SizedBox(
            height: 20,
          ),
          ProfileMenuWidget(
              icon: Icons.settings,
              text: 'Setting',
              onPressed: () {},
              textColor: tdBlue),
          const SizedBox(height: 10),
          ProfileMenuWidget(
              icon: Icons.person,
              text: 'Information',
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>
                        Information()));
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
          ProfileMenuWidget(icon: Icons.password, text: 'Change Password', onPressed: (){},endIcon: false, textColor: Colors.red),
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

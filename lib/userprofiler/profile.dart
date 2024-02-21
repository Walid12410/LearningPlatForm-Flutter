import 'package:flutter/material.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'widget/profilemenu.dart';
import 'package:learningplatformapp/AllClass/trainer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:learningplatformapp/SignInUp/signin.dart';

class Profile extends StatefulWidget {
  const Profile({required this.id, Key? key}) : super(key: key);

  final int id;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    fetchTrainers(widget.id);
  }

  @override
  Widget build(BuildContext context) {
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
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: users[0].tpicture != null
                          ? Image.network(
                              users[0].tpicture!,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return CircularProgressIndicator();
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset('assets/user.png');
                              },
                            )
                          : Image.asset('assets/user.png'),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                users[0].toString(),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                users[0].email,
                style: const TextStyle(fontSize: 15),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: tdbrown,
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: const Text(
                    'Edit Profile',
                    style: TextStyle(
                        color: tdBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
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
                  onPressed: () {},
                  textColor: tdBlue),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                  icon: Icons.assignment,
                  text: 'My Courses',
                  onPressed: () {},
                  textColor: tdBlue),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                  icon: Icons.logout_outlined,
                  text: 'logout',
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
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
        ),
      ),
    );
  }
}

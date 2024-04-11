import 'package:flutter/material.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/pageroute/LeftToRight.dart';
import 'package:learningplatformapp/userprofiler/widget/profilemenu.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../SignInUp/signin.dart';
import '../provider/provider_data.dart';
import 'editprofile.dart';
import 'information.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<AppDataProvider>(context, listen: false);
      int userID = provider.userId;
      provider.getTrainer(userID);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppDataProvider>(context, listen: false);
    var users = provider.users;

    return Scaffold(
      body: users.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
              color: tdbrown,
            ))
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Text(
                          'Setting & Profile',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const Divider(
                      color: Colors.black,
                      thickness: 3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: users[0].picture == ''
                                  ? Image.asset(
                                      'assets/user.png',
                                      fit: BoxFit.cover,
                                    )
                                  : CachedNetworkImage(
                                      imageUrl: users[0].picture,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(
                                              color: tdbrown),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                        'assets/user.png',
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      users[0].toString(),
                      style: const TextStyle(fontSize: 15),
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
                        onPressed: () {
                          Navigator.push(
                              context,
                              CustomPageRoute(
                                  child: const UpdateProfileScreen()));
                        },
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
                    const SizedBox(height: 10),
                    Column(
                      children: [
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
                              Navigator.push(context,
                                  CustomPageRoute(child: const Information()));
                            },
                            textColor: tdBlue),
                        const SizedBox(height: 10),
                        ProfileMenuWidget(
                            icon: Icons.assignment,
                            text: 'My Courses',
                            onPressed: () {},
                            textColor: tdBlue),
                        const SizedBox(height: 10),
                        const Divider(
                          color: Colors.black,
                          thickness: 3,
                        ),
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
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs
                                  .clear(); // Clear all stored preferences
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignIn()),
                                (route) => false,
                              );
                            },
                            endIcon: false,
                            textColor: Colors.red)
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

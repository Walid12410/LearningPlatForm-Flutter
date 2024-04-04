import 'package:flutter/material.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/pageroute/LeftToRight.dart';
import 'package:learningplatformapp/userprofiler/profile&setting.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../provider/provider_data.dart';
import 'editprofile.dart';

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
              child: CircularProgressIndicator(color: tdbrown,)
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            users[0].toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.black),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    CustomPageRoute(
                                        child: const ProfileSetting()));
                              },
                              icon: const Icon(
                                Icons.menu,
                                color: Colors.black,
                                size: 30,
                              ))
                        ],
                      ),
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                         Padding(
                           padding: EdgeInsets.only(left: 6),
                           child: Text(
                            'About Me',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                                                   ),
                         ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15,right: 12),
                      child: Text(
                        users[0].description,
                        style: const TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

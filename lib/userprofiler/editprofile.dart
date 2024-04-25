import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/futureapi/TrainerApi.dart';
import 'package:learningplatformapp/mainpages/HomePage.dart';
import 'package:learningplatformapp/provider/provider_data.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../generated/l10n.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  late TextEditingController fnameController;
  late TextEditingController lnameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late int userid = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final provider = Provider.of<AppDataProvider>(context, listen: false);
    userid = provider.userId;
    final users = provider.users;
    await fetchTrainers(userid);
    setState(() {
      fnameController = TextEditingController(
          text: users.isNotEmpty ? users[0].firstname : '');
      lnameController = TextEditingController(
          text: users.isNotEmpty ? users[0].lastname : '');
      emailController =
          TextEditingController(text: users.isNotEmpty ? users[0].email : '');
      phoneController = TextEditingController(
          text: users.isNotEmpty ? users[0].telephone : '');
      _isLoading = false;
    });
  }

  Future<void> updateProfile() async {
    final url = Uri.parse(
        'http://192.168.1.5/api/walid/userapi.php?status=UpdateProfile');
    final response = await http.post(
      url,
      body: {
        "UserID": userid.toString(),
        "FName": fnameController.text,
        "LName": lnameController.text,
        "Email": emailController.text,
        "Phone": phoneController.text,
      },
    );
    if (response.statusCode == 200) {
      showUpdateSuccessMessage(context);
    } else {
      // Handle error
    }
  }

  void showUpdateSuccessMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).Success),
        content: Text(S.of(context).ProfileUpdateS),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
                (route) => false,
              );
            },
            child: Text(
              S.of(context).OK,
              style: const TextStyle(color: tdBlue),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppDataProvider>(context, listen: true);
    final users = provider.users;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: tdBlue,
            size: 25,
          ),
        ),
        title: Text(
          S.of(context).EditProfile,
          style: const TextStyle(fontSize: 25, color: tdBlue),
        ),
        backgroundColor: tdbrown,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(shrinkWrap: true, children: [
              Container(
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Stack(
                      children: [
                        SizedBox(
                            width: 120,
                            height: 120,
                            child: users[0].picture == ''
                                ? ClipOval(
                                    child: Image.asset('assets/user.png',
                                        fit: BoxFit.fill),
                                  )
                                : ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl: users[0].picture,
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(
                                        color: tdbrown,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                        'assets/user.png',
                                        fit: BoxFit.cover,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: tdBlue,
                            ),
                            child: const Icon(Icons.account_circle,
                                color: Colors.white, size: 20),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    Form(
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: S.of(context).FirstName,
                              labelStyle: const TextStyle(color: tdBlue),
                              prefixIcon: const Icon(Icons.account_circle),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: const BorderSide(color: tdBlue),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: const BorderSide(color: tdBlue),
                              ),
                            ),
                            controller: fnameController,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: S.of(context).LastName,
                              labelStyle: const TextStyle(color: tdBlue),
                              prefixIcon: const Icon(Icons.account_circle),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: const BorderSide(color: tdBlue),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: const BorderSide(color: tdBlue),
                              ),
                            ),
                            controller: lnameController,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: S.of(context).emailAddress,
                              labelStyle: const TextStyle(color: tdBlue),
                              prefixIcon: const Icon(Icons.email),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: const BorderSide(color: tdBlue),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: const BorderSide(color: tdBlue),
                              ),
                            ),
                            controller: emailController,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: S.of(context).Telephone,
                              labelStyle: const TextStyle(color: tdBlue),
                              prefixIcon: const Icon(Icons.phone),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: const BorderSide(color: tdBlue),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: const BorderSide(color: tdBlue),
                              ),
                            ),
                            controller: phoneController,
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                updateProfile();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: tdbrown,
                                side: BorderSide.none,
                                shape: const StadiumBorder(),
                              ),
                              child: Text(
                                S.of(context).SaveEdit,
                                style: const TextStyle(
                                    color: tdBlue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]),
    );
  }
}

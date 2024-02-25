import 'package:flutter/material.dart';
import 'package:learningplatformapp/AllClass/trainer.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:http/http.dart' as http;
import 'package:learningplatformapp/mainpages/HomePage.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({required this.id, super.key});
  final int id;

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController fnameController =
      TextEditingController(text: users[0].fname);
  TextEditingController lnameController =
      TextEditingController(text: users[0].lname);
  TextEditingController emailController =
      TextEditingController(text: users[0].email);
  TextEditingController phoneController =
      TextEditingController(text: users[0].telephone);

  Future<void> updateProfile() async {
    final url = Uri.parse(
        'http://192.168.1.5/EduPlatform/CMS/api/TrainersCrudOperation.php?operation=UpdateProfile');
    final response = await http.post(
      url,
      body: {
        "UserID": widget.id.toString(),
        "UserFirstName": fnameController.text,
        "UserLastName": lnameController.text,
        "UserEmail": emailController.text,
        "UserTelephone": phoneController.text,
      },
    );

    if (response.statusCode == 200) {
      showUpdateSuccessMessage(context);
    } else {}
  }

  void showUpdateSuccessMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: const Text('Profile updated successfully'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage(
                        uid: widget
                            .id)), // Replace HomePage() with your actual homepage widget
                (route) => false, // Pop until the homepage is at the top
              );
            },
            child: const Text(
              'OK',
              style: TextStyle(color: tdBlue),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    fetchTrainers(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: tdBlue,
              size: 40,
            )),
        title: const Text('Edit Profile',
            style: TextStyle(fontSize: 35, color: tdBlue)),
        backgroundColor: tdbrown,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          '${users[0].tpicture}',
                          fit: BoxFit.cover,
                        )),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: tdBlue),
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
                        labelText: 'First Name',
                        labelStyle: const TextStyle(
                            color: tdBlue), // Change label color here
                        prefixIcon: const Icon(Icons.account_circle),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(
                              color: tdBlue), // Initial border color
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(
                              color: tdBlue), // Border color when focused
                        ),
                      ),
                      controller: fnameController,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                        labelStyle: const TextStyle(
                            color: tdBlue), // Change label color here
                        prefixIcon: const Icon(Icons.account_circle),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(
                              color: tdBlue), // Initial border color
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(
                              color: tdBlue), // Border color when focused
                        ),
                      ),
                      controller: lnameController,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: const TextStyle(
                            color: tdBlue), // Change label color here
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(
                              color: tdBlue), // Initial border color
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(
                              color: tdBlue), // Border color when focused
                        ),
                      ),
                      controller: emailController,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: const TextStyle(
                            color: tdBlue), // Change label color here
                        prefixIcon: const Icon(Icons.phone),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(
                              color: tdBlue), // Initial border color
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(
                              color: tdBlue), // Border color when focused
                        ),
                      ),
                      controller: phoneController,
                      //initialValue: users[0].telephone,
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
                            shape: const StadiumBorder()),
                        child: const Text('Save Edit',
                            style: TextStyle(
                                color: tdBlue,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

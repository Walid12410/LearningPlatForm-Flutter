import 'package:flutter/material.dart';
import 'package:learningplatformapp/AllClass/trainer.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'widget/viewprofile.dart';

class Information extends StatefulWidget {
  const Information({required this.id, super.key});
  final int id;

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
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
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          child: users[0].tpicture != null
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
                Profileview(title: 'Name', desc: users[0].toString(),id: widget.id),
                Profileview(title: 'Email', desc: users[0].email,id: widget.id),
                Profileview(title: 'Phone Number', desc: users[0].telephone,id: widget.id),
              ],
            ),
          ),
        ));
  }
}

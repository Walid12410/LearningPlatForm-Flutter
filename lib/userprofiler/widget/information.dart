import 'package:flutter/material.dart';
import 'package:learningplatformapp/AllClass/trainer.dart';
import 'package:learningplatformapp/colors/color.dart';

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
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5), color: tdbrown),
                  child: ListTile(
                    title: Text(
                      '${users[0].toString()}',
                      style:
                      const TextStyle(color: tdBlue, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${users[0].email}',
                      style: const TextStyle(color: tdBlue),
                    ),
                    trailing: Text(
                      '\$${users[0].email}',
                      style: const TextStyle(fontSize: 15, color: tdBlue),
                    ),
                    onTap: () {
                    },
                  )),
            )
              ],
            ),
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:learningplatformapp/colors/color.dart';

class ContainerDetails extends StatelessWidget {
   const ContainerDetails({
    super.key,
    required this.name,
    required this.number,
  });

  final String name;
  final int number ;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.work,
              size: 130,
              color: tdbrown,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('Learning PlatForm App',style: TextStyle(
                    fontSize: 20,fontWeight: FontWeight.bold,color: tdBlue
                ),),
                Text('Available ${name}',
                  style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,
                      color: tdBlue),),
                Text('${number} ${name}',
                  style: const TextStyle(fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: tdBlue),)
              ],
            )
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/SearchCourse/Searchpage.dart';
import 'package:learningplatformapp/pageroute/BottomAndMore.dart';

import '../../generated/l10n.dart';


class SearchTextField extends StatelessWidget {
  const SearchTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          CustomPageRoute2(child: SearchPage()
          ),
        );
      },
      child: Container(
        height: 50,
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: tdbrown, // Use your desired color here
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: tdBlue), // Use your desired color here
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                S.of(context).Search,
                style: const TextStyle(color: tdBlue), // Use your desired color here
              ),
            ),
          ],
        ),
      ),
    );
  }
}

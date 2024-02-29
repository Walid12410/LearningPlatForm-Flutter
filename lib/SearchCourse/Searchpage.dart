import 'package:flutter/material.dart';
import 'package:learningplatformapp/colors/color.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _textFieldController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: tdbrown,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    focusNode: _focusNode,
                    controller: _textFieldController,
                    cursorColor: tdBlue,
                    decoration:const InputDecoration(
                      hintText: 'Search',
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search, color: tdBlue),
                    ),
                    style:const TextStyle(color: tdBlue),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child:const Icon(
                Icons.display_settings,
                size: 50,
                color: tdbrown,
              ),
            )
          ],
        ),
      ),
    );
  }
}


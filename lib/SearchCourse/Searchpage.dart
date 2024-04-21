import 'package:flutter/material.dart';
import 'package:learningplatformapp/CouseDetails/details.dart';
import 'package:learningplatformapp/pageroute/LeftToRight.dart';
import 'package:provider/provider.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/provider/provider_data.dart';
import 'package:learningplatformapp/AllClass/course.dart';
import 'package:intl/intl.dart';
import '../generated/l10n.dart';
import 'Filter_Page.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _textFieldController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  List<Course> allCourses = [];
  List<Course> filteredCourses = [];
  String selectedCategory = '';
  double minPrice = 0.0;
  double maxPrice = 5000.0;

  bool isArabic() {
    return Intl.getCurrentLocale() == 'ar';
  }

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<AppDataProvider>(context, listen: false);
      await provider.getAllCourse();
      setState(() {
        allCourses = provider.allCourses;
        filteredCourses = allCourses;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void filterCourses(String query) {
    setState(() {
      filteredCourses = allCourses
          .where((course) =>
      course.title.toLowerCase().contains(query.toLowerCase()) &&
          (selectedCategory.isEmpty || course.portalID.toString() == selectedCategory) &&
          course.price >= minPrice &&
          course.price <= maxPrice)
          .toList();
    });
  }

  void _showPriceDialog(BuildContext context) async {
    final filteredList = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FilterPage(
          allCourses: allCourses,
          onFilterApplied: (filteredCourses) {
            setState(() {
              allCourses = filteredCourses;
              filteredCourses = filteredCourses;
            });
            filterCourses(_textFieldController.text);
          },
        ),
      ),
    );
    if (filteredList != null) {
      setState(() {
        filteredCourses = filteredList;
      });
    }
    setState(() {
      allCourses = Provider.of<AppDataProvider>(context, listen: false).allCourses;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: tdbrown,
                      )),
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: tdbrown,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        focusNode: _focusNode,
                        controller: _textFieldController,
                        cursorColor: tdBlue,
                        onChanged:
                            filterCourses, // Apply search filter on change
                        decoration: InputDecoration(
                          hintText: S.of(context).Search,
                          border: InputBorder.none,
                          prefixIcon: const Icon(Icons.search, color: tdBlue),
                        ),
                        style: const TextStyle(color: tdBlue),
                      ),
                    ),
                  ),
                  IconButton(
                      icon: const Icon(Icons.filter_list, color: tdbrown),
                      onPressed: () {
                        _showPriceDialog(context);
                      }),
                ],
              ),
            ),
            Expanded(
              child: filteredCourses.isEmpty
                  ? Center(child: Text(S.of(context).CourseNotFound))
                  : ListView.builder(
                      itemCount: filteredCourses.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: tdbrown),
                              child: ListTile(
                                title: Text(
                                  filteredCourses[index].title,
                                  style: const TextStyle(
                                      color: tdBlue,
                                      fontWeight: FontWeight.bold),
                                ),
                                trailing: Text(
                                  '\$${filteredCourses[index].price}',
                                  style: const TextStyle(
                                      fontSize: 15, color: tdBlue),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      CustomPageRoute(
                                          child: CourseDetails(
                                        courseid: filteredCourses[index].id,
                                      )));
                                },
                              )),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

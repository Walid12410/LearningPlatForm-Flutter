import 'package:flutter/material.dart';
import 'package:learningplatformapp/CouseDetails/details.dart';
import 'package:learningplatformapp/pageroute/LeftToRight.dart';
import 'package:provider/provider.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/provider/provider_data.dart';
import 'package:learningplatformapp/AllClass/course.dart';
import 'package:learningplatformapp/AllClass/portal.dart';

import '../generated/l10n.dart';

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

  void filterCourses(String query, String selectedCategory) {
    setState(() {
      filteredCourses = allCourses
          .where((course) =>
              course.title.toLowerCase().contains(query.toLowerCase()) &&
              (selectedCategory.isEmpty ||
                  course.portalID.toString() == selectedCategory))
          .toList();
    });
  }

  Future<void> _showPriceDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Consumer<AppDataProvider>(
          builder: (context, appDataProvider, _) {
            List<Portal>? portals = appDataProvider.portals;
            if (portals == null || portals.isEmpty) {
              return AlertDialog(
                title: Text(S.of(context).NoCategoriesAvailable),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(S.of(context).OK),
                  ),
                ],
              );
            }
            Set<String> uniqueValues = {};
            return AlertDialog(
              title: Text(
                S.of(context).QuickFilter,
                style: const TextStyle(
                    color: tdbrown, fontWeight: FontWeight.bold),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: tdBlue,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: tdBlue,
                          width: 1,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                    ),
                    value: selectedCategory,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCategory =
                            newValue ?? ''; // Ensure newValue is not null
                      });
                    },
                    items: [
                      DropdownMenuItem<String>(
                        value: '',
                        child: Text(S.of(context).AllCategoriesSelected),
                      ),
                      ...portals
                          .map<DropdownMenuItem<String>>((Portal portal) {
                            if (!uniqueValues
                                .contains(portal.portalID.toString())) {
                              uniqueValues.add(portal.portalID.toString());
                              return DropdownMenuItem<String>(
                                value: portal.portalID.toString(),
                                child: Text(portal.portalName),
                              );
                            } else {
                              return const DropdownMenuItem<String>(
                                  value: '', child: SizedBox.shrink());
                            }
                          })
                          .whereType<DropdownMenuItem<String>>()
                          .toList(), // Filter out null values
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: TextField(
                            controller: TextEditingController(
                                text: minPrice.toString()),
                            onChanged: (value) {
                              setState(() {
                                minPrice = double.tryParse(value) ?? 0.0;
                              });
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: S.of(context).MinimumPrice,
                              labelStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: tdBlue,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: tdBlue,
                                  width: 1,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextField(
                            controller: TextEditingController(
                                text: maxPrice.toString()),
                            onChanged: (value) {
                              setState(() {
                                maxPrice = double.tryParse(value) ?? 5000.0;
                              });
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: S.of(context).MaximumPrice,
                              labelStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: tdBlue,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: tdBlue,
                                  width: 1,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(S.of(context).Cancel, style:const TextStyle(color: tdBlue)),
                ),
                TextButton(
                  onPressed: () {
                    // Apply filter logic
                    setState(() {
                      filteredCourses = allCourses.where((course) {
                        if (minPrice != null && course.price < minPrice!) {
                          return false;
                        }
                        if (maxPrice != null && course.price > maxPrice!) {
                          return false;
                        }
                        if (selectedCategory.isNotEmpty &&
                            course.portalID.toString() != selectedCategory) {
                          return false;
                        }
                        return true;
                      }).toList();
                    });

                    // Close the dialog
                    Navigator.pop(context);
                  },
                  child:Text(
                    S.of(context).Done,
                    style: const TextStyle(color: tdBlue),
                  ),
                )
              ],
            );
          },
        );
      },
    );
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
                      onPressed: () {
                        Navigator.pop(context);
                      },
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
                        onChanged: (query) {
                          filterCourses(query, selectedCategory);
                        },
                        decoration:  InputDecoration(
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
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: filteredCourses.isEmpty
                  ?  Center(child: Text(S.of(context).CourseNotFound))
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
                                subtitle: Text(
                                  filteredCourses[index].description,
                                  style: const TextStyle(color: tdBlue),
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

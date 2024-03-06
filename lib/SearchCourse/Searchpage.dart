import 'package:flutter/material.dart';
import 'package:learningplatformapp/futureapi/CourseApi.dart';
import 'package:provider/provider.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/provider/provider_data.dart';
import 'package:learningplatformapp/AllClass/course.dart';
import 'package:learningplatformapp/AllClass/portal.dart';

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
    getAllCourses(context).then((_) {
      setState(() {
        allCourses =
            Provider.of<AppDataProvider>(context, listen: false).allCourses;
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
              course.name.toLowerCase().contains(query.toLowerCase()) &&
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
                title: const Text('No Category found'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            }
            Set<String> uniqueValues = {};
            return AlertDialog(
              title: const Text(
                'Quick Filters',
                style: TextStyle(color: tdbrown, fontWeight: FontWeight.bold),
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
                        selectedCategory = newValue ?? ''; // Ensure newValue is not null
                      });
                    },
                    items: [
                      const DropdownMenuItem<String>(
                        value: '',
                        child: Text('All Category Selected'),
                      ),
                      ...portals.map<DropdownMenuItem<String>>((Portal portal) {
                        if (!uniqueValues.contains(portal.portalID.toString())) {
                          uniqueValues.add(portal.portalID.toString());
                          return DropdownMenuItem<String>(
                            value: portal.portalID.toString(),
                            child: Text(portal.portalName),
                          );
                        } else {
                          return const DropdownMenuItem<String>(value: '', child: SizedBox.shrink());
                        }
                      }).whereType<DropdownMenuItem<String>>().toList(), // Filter out null values
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: TextField(
                            controller: TextEditingController(text: minPrice.toString()),
                            onChanged: (value) {
                              setState(() {
                                minPrice = double.tryParse(value) ?? 0.0;
                              });
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Minimum Price',
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
                            controller: TextEditingController(text: maxPrice.toString()),
                            onChanged: (value) {
                              setState(() {
                                maxPrice = double.tryParse(value) ?? 5000.0;
                              });
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Maximum Price',
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
                  child: const Text('Cancel',style: TextStyle(color: tdBlue)),
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
                  child: const Text('Done',style: TextStyle(color: tdBlue),),
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
                children: [
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
                        decoration: const InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search, color: tdBlue),
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
                  ? const Center(child: Text('Course not found'))
                  : ListView.builder(
                      itemCount: filteredCourses.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5), color: tdbrown),
                              child: ListTile(
                                title: Text(
                                  filteredCourses[index].name,
                                  style:
                                  const TextStyle(color: tdBlue, fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  filteredCourses[index].description,
                                  style: const TextStyle(color: tdBlue),
                                ),
                                trailing: Text(
                                  '\$${filteredCourses[index].price}',
                                  style: const TextStyle(fontSize: 15, color: tdBlue),
                                ),
                                onTap: () {
                                },
                              )
                          ),
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

import 'package:flutter/material.dart';
import 'package:learningplatformapp/AllClass/course.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../AllClass/portal.dart';
import '../colors/color.dart';
import '../generated/l10n.dart';
import '../provider/provider_data.dart';

class FilterPage extends StatefulWidget {
  final List<Course> allCourses;
  final Function(List<Course>) onFilterApplied;

  const FilterPage({
    Key? key,
    required this.allCourses,
    required this.onFilterApplied,
  }) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  String selectedCategory = '';
  double minPrice = 0.0;
  double maxPrice = 5000.0;
  late List<Course> filteredCourses;

  @override
  void initState() {
    super.initState();
    filteredCourses = widget.allCourses;
  }

  bool isArabic() {
    return Intl.getCurrentLocale() == 'ar';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).QuickFilter,
          style:const  TextStyle(color: tdbrown, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: tdbrown),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Consumer<AppDataProvider>(
            builder: (context, appDataProvider, _) {
              List<Portal>? portals = appDataProvider.portals;
              if (portals == null || portals.isEmpty) {
                return Center(
                  child: Text(S.of(context).NoCategoriesAvailable),
                );
              }
              Set<String> uniqueValues = {};
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      S.of(context).AllCategories,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: tdBlue,
                      ),
                    ),
                    const SizedBox(height: 10),
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
                          borderSide:const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                      value: selectedCategory,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCategory = newValue ?? ''; // Handle null case
                        });
                      },
                      items: [
                        DropdownMenuItem<String>(
                          value: '',
                          child: Text(S.of(context).AllCategoriesSelected),
                        ),
                        ...portals
                            .map<DropdownMenuItem<String>>((Portal portal) {
                          if (!uniqueValues.contains(portal.portalID.toString())) {
                            uniqueValues.add(portal.portalID.toString());
                            return DropdownMenuItem<String>(
                              value: portal.portalID.toString(),
                              child: Text(
                                portal.portalName,
                                style: const TextStyle(overflow: TextOverflow.ellipsis),
                              ),
                            );
                          } else {
                            return const DropdownMenuItem<String>(
                              value: '',
                              child: SizedBox.shrink(),
                            );
                          }
                        }).whereType<DropdownMenuItem<String>>().toList(),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: isArabic()
                                ? const EdgeInsets.only(left: 8.0)
                                : const EdgeInsets.only(right: 8.0),
                            child:TextField(
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
                            padding: isArabic()
                                ? const EdgeInsets.only(right: 8.0)
                                : const EdgeInsets.only(left: 8.0),
                            child: TextField(
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
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(
                                color: tdbrown,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Center(
                              child: Text(
                                S.of(context).Cancel,
                                style:const TextStyle(color: Colors.white),
                              ),
                            ),

                          ),
                        ),
                        const SizedBox(width: 20),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              filteredCourses = widget.allCourses.where((course) {
                                if (minPrice != null && course.price < minPrice) {
                                  return false;
                                }
                                if (maxPrice != null && course.price > maxPrice) {
                                  return false;
                                }
                                if (selectedCategory.isNotEmpty &&
                                    course.portalID.toString() != selectedCategory) {
                                  return false;
                                }
                                return true;
                              }).toList();
                            });
                            widget.onFilterApplied(filteredCourses);
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(
                              color: tdbrown,
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Center(
                              child: Text(
                                S.of(context).Done,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

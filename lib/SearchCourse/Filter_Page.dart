import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          style: TextStyle(color: tdbrown, fontWeight: FontWeight.bold,fontSize: 15.sp),
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
                  child: Text(S.of(context).NoCategoriesAvailable,style: TextStyle(fontSize: 12.sp),),
                );
              }
              Set<String> uniqueValues = {};
              return Padding(
                padding: const EdgeInsets.all(12.0).w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      S.of(context).AllCategories,
                      style:  TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                        color: tdBlue,
                      ),
                    ),
                     SizedBox(height: 5.h),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelStyle:  TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10.sp,
                          color: tdBlue,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15).w,
                          borderSide:  BorderSide(
                            color: tdBlue,
                            width: 1.w,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15).w,
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.w,
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
                          child: Text(S.of(context).AllCategoriesSelected,style: TextStyle(fontSize: 12.sp),),
                        ),
                        ...portals
                            .map<DropdownMenuItem<String>>((Portal portal) {
                          if (!uniqueValues.contains(portal.portalID.toString())) {
                            uniqueValues.add(portal.portalID.toString());
                            return DropdownMenuItem<String>(
                              value: portal.portalID.toString(),
                              child: Text(
                                portal.portalName,
                                style:  TextStyle(overflow: TextOverflow.ellipsis,fontSize: 12.sp),
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
                                ? const EdgeInsets.only(left: 8.0).w
                                : const EdgeInsets.only(right: 8.0).w,
                            child:TextField(
                              onChanged: (value) {
                                setState(() {
                                  minPrice = double.tryParse(value) ?? 0.0;
                                });
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: S.of(context).MinimumPrice,
                                labelStyle:  TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.sp,
                                  color: tdBlue,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15).w,
                                  borderSide:  BorderSide(
                                    color: tdBlue,
                                    width: 1.w,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15).w,
                                  borderSide:  BorderSide(
                                    color: Colors.grey,
                                    width: 1.w,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: isArabic()
                                ? const EdgeInsets.only(right: 8.0).w
                                : const EdgeInsets.only(left: 8.0).w,
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  maxPrice = double.tryParse(value) ?? 5000.0;
                                });
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: S.of(context).MaximumPrice,
                                labelStyle:  TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.sp,
                                  color: tdBlue,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15).w,
                                  borderSide:  BorderSide(
                                    color: tdBlue,
                                    width: 1.w,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15).w,
                                  borderSide:  BorderSide(
                                    color: Colors.grey,
                                    width: 1.w,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                     SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 120.w,
                            height: 35.h,
                            decoration: BoxDecoration(
                                color: tdbrown,
                                borderRadius: BorderRadius.circular(20).w
                            ),
                            child: Center(
                              child: Text(
                                S.of(context).Cancel,
                                style: TextStyle(color: Colors.white,fontSize: 12.sp),
                              ),
                            ),

                          ),
                        ),
                         SizedBox(width: 10.w),
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
                            width: 120.w,
                            height: 35.h,
                            decoration: BoxDecoration(
                              color: tdbrown,
                              borderRadius: BorderRadius.circular(20).w
                            ),
                            child: Center(
                              child: Text(
                                S.of(context).Done,
                                style:  TextStyle(color: Colors.white,fontSize: 12.sp),
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

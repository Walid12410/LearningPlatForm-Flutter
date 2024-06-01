import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningplatformapp/UserCourses/FavoriteCourse.dart';
import 'package:learningplatformapp/UserCourses/MyCoures.dart';
import 'package:learningplatformapp/UserCourses/Widgets/listTile.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:provider/provider.dart';
import '../generated/l10n.dart';
import '../provider/provider_data.dart';

class UserCoursePage extends StatefulWidget {
  const UserCoursePage({super.key});

  @override
  State<UserCoursePage> createState() => _UserCoursePageState();
}

class _UserCoursePageState extends State<UserCoursePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<AppDataProvider>(context, listen: false);
      int userID = provider.userId;
      provider.getTrainer(userID);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppDataProvider>(context, listen: false);
    var users = provider.users;
    return Scaffold(
      body: users.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
                color: tdbrown,
              ),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                     SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 90.w,
                          height: 80.h,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100).w,
                              child: users[0].picture == ''
                                  ? Image.asset(
                                      'assets/user.png',
                                      fit: BoxFit.cover,
                                    )
                                  : CachedNetworkImage(
                                      imageUrl: users[0].picture,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          Image.asset('assets/gif-unscreen.gif',
                                            fit: BoxFit.cover,),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                        'assets/user.png',
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                        )
                      ],
                    ),
                     SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      users[0].toString(),
                      style:  TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      users[0].title,
                      style:  TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                     SizedBox(
                      height: 5.h,
                    ),
                    Column(
                      children: [
                        TileList(
                          name: S.of(context).YourCourse,
                          press: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const UserCourse()));
                          },
                          requiredIcon: Icons.school_outlined,
                        ),
                        TileList(
                          name: S.of(context).YourFavoriteCourse,
                          press: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const UserFavorite()));
                          },
                          requiredIcon: Icons.bookmark,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

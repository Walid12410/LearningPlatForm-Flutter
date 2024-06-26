import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningplatformapp/UserCourses/MyCoures.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/pageroute/LeftToRight.dart';
import 'package:learningplatformapp/userprofiler/Language.dart';
import 'package:learningplatformapp/userprofiler/widget/profilemenu.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../SignInUp/signin.dart';
import '../generated/l10n.dart';
import '../provider/provider_data.dart';
import 'editprofile.dart';
import 'information.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<AppDataProvider>(context, listen: false);
      int userID = provider.userId;
      provider.getTrainer(userID);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppDataProvider>(context, listen: true);
    var users = provider.users;

    return Scaffold(
      body: users.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
              color: tdbrown,
            ))
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0).w,
                      child: Row(
                        children: [
                          Text(
                            S.of(context).settingProfile,
                            style:  TextStyle(
                                fontSize: 18.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 90.w,
                          height: 80.h,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
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
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      users[0].toString(),
                      style:  TextStyle(fontSize: 12.sp),
                    ),
                    Text(
                      users[0].email,
                      style:  TextStyle(fontSize: 12.sp),
                    ),
                     SizedBox(
                      height: 5.h,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              CustomPageRoute(
                                  child: const UpdateProfileScreen()));
                        },
                        child: Container(
                          width: 180.w,
                          height: 25.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(100).w,
                            color: tdbrown
                          ),
                          child: Center(
                            child: Text(
                              S.of(context).EditProfile,
                              style:  TextStyle(
                                  color: tdBlue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp),
                            ),
                          ),

                        )
                      ),
                    SizedBox(height: 10.h,),
                    Column(
                      children: [
                         SizedBox(height: 5.h,),
                        ProfileMenuWidget(
                            icon: Icons.language,
                            text: S.of(context).Language,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Language()));
                            },
                            textColor: tdBlue),
                        SizedBox(height: 5.h,),
                        ProfileMenuWidget(
                            icon: Icons.person,
                            text: S.of(context).information,
                            onPressed: () {
                              Navigator.push(context,
                                  CustomPageRoute(child: const Information()));
                            },
                            textColor: tdBlue),
                         SizedBox(height: 5.h),
                        ProfileMenuWidget(
                            icon: Icons.assignment,
                            text: S.of(context).MyCourse,
                            onPressed: () {
                              Navigator.push(context,
                                  CustomPageRoute(child: const UserCourse()));
                            },
                            textColor: tdBlue),
                        SizedBox(height: 5.h),
                        const Divider(
                          color: Colors.black,
                          thickness: 3,
                        ),
                        ProfileMenuWidget(
                            icon: Icons.password,
                            text: S.of(context).ChangePassword,
                            onPressed: () {},
                            endIcon: false,
                            textColor: Colors.red),
                        SizedBox(height: 5.h),
                        ProfileMenuWidget(
                            icon: Icons.logout_outlined,
                            text: S.of(context).LogOut,
                            onPressed: () async {
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              await prefs.remove('isLoggedIn');
                              await prefs.remove('username');
                              await prefs.remove('uid');
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignIn()),
                                (route) => false,
                              );
                            },
                            endIcon: false,
                            textColor: Colors.red)
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

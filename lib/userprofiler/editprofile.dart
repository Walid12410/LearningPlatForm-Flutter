import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/futureapi/TrainerApi.dart';
import 'package:learningplatformapp/mainpages/HomePage.dart';
import 'package:learningplatformapp/provider/provider_data.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../generated/l10n.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  late TextEditingController fnameController;
  late TextEditingController lnameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late int userid = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final provider = Provider.of<AppDataProvider>(context, listen: false);
    userid = provider.userId;
    final users = provider.users;
    await fetchTrainers(userid);
    setState(() {
      fnameController = TextEditingController(
          text: users.isNotEmpty ? users[0].firstname : '');
      lnameController = TextEditingController(
          text: users.isNotEmpty ? users[0].lastname : '');
      emailController =
          TextEditingController(text: users.isNotEmpty ? users[0].email : '');
      phoneController = TextEditingController(
          text: users.isNotEmpty ? users[0].telephone : '');
      _isLoading = false;
    });
  }

  Future<void> updateProfile() async {
    final url = Uri.parse(
        'http://192.168.1.5/api/walid/userapi.php?status=UpdateProfile');
    final response = await http.post(
      url,
      body: {
        "UserID": userid.toString(),
        "FName": fnameController.text,
        "LName": lnameController.text,
        "Email": emailController.text,
        "Phone": phoneController.text,
      },
    );
    if (response.statusCode == 200) {
      showUpdateSuccessMessage(context);
    } else {
      // Handle error
    }
  }

  void showUpdateSuccessMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).Success,style: TextStyle(fontSize: 12.sp),),
        content: Text(S.of(context).ProfileUpdateS,style: TextStyle(fontSize: 12.sp),),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
                (route) => false,
              );
            },
            child: Text(
              S.of(context).OK,
              style: const TextStyle(color: tdBlue),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppDataProvider>(context, listen: true);
    final users = provider.users;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon:  Icon(
            Icons.arrow_back,
            color: tdBlue,
            size: 20.w,
          ),
        ),
        title: Text(
          S.of(context).EditProfile,
          style:  TextStyle(fontSize: 15.sp, color: tdBlue),
        ),
        backgroundColor: tdbrown,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(shrinkWrap: true, children: [
              Container(
                padding: const EdgeInsets.all(5).w,
                child: Column(
                  children: [
                     SizedBox(height: 5.h),
                    Stack(
                      children: [
                        SizedBox(
                            width: 100.w,
                            height: 85.h,
                            child: users[0].picture == ''
                                ? ClipOval(
                                    child: Image.asset('assets/user.png',
                                        fit: BoxFit.fill),
                                  )
                                : ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl: users[0].picture,
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(
                                        color: tdbrown,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                        'assets/user.png',
                                        fit: BoxFit.cover,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 27.w,
                            height: 24.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100).w,
                              color: tdBlue,
                            ),
                            child:  Icon(Icons.account_circle,
                                color: Colors.white, size: 20.w),
                          ),
                        ),
                      ],
                    ),
                     SizedBox(height: 25.h),
                    Form(
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: S.of(context).FirstName,
                              labelStyle:  TextStyle(color: tdBlue,fontSize: 12.sp),
                              prefixIcon:  Icon(Icons.account_circle,size: 20.w,),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0).w,
                                borderSide: const BorderSide(color: tdBlue),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0).w,
                                borderSide: const BorderSide(color: tdBlue),
                              ),
                            ),
                            controller: fnameController,
                          ),
                           SizedBox(height: 10.h),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: S.of(context).LastName,
                              labelStyle:  TextStyle(color: tdBlue,fontSize: 12.sp),
                              prefixIcon:  Icon(Icons.account_circle,size: 20.w,),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0).w,
                                borderSide: const BorderSide(color: tdBlue),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0).w,
                                borderSide: const BorderSide(color: tdBlue),
                              ),
                            ),
                            controller: lnameController,
                          ),
                          SizedBox(height: 10.h),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: S.of(context).emailAddress,
                              labelStyle:  TextStyle(color: tdBlue,fontSize: 12.sp),
                              prefixIcon:  Icon(Icons.email,size: 20.w,),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0).w,
                                borderSide: const BorderSide(color: tdBlue),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15).w,
                                borderSide: const BorderSide(color: tdBlue),
                              ),
                            ),
                            controller: emailController,
                          ),
                          SizedBox(height: 10.h),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: S.of(context).Telephone,
                              labelStyle:  TextStyle(color: tdBlue,fontSize: 12.sp),
                              prefixIcon:  Icon(Icons.phone,size: 20.w,),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0).w,
                                borderSide: const BorderSide(color: tdBlue),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0).w,
                                borderSide: const BorderSide(color: tdBlue),
                              ),
                            ),
                            controller: phoneController,
                          ),
                          SizedBox(height: 15.h),
                          GestureDetector(
                              onTap: () {
                                updateProfile();
                              },
                              child: Container(
                                width: double.infinity,
                                height: 35.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100).w,
                                  border: Border.all(color: Colors.black),
                                  color: tdbrown
                                ),
                                child: Center(
                                  child: Text(
                                    S.of(context).SaveEdit,
                                    style:  TextStyle(
                                        color: tdBlue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.sp),
                                  ),
                                ),
                              ),
                            ),
                           SizedBox(height: 5.h),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]),
    );
  }
}

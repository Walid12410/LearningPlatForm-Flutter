import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningplatformapp/SignInUp/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/l10n.dart';

class DialogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding:const EdgeInsets.all(15.0).w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.person,size: 20.w,),
              title: Text(S.of(context).PersonalInfo,style: TextStyle(fontSize: 12.sp),),
              onTap: () {
                 Navigator.pushNamed(context, '/information');
              },
            ),
            ListTile(
              leading:  Icon(Icons.logout,size:  20.w,),
              title: Text(S.of(context).LogOut,style: TextStyle(fontSize: 12.sp),),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.clear(); // Clear all stored preferences
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) =>const SignIn()),
                      (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

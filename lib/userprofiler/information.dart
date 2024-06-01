import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningplatformapp/AllClass/trainer.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/futureapi/TrainerApi.dart';
import '../generated/l10n.dart';
import 'widget/viewprofile.dart';
import 'package:learningplatformapp/provider/provider_data.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Information extends StatefulWidget {
  const Information({Key? key}) : super(key: key);

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  @override
  void initState() {
    super.initState();
    getData(context);
  }

  void getData(BuildContext context) {
    final provider = Provider.of<AppDataProvider>(context, listen: false);
    fetchTrainers(provider.userId);
  }

  @override
  Widget build(BuildContext context) {
    AppDataProvider appDataProvider =
        Provider.of<AppDataProvider>(context, listen: true);
    List<Trainer> users = appDataProvider.users;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).Profile,
           style:  TextStyle(fontWeight: FontWeight.bold, color: tdBlue,fontSize: 12.sp),
        ),
        centerTitle: true,
        backgroundColor: tdbrown,
      ),
      body: SingleChildScrollView(
        child: Column(
            children: [
               SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 90.w,
                      height: 80.h,
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
                ],
              ),
              SizedBox(height: 10.h),
              Profileview(title: S.of(context).name, desc: users[0].toString()),
              Profileview(title: S.of(context).emailAddress, desc: users[0].email),
              Profileview(title: S.of(context).Telephone, desc: users[0].telephone),
            ],
          ),
      ),
    );
  }
}

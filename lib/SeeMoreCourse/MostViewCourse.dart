import 'package:flutter/material.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/futureapi/CourseApi.dart';
import 'package:learningplatformapp/provider/provider_data.dart';
import 'package:provider/provider.dart';


class MostView extends StatefulWidget {
  const MostView({super.key});

  @override
  State<MostView> createState() => _MostViewState();
}

class _MostViewState extends State<MostView> {

  @override
  void initState() {
    super.initState();
  }

  void getData(context){
    getAllCourses(context);
  }

  double calculateMaxCrossAxisExtent(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth < 720 ? 310 : 200;
  }

  @override
  Widget build(BuildContext context) {
    AppDataProvider appDataProvider = Provider.of<AppDataProvider>(context, listen: false);
    var coursesview = appDataProvider.allCourses;
    if (coursesview != null && coursesview.isNotEmpty) {
      coursesview.sort((a, b) => b.view.compareTo(a.view));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Most View Courses',
          style: TextStyle(fontWeight: FontWeight.bold,color: tdBlue),),
        centerTitle: true,
        backgroundColor: tdbrown,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back,color: tdBlue),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors:[
                  Color(0xFFEC9D52),
                  Color(0xFF004296),
                ])
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6),
                child: Container(
                  decoration: BoxDecoration(
                    color: tdBGColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child:const TextField(
                    cursorColor: tdbrown,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: tdBlue,
                      )
                    ),
                  ),
            )),
            Padding(
              padding: const EdgeInsets.only(top: 65),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )
                ),
                height: double.infinity,
                width: double.infinity,

                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: GridView.builder(gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent:
                      calculateMaxCrossAxisExtent(context),
                      childAspectRatio: 3 / 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 15),
                      itemCount: coursesview.length,
                      itemBuilder: (context,i){

                      }),
                ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}

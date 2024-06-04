import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningplatformapp/SignInUp/signin.dart';
import 'package:learningplatformapp/colors/color.dart';
import '../../generated/l10n.dart';
import 'singupfield.dart';
import 'package:http/http.dart' as http;

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _genderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20).w,
          topRight: const Radius.circular(20).w,
        ),
      ),
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Text(
              S.of(context).createAccount,
              style: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
                color: tdbrown,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0).w,
              child: SignUpFields(
                formKey: _formKey, // Pass the form key
                firstNameController: _firstNameController,
                lastNameController: _lastNameController,
                emailController: _emailController,
                telephoneController: _telephoneController,
                userNameController: _userNameController,
                passwordController: _passwordController,
                confirmPasswordController: _confirmPasswordController,
                genderController:
                    _genderController, // Pass the gender controller
              ),
            ),
            //const TermsAndConditionsCheckbox(),
            SizedBox(height: 10.h),
            Container(
              height: 35.h,
              width: 250.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40).w, color: tdbrown),
              child: TextButton(
                onPressed: _signup,
                child: Text(
                  S.of(context).SignupSpace,
                  style:  TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.of(context).AlreadyHaveAcc,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10.sp,
                      color: tdBlue),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignIn()));
                    },
                    child: Text(
                      S.of(context).signIn,
                      style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _signup() {
    if (_formKey.currentState!.validate()) {
      final firstName = _firstNameController.text;
      final lastName = _lastNameController.text;
      final email = _emailController.text;
      final telephone = _telephoneController.text;
      final userName = _userNameController.text;
      final password = _passwordController.text;
      final confirmPassword = _confirmPasswordController.text;
      final gender = _genderController.text;

      insertTrainerData(
          firstName, lastName, email, telephone, userName, password, gender);
    }
  }

  Future<void> insertTrainerData(
      String firstName,
      String lastName,
      String email,
      String telephone,
      String userName,
      String password,
      String gender) async {
    String url =
        'http://192.168.1.12/EduPlatform/CMS/api/TrainersCrudOperation.php';
    String operation = 'Insert';

    DateTime now = DateTime.now();
    String formattedDate = '${now.year}-${now.month}-${now.day}';

    // Request parameters
    Map<String, String> params = {
      'operation': operation,
      'UserFirstName': firstName,
      'UserLastName': lastName,
      'UserProfilePic': 'null',
      'UserGender': gender,
      'UserTelephone': telephone,
      'UserEmail': email,
      'JoinDate': formattedDate,
      'IsActive': '1',
      'UserName': userName,
      'UserPassword': password,
      'UserType': 'ST'
    };

    var response = await http.post(Uri.parse(url), body: params);
    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(S.of(context).SuccessSignUp),
            content: Text(S.of(context).WelcomeSignUp),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SignIn()));
                },
                child: Text(
                  S.of(context).signIn,
                  style: TextStyle(fontWeight: FontWeight.bold, color: tdBlue,fontSize: 12.sp),
                ),
              ),
            ],
          );
        },
      );
      print(response.body);
    } else {
      print('Failed to insert trainer data. Error: ${response.statusCode}');
    }
  }
}

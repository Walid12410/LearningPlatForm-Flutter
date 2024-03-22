import 'package:flutter/material.dart';
import 'package:learningplatformapp/SignInUp/Dialog.dart';
import 'package:learningplatformapp/SignInUp/signin.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'singupfield.dart';
import 'termsandcodition.dart';
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
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15),
            const Text(
              'Create Account',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: tdbrown,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: SignUpFields(
                formKey: _formKey, // Pass the form key
                firstNameController: _firstNameController,
                lastNameController: _lastNameController,
                emailController: _emailController,
                telephoneController: _telephoneController,
                userNameController: _userNameController,
                passwordController: _passwordController,
                confirmPasswordController: _confirmPasswordController,
                genderController: _genderController, // Pass the gender controller
              ),
            ),
            const TermsAndConditionsCheckbox(),
            const SizedBox(height: 20,),
            Container(
              height: 50,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF000000),
                    Color(0xFFEC9D52),
                  ],
                ),
              ),
              child: TextButton(
                onPressed: _signup,
                child: const Text(
                  'SIGN UP',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already Have Account?',
                  style: TextStyle(fontWeight: FontWeight.bold,
                      fontSize: 15,color: tdBlue),),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                  const SignIn()));
                }, child:const Text('Sign In',style: TextStyle(
                    fontSize: 15,fontWeight: FontWeight.bold,
                    color: Colors.blue
                ),))
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _signup() {
    if (_formKey.currentState!.validate()) {
      // If valid, proceed with signup
      final firstName = _firstNameController.text;
      final lastName = _lastNameController.text;
      final email = _emailController.text;
      final telephone = _telephoneController.text;
      final userName = _userNameController.text;
      final password = _passwordController.text;
      final confirmPassword = _confirmPasswordController.text;
      final gender = _genderController.text; // Fetch gender from controller

      // Call function to insert user data
      insertTrainerData(firstName, lastName, email, telephone, userName, password,gender);
    }
  }

  Future<void> insertTrainerData(String firstName, String lastName, String email, String telephone, String userName, String password,String gender) async {
    String url = 'http://192.168.1.12/EduPlatform/CMS/api/TrainersCrudOperation.php';
    String operation = 'Insert';

    // Current date
    DateTime now = DateTime.now();
    String formattedDate = '${now.year}-${now.month}-${now.day}';

    // Request parameters
    Map<String, String> params = {
      'operation': operation,
      'UserFirstName': firstName,
      'UserLastName': lastName,
      'UserProfilePic': 'null',
      'UserGender': gender, // Assuming gender is male, you can change it as needed
      'UserTelephone': telephone,
      'UserEmail': email,
      'JoinDate': formattedDate,
      'IsActive': '1', // Active by default
      'UserName': userName,
      'UserPassword': password,
      'UserType': 'ST' // User type by default
    };

    // Make POST request
    var response = await http.post(Uri.parse(url), body: params);
    if (response.statusCode == 200) {
      print('Trainer data inserted successfully');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('SignUp Successfully Done'),
            content: Text('Welcome To Our Learning Platform App,Please Login To Our App'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                  const SignIn()));
                },
                child: const Text('Sign In',style: TextStyle(
                    fontWeight: FontWeight.bold,color: tdBlue
                ),),
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

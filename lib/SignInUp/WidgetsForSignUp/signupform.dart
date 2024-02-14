import 'package:flutter/material.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'singupfield.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String? _selectedGender;
  bool _termsAccepted = false;

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
                color: tdbrown
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: SignUpFields(
                firstNameController: _firstNameController,
                lastNameController: _lastNameController,
                emailController: _emailController,
                telephoneController: _telephoneController,
                userNameController: _userNameController,
                passwordController: _passwordController,
                confirmPasswordController: _confirmPasswordController,
                selectedGender: _selectedGender,
                onGenderChanged: (String? gender) {
                  setState(() {
                    _selectedGender = gender;
                  });
                },
                onTermsAccepted: (bool? value) {
                  if (value != null) {
                    setState(() {
                      _termsAccepted = value;
                    });
                  }
                },

              ),
            ),
            Container(
              height: 50,
              width: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  gradient: const LinearGradient(colors: [
                    Color(0xFFEC9D52),
                    Color(0xFF004296),
                  ])),
              child: TextButton(
                onPressed: () {
                },
                child: const Text(
                  'SIGN IN',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _signup() {
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;
    final email = _emailController.text;
    final telephone = _telephoneController.text;
    final userName = _userNameController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

  }
}
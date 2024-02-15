import 'package:flutter/material.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'passwordfield.dart';

class SignUpFields extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController telephoneController;
  final TextEditingController userNameController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController genderController;

  const SignUpFields({
    required this.formKey,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.telephoneController,
    required this.userNameController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.genderController,
    Key? key,
  }) : super(key: key);

  @override
  _SignUpFieldsState createState() => _SignUpFieldsState();
}

class _SignUpFieldsState extends State<SignUpFields> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          const SizedBox(height: 50),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: widget.firstNameController,
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: tdBlue,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: tdBlue,
                        width: 1,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: widget.lastNameController,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: tdBlue,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: tdBlue,
                        width: 1,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: widget.emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: tdBlue,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: tdBlue,
                  width: 1,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!value.endsWith('@gmail.com') &&
                  !value.endsWith('@hotmail.com')) {
                return 'Invalid email domain. Use @gmail.com or @hotmail.com';
              }
              // You can add more sophisticated email validation here if needed
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: widget.telephoneController,
            decoration: InputDecoration(
              labelText: 'Telephone',
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: tdBlue,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: tdBlue,
                  width: 1,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your telephone number';
              }
              if (!isNumeric(value)) {
                return 'Please enter only numeric values';
              }
              // You can add more sophisticated telephone validation here if needed
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: widget.userNameController,
            decoration: InputDecoration(
              labelText: 'UserName',
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: tdBlue,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: tdBlue,
                  width: 1,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a username';
              }
              // You can add more sophisticated validation for username here if needed
              return null;
            },
          ),
          const SizedBox(height: 5),
          RadioListTile<String>(
            title: const Text('Male',style: TextStyle(color: tdBlue,
            fontWeight: FontWeight.bold,fontSize: 20),),
            value: 'M',
            groupValue: widget.genderController.text.isNotEmpty ? widget.genderController.text : null,
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  widget.genderController.text = newValue;
                });
              }
            },
          ),
          RadioListTile<String>(
            title: const Text('Female',style: TextStyle(color: tdBlue,fontWeight: FontWeight.bold
            ,fontSize: 20),),
            value: 'F',
            groupValue: widget.genderController.text.isNotEmpty ? widget.genderController.text : null,
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  widget.genderController.text = newValue;
                });
              }
            },
          ),
          const SizedBox(height: 2),
          PasswordFields(
            passwordController: widget.passwordController,
            confirmPasswordController: widget.confirmPasswordController,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

bool isNumeric(String? value) {
  if (value == null) {
    return false;
  }
  return double.tryParse(value) != null;
}

import 'package:flutter/material.dart';
import 'passwordfield.dart';
import 'termsandcodition.dart';
import 'package:learningplatformapp/colors/color.dart';

class SignUpFields extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController telephoneController;
  final TextEditingController userNameController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final String? selectedGender;
  final Function(String?) onGenderChanged;
  final Function(bool?) onTermsAccepted;

  const SignUpFields({
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.telephoneController,
    required this.userNameController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.selectedGender,
    required this.onGenderChanged,
    required this.onTermsAccepted,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: firstNameController,
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
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: lastNameController,
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
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        TextField(
          controller: emailController,
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
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: telephoneController,
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
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: selectedGender,
                onChanged: (newValue) {
                  onGenderChanged(newValue);
                },
                decoration: InputDecoration(
                  labelText: 'Gender',
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
                items: ['Male', 'Female']
                    .map((String gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        TextField(
          controller: userNameController,
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
        ),
        const SizedBox(height: 10),
        PasswordFields(
          passwordController: passwordController,
          confirmPasswordController: confirmPasswordController,
        ),
        const SizedBox(height: 20),
        TermsAndConditionsCheckbox(
          value: false,
          onChanged: onTermsAccepted,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

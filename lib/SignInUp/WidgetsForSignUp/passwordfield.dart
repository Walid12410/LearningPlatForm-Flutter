import 'package:flutter/material.dart';
import 'package:learningplatformapp/colors/color.dart';

class PasswordFields extends StatefulWidget {
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const PasswordFields({
    required this.passwordController,
    required this.confirmPasswordController,
    Key? key,
  }) : super(key: key);

  @override
  _PasswordFieldsState createState() => _PasswordFieldsState();
}

class _PasswordFieldsState extends State<PasswordFields> {
  bool isObscurePassword = true;
  bool isObscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: widget.passwordController,
            obscureText: isObscurePassword,
            decoration: InputDecoration(
              labelText: 'Password',
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
              suffixIcon: IconButton(
                icon: Icon(
                  isObscurePassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    isObscurePassword = !isObscurePassword;
                  });
                },
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: widget.confirmPasswordController,
            obscureText: isObscureConfirmPassword,
            decoration: InputDecoration(
              labelText: 'Confirm Password',
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
              suffixIcon: IconButton(
                icon: Icon(
                  isObscureConfirmPassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    isObscureConfirmPassword = !isObscureConfirmPassword;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

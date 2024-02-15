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
          child: TextFormField(
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
                  isObscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    isObscurePassword = !isObscurePassword;
                  });
                },
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password';
              }
              if (value.length < 8) {
                return 'Password must be at least 8 characters long';
              }
              if (!containsUppercase(value)) {
                return 'Password must contain at least one uppercase letter';
              }
              return null;
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextFormField(
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
                  isObscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    isObscureConfirmPassword = !isObscureConfirmPassword;
                  });
                },
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password again';
              }
              if (value != widget.passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  bool containsUppercase(String value) {
    for (var char in value.runes) {
      if (char >= 65 && char <= 90) {
        return true;
      }
    }
    return false;
  }
}

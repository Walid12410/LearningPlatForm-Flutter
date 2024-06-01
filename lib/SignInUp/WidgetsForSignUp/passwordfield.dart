import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningplatformapp/colors/color.dart';

import '../../generated/l10n.dart';

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
              labelText: S.of(context).password,
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10.sp,
                color: tdBlue,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15).w,
                borderSide: const BorderSide(
                  color: tdBlue,
                  width: 1,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15).w,
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
                return S.of(context).PlzEnterPassword;
              }
              if (value.length < 8) {
                return S.of(context).PasswordLong;
              }
              if (!containsUppercase(value)) {
                return S.of(context).PasswordLetter;
              }
              return null;
            },
          ),
        ),
        SizedBox(width: 5.w),
        Expanded(
          child: TextFormField(
            controller: widget.confirmPasswordController,
            obscureText: isObscureConfirmPassword,
            decoration: InputDecoration(
              labelText: S.of(context).PasswordConfirm,
              labelStyle:  TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10.sp,
                color: tdBlue,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15).w,
                borderSide: const BorderSide(
                  color: tdBlue,
                  width: 1,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15).w,
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
                return S.of(context).EnterPassAgain;
              }
              if (value != widget.passwordController.text) {
                return S.of(context).PassNotMatch;
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

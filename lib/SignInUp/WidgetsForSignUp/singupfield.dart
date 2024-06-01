import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningplatformapp/colors/color.dart';
import '../../generated/l10n.dart';
import 'passwordfield.dart';
import 'package:intl/intl.dart';

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
  bool isArabic() {
    return Intl.getCurrentLocale() == 'ar';
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          SizedBox(height: 30.h),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: widget.firstNameController,
                  decoration: InputDecoration(
                    labelText: S.of(context).FirstName,
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
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).PlzEnterFn;
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
                    labelText: S.of(context).LastName,
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
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).PlzEnterLn;
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
           SizedBox(height: 10.h),
          TextFormField(
            controller: widget.emailController,
            decoration: InputDecoration(
              labelText: S.of(context).emailAddress,
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
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return S.of(context).InvalidEmail;
              }
              if (!value.endsWith('@gmail.com') &&
                  !value.endsWith('@hotmail.com')) {
                return S.of(context).InvalidDomainEmail;
              }
              // You can add more sophisticated email validation here if needed
              return null;
            },
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: isArabic()
                      ? const EdgeInsets.only(left: 8).w
                      : const EdgeInsets.only(right: 8).w,
                  child: TextFormField(
                    controller: widget.telephoneController,
                    decoration: InputDecoration(
                      labelText: S.of(context).Telephone,
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
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).PlzEnterPhone;
                      }
                      if (!isNumeric(value)) {
                        return S.of(context).PlzEnterNumPhone;
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: widget.userNameController,
                  decoration: InputDecoration(
                    labelText: S.of(context).UserName,
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
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).PlzEnterUserName;
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
           SizedBox(height: 5.h),
          Row(
            children: [
              Expanded(
                child: RadioListTile<String>(
                  title: Text(
                    S.of(context).Male,
                    style:  TextStyle(
                      color: tdBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                    ),
                  ),
                  value: 'M',
                  groupValue: widget.genderController.text.isNotEmpty
                      ? widget.genderController.text
                      : null,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        widget.genderController.text = newValue;
                      });
                    }
                  },
                ),
              ),
              Expanded(
                child: RadioListTile<String>(
                  title: Text(
                    S.of(context).Female,
                    style:  TextStyle(
                      color: tdBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                    ),
                  ),
                  value: 'F',
                  groupValue: widget.genderController.text.isNotEmpty
                      ? widget.genderController.text
                      : null,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        widget.genderController.text = newValue;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
           SizedBox(height: 2.h),
          PasswordFields(
            passwordController: widget.passwordController,
            confirmPasswordController: widget.confirmPasswordController,
          ),
           SizedBox(height: 10.h),
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

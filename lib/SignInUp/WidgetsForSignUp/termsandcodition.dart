import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/SignInUp/Dialog.dart';

class TermsAndConditionsCheckbox extends StatelessWidget {

  const TermsAndConditionsCheckbox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 10,),
        Flexible(
          child: RichText(
            text: TextSpan(
              text: ' By clicking in signup You agree to our ',
              style: const TextStyle(
                color: tdBlue, // Set the desired color here
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Terms',
                  style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      ShowDialog(
                        context,
                        'Terms',
                        'By accessing and using our services, you agree to abide by our Terms and Conditions. These terms govern your use of our platform and outline your rights and responsibilities as a user.',
                      );
                    },
                ),
                const TextSpan(text: ', '),
                TextSpan(
                  text: 'Privacy Policy',
                  style:const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      ShowDialog(
                        context,
                        'Privacy Policy',
                        'Our Privacy Policy outlines how we collect, use, and protect your personal information when you use our services. We are committed to safeguarding your privacy and ensuring the security of your data.',
                      );                    },
                ),
                const TextSpan(text: ', and '),
                TextSpan(
                  text: 'Cookies Policy',
                  style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      ShowDialog(
                        context,
                        'Cookies Policy',
                        'Our Cookies Policy explains how we use cookies and similar technologies to enhance your browsing experience and improve our services. We use cookies for analytics, personalization, and targeted advertising.',
                      );
                    },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

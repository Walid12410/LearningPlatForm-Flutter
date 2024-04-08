import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/SignInUp/Dialog.dart';

import '../../generated/l10n.dart';

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
              text: S.of(context).ByClicking,
              style: const TextStyle(
                color: tdBlue, // Set the desired color here
              ),
              children: <TextSpan>[
                TextSpan(
                  text: S.of(context).Terms,
                  style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      ShowDialog(
                        context,
                        S.of(context).Terms,
                        S.of(context).TermsDetails,
                      );
                    },
                ),
                const TextSpan(text: ', '),
                TextSpan(
                  text: S.of(context).PrivacyPolicy,
                  style:const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      ShowDialog(
                        context,
                       S.of(context).PrivacyPolicy,
                        S.of(context).PrivacyDetails,
                      );                    },
                ),
                TextSpan(text: S.of(context).and),
                TextSpan(
                  text: S.of(context).cookiesPolicy,
                  style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      ShowDialog(
                        context,
                        S.of(context).cookiesPolicy,
                        S.of(context).cookiesDetails,
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

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/SignInUp/Dialog.dart';

import '../../generated/l10n.dart';

class TermsAndConditionsCheckbox extends StatelessWidget {

  const TermsAndConditionsCheckbox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0,right: 0).w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: S.of(context).ByClicking,
                style:  TextStyle(
                  color: tdBlue,
                  fontSize: 10.sp
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
      ),
    );
  }
}

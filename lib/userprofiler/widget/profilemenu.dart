import 'package:flutter/material.dart';
import 'package:learningplatformapp/colors/color.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPressed,
    required this.textColor,
    this.endIcon = true,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  final Color textColor;
  final bool endIcon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: tdBGColor,
        ),
        child: Icon(
          icon,
          color: tdBlue,
        ),
      ),
      title: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: tdBGColor,
              ),
              child: const Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: tdBlue,
              ),
            )
          : null,
    );
  }
}

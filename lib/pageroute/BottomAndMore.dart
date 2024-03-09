import 'package:flutter/material.dart';


class CustomPageRoute2 extends PageRouteBuilder {
  final Widget child;

  CustomPageRoute2({required this.child})
      : super(
    transitionDuration: const Duration(milliseconds: 350),
    pageBuilder: (context, animation, secondaryAnimation) => child,
  );

  @override
  Widget buildTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) =>
      SlideTransition(
        position: Tween<Offset>(
          begin : const Offset(0,1),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
}

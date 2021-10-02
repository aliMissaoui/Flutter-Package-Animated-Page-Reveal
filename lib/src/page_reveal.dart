import 'dart:math';

import 'package:flutter/material.dart';

// Page reveal logic
class PageReveal extends StatelessWidget {
  const PageReveal({Key? key, required this.revealPercent, required this.child})
      : super(key: key);

  final double revealPercent;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      clipper: CircleRevealClipper(revealPercent),
      child: child,
    );
  }
}

class CircleRevealClipper extends CustomClipper<Rect> {
  final double revealPercent;

  CircleRevealClipper(this.revealPercent);

  @override
  Rect getClip(Size size) {
    final epicenter = Offset(size.width / 2, size.height * 0.9);

    // Calculate the distance from the epicenter to the left top corner to make sure we fill the screen.
    double theta = atan(epicenter.dy / epicenter.dx);

    final distanceToCorner = epicenter.dy / sin(theta);
    final radius = distanceToCorner * revealPercent;
    final diameter = 2 * radius;

    return Rect.fromLTWH(
        epicenter.dx - radius, epicenter.dy - radius, diameter, diameter);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return true;
  }
}

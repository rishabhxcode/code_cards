import 'package:flutter/material.dart';
import 'dart:math';

class FlipWidget extends StatelessWidget {
  final Widget front;
  final Widget back;
  final AnimationController flipController;
  const FlipWidget({Key key, this.front, this.back, this.flipController});
  @override
  Widget build(BuildContext context) {
    return Transform(
      key: key,
      origin: Offset(150, 0),
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.0008)
        ..rotateY(pi * flipController.value),
      child: flipController.value < 0.5
          ? front
          : Transform(
              origin: Offset(150, 0),
              transform: Matrix4.identity()..rotateY(pi),
              child: back),
    );
  }
}

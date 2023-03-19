import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TextWithMargin extends StatelessWidget {
  final String text;
  double? top = 0;
  double? bottom = 0;
  double? left = 0;
  double? right = 0;
  TextStyle? style;
  TextWithMargin(
    this.text, {
    super.key,
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: top ?? 0,
        bottom: bottom ?? 0,
        right: right ?? 0,
        left: left ?? 0,
      ),
      child: Text(
        text,
        style: style,
      ),
    );
  }
}

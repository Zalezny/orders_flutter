import 'package:flutter/material.dart';


class TextWithMargin extends StatelessWidget {
  final String text;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final TextStyle? style;
  const TextWithMargin(
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

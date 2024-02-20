import 'package:flutter/material.dart';

class TtnflixTextWidget extends StatelessWidget {
  const TtnflixTextWidget({
    super.key,
    this.textDirection,
    this.style,
    this.title,
    this.color,
  });

  final TextDirection? textDirection;
  final TextStyle? style;
  final String? title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? "",
      style: style,
      textDirection: textDirection,
    );
  }
}

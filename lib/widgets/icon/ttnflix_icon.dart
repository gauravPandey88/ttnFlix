import 'package:flutter/material.dart';

class TtnflixIconWidget extends StatelessWidget {
  const TtnflixIconWidget(
      {super.key, this.icon, this.size, this.fill, this.color});

  final IconData? icon;
  final double? size;
  final double? fill;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size,
      fill: fill,
      color: color,
    );
  }
}

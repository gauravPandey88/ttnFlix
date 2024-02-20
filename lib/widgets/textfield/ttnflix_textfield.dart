import 'package:flutter/material.dart';

class TtnflixTextField extends StatelessWidget {
  const TtnflixTextField({
    super.key,
    this.cursorColor,
    this.style,
    this.controller,
    this.decoration,
    this.onTap,
    this.obscureText,
    this.onChanged,
    this.expands,
  });

  final Color? cursorColor;
  final TextStyle? style;
  final TextEditingController? controller;
  final InputDecoration? decoration;
  final GestureTapCallback? onTap;
  final bool? obscureText;
  final bool? expands;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(

      cursorColor: cursorColor,
      style: style,
      controller: controller,
      decoration: decoration,
      onTap: onTap,
      obscureText: obscureText ?? false,
      expands: expands ?? false,
      onChanged: onChanged,
    );
  }
}

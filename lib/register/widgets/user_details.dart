import 'package:flutter/material.dart';
import 'package:ttn_flix/themes/ttnflix_colors.dart';
import 'package:ttn_flix/themes/ttnflix_spacing.dart';
import 'package:ttn_flix/themes/ttnflix_typography.dart';

class UserDetails extends StatelessWidget {
  const UserDetails(
      {super.key,
      this.title,
      this.controller,
      this.data,
      this.onChanged,
      this.errorText,
      this.onTap,
      this.labelText,
      this.labelStyle,
      required this.obscureText,
      this.suffixIcon});
  final String? title;
  final String? data;
  final String? errorText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final String? labelText;
  final TextStyle? labelStyle;
  final bool obscureText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              top: TtnflixSpacing.spacing20, left: TtnflixSpacing.spacing10),
          child: Text(title ?? "",
              style: TtnFlixTextStyle.defaultTextTheme.titleSmall?.copyWith(
                  color: TtnflixColors.titleColor
                      .platformBrightnessColor(context))),
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: TtnflixSpacing.spacing10,
              left: TtnflixSpacing.spacing10,
              right: TtnflixSpacing.spacing10),
          child: TextField(
            obscureText: obscureText,
            controller:
                controller, //BlocProvider.of<RegisterCubit>(context).nameTextController,
            cursorColor:
                TtnflixColors.titleColor.platformBrightnessColor(context),
            style: TextStyle(
                color:
                    TtnflixColors.titleColor.platformBrightnessColor(context)),
            onChanged: onChanged,
            onTap: onTap,
            decoration: InputDecoration(
                filled: true,
                fillColor: TtnflixColors.inputBoxColor
                    .platformBrightnessColor(context),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: TtnflixColors.whiteGlow),
                ),
                labelText: labelText,
                labelStyle: labelStyle,
                suffixIcon: suffixIcon,

                hintText: title,
                hintStyle: TtnFlixTextStyle.defaultTextTheme.titleMedium
                    ?.copyWith(
                        color: TtnflixColors.cellTextColor
                            .platformBrightnessColor(context)),
                errorText: errorText,
                errorStyle: TextStyle(
                    color: TtnflixColors.frozenListYellow
                        .platformBrightnessColor(context))),
          ),
        ),
      ],
    );
  }
}

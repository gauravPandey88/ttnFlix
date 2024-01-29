import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ttn_flix/themes/ttnflix_colors.dart';
import 'package:ttn_flix/themes/ttnflix_spacing.dart';
import 'package:ttn_flix/themes/ttnflix_typography.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({super.key, this.title, this.controller, this.data, this.onChanged, this.errorText});
  final String? title;
  final String? data;
  final String? errorText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;


  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: TtnflixSpacing.spacing20, left: TtnflixSpacing.spacing10),
          child: Text(title ?? "",
              style: TtnFlixTextStyle.defaultTextTheme.titleSmall
                  ?.copyWith(color: TtnflixColors.whiteGlow)),
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: TtnflixSpacing.spacing10, left: TtnflixSpacing.spacing10, right: TtnflixSpacing.spacing10),
          child: TextField(
            controller: controller,//BlocProvider.of<RegisterCubit>(context).nameTextController,
            cursorColor: TtnflixColors.whiteGlow,
            style: const TextStyle(color: TtnflixColors.whiteGlow),
            onChanged: onChanged,
            decoration: InputDecoration(
                filled: true,
                fillColor: TtnflixColors.greyColor,
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: TtnflixColors.whiteGlow),
                ),
                hintText: title,
                hintStyle: TtnFlixTextStyle
                    .defaultTextTheme.titleMedium
                    ?.copyWith(color: TtnflixColors.cellTextColor.platformBrightnessColor(context)),
              errorText: errorText,
              errorStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onError)),
          ),
        ),
      ],
    );

  }
}
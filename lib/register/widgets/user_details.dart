import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ttn_flix/themes/ttnflix_colors.dart';
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
          padding: const EdgeInsets.only(top: 20.0, left: 10.0),
          child: Text(title ?? "",
              style: TtnFlixTextStyle.defaultTextTheme.titleSmall
                  ?.copyWith(color: Colors.grey)),
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: 10.0, left: 10.0, right: 10.0),
          child: TextField(
            controller: controller,//BlocProvider.of<RegisterCubit>(context).nameTextController,
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white),
            onChanged: onChanged,
            decoration: InputDecoration(
                filled: true,
                fillColor: TtnflixColors.greyColor,
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                hintText: title,
                hintStyle: TtnFlixTextStyle
                    .defaultTextTheme.titleMedium
                    ?.copyWith(color: Colors.grey),
              errorText: errorText,
              errorStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onError)),
          ),
        ),
      ],
    );

  }
}
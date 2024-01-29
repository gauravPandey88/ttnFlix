import 'package:flutter/material.dart';
import 'package:ttn_flix/themes/ttnflix_colors.dart';
import 'package:ttn_flix/themes/ttnflix_typography.dart';

extension Snackbar on String {
  void showSnackbar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text(
        this,
        style: TtnFlixTextStyle.defaultTextTheme.titleMedium
            ?.copyWith(color: TtnflixColors.textBlackColor.platformBrightnessColor(context)),
      ),
      backgroundColor:
          TtnflixColors.frozenListYellow.platformBrightnessColor(context),
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar).close;

  }
}



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ttn_flix/generated/l10n.dart';
import 'package:ttn_flix/themes/ttnflix_colors.dart';
import 'package:ttn_flix/themes/ttnflix_spacing.dart';
import 'package:ttn_flix/themes/ttnflix_typography.dart';



class ShowLoader {

  void showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      backgroundColor:
      TtnflixColors.textBlackColor.platformBrightnessColor(context),
      content: Row(
        children: [
          CircularProgressIndicator(color: TtnflixColors.titleColor
              .platformBrightnessColor(context),),
          Container(
            margin: const EdgeInsets.only(left: TtnflixSpacing.spacing5),
            child: Text(S.of(context).loading,
                style: TtnFlixTextStyle.defaultTextTheme.titleSmall?.copyWith(
                    color: TtnflixColors.titleColor
                        .platformBrightnessColor(context))),
          )
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}





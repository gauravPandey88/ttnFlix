
import 'package:flutter/material.dart';
import 'package:ttn_flix/themes/ttnflix_colors.dart';
import 'package:ttn_flix/utils/app_button.dart';

class AppAlert {
  final String? title;
  final String? message;
  final String? confirmBtnText;
  final VoidCallback? cancelTap;
  final VoidCallback? confirmTap;
  final bool? isNeedConfirmBtn;
  const AppAlert(
      {this.title = '',
        this.message,
        this.confirmBtnText = 'OK',
        this.isNeedConfirmBtn = true,
        this.cancelTap,
        this.confirmTap});

  void showDialogBox(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor:TtnflixColors.frozenListYellow
                  .platformBrightnessColor(context),
              title: title != '' ? Text(title ?? '',
                  style: Theme
                  .of(context)
                  .textTheme
                  .titleSmall) : null,
              content: Text(message ?? '',style: Theme
                  .of(context)
                  .textTheme
                  .titleSmall),
              actions: [
                AppTextButton(
                    title: 'Cancel',
                    textColor: Colors.black,
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (cancelTap != null) {
                        cancelTap!();
                      }
                    }),
                if (isNeedConfirmBtn ?? false)
                  AppTextButton(
                      title: confirmBtnText ?? '',
                      textColor: Colors.black,
                      onPressed: () {
                        Navigator.of(context).pop();
                        if (confirmTap != null) {
                          confirmTap!();
                        }
                      })
              ]);
        });
  }
}
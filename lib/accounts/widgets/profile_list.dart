import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ttn_flix/themes/ttnflix_colors.dart';
import 'package:ttn_flix/themes/ttnflix_spacing.dart';
import 'package:ttn_flix/themes/ttnflix_typography.dart';

class ProfileList extends StatelessWidget {
  const ProfileList({super.key, required this.context, this.tittle, this.data, this.icon});
  final BuildContext context;
  final IconData? icon;
  final String? tittle;
  final String? data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: TtnflixSpacing.spacing20, left: TtnflixSpacing.spacing10),
      child: Container(
        color: TtnflixColors.textBlackColor.platformBrightnessColor(context),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: TtnflixSpacing.spacing20, color: TtnflixColors.titleColor.platformBrightnessColor(context)),
            const SizedBox(
              width: TtnflixSpacing.spacing10,
            ),
            SizedBox(
              height: TtnflixSpacing.spacing50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(tittle ?? "",
                      style: TtnFlixTextStyle.defaultTextTheme.titleSmall
                          ?.copyWith(color: TtnflixColors.titleColor.platformBrightnessColor(context))),
                  const SizedBox(
                    height: TtnflixSpacing.spacing8,
                  ),
                  Text(data ?? "",
                      style: TtnFlixTextStyle.defaultTextTheme.titleSmall
                          ?.copyWith(color: TtnflixColors.titleColor.platformBrightnessColor(context))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

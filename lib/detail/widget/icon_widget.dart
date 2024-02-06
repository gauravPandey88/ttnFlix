import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ttn_flix/home/model/ttnflix_movies.dart';
import 'package:ttn_flix/themes/ttnflix_colors.dart';
import 'package:ttn_flix/themes/ttnflix_spacing.dart';

@RoutePage()
class IconWidget extends StatelessWidget {
  IconWidget({super.key, required this.movie, required this.isFavourite});
  final Movie movie;
  bool isFavourite;
  @override
  Widget build(BuildContext context) {
    return Container(
          decoration: BoxDecoration(
            color: TtnflixColors.textBlackColor.platformBrightnessColor(context),
            borderRadius:
            const BorderRadius.all(Radius.circular(TtnflixSpacing.spacing30)),
          ),
          child: Icon(
                Icons.star_outlined,
                color: isFavourite
                    ? TtnflixColors.skyRacing1Color.platformBrightnessColor(context)
                    : TtnflixColors.frozenListYellow
                    .platformBrightnessColor(context),
              ),
        );
  }
}
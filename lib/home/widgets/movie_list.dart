import 'package:flutter/material.dart';
import 'package:ttn_flix/network/ttnflix_api_url.dart';
import 'package:ttn_flix/themes/ttnflix_colors.dart';
import 'package:ttn_flix/themes/ttnflix_spacing.dart';
import 'package:ttn_flix/themes/ttnflix_typography.dart';

class MovieListWidgets extends StatelessWidget {
  const MovieListWidgets(
      {super.key,
      required this.context,
      this.height,
      this.carousalImage,
      this.movieName,
      this.language});

  final BuildContext context;
  final double? height;
  final String? carousalImage;
  final String? movieName;
  final String? language;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
                height: height,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                    "${TtnflixApiUrl.imageBaseUrl}$carousalImage",
                    fit: BoxFit.fill)),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.15)),
                padding: const EdgeInsets.only(left: TtnflixSpacing.spacing10, right: TtnflixSpacing.spacing10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'U/A',
                      style: TtnFlixTextStyle.defaultTextTheme.labelLarge
                          ?.copyWith(
                        color: TtnflixColors.frozenListYellow
                            .platformBrightnessColor(context),
                      ),
                    ),
                    Text(
                      language ?? "",
                      style: TtnFlixTextStyle.defaultTextTheme.labelLarge
                          ?.copyWith(
                        color: TtnflixColors.frozenListYellow
                            .platformBrightnessColor(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: TtnflixSpacing.spacing5,
        ),
        RichText(
          text: TextSpan(
            text: movieName ?? "",
            style: TtnFlixTextStyle.defaultTextTheme.titleMedium?.copyWith(
              color: TtnflixColors.frozenListYellow
                  .platformBrightnessColor(context),
              overflow: TextOverflow.ellipsis
            ),
          ),
          maxLines: 1,
          softWrap: true,
        )
      ],
    );
  }
}

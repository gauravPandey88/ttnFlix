import 'package:flutter/material.dart';
import 'package:ttn_flix/network/ttnflix_api_url.dart';
import 'package:ttn_flix/themes/ttnflix_colors.dart';
import 'package:ttn_flix/themes/ttnflix_spacing.dart';
import 'package:ttn_flix/themes/ttnflix_typography.dart';

class _GridMovielistConstant {
  static const double gridHeight = 200.0;
  static const double blurRadius = 10.0;
  static const double borderRadius = 8;
  static const String content = 'U/A';
}

class GridMovielist extends StatelessWidget {
  const GridMovielist(
      {super.key,
      required this.context,
      this.height,
      this.carousalImage,
      this.language,
      this.movieName});
  final BuildContext context;
  final double? height;
  final String? movieName;
  final String? carousalImage;
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
              height: _GridMovielistConstant.gridHeight,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        _GridMovielistConstant.borderRadius),
                    image: DecorationImage(
                      image: NetworkImage(
                          "${TtnflixApiUrl.imageBaseUrl}$carousalImage"),
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            Positioned(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  //  decoration: BoxDecoration(color: Colors.black.withOpacity(1)),
                  decoration: const BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black54,
                          blurRadius: _GridMovielistConstant.blurRadius,
                          offset: Offset(1.0, 1.0))
                    ],
                  ),
                  padding: const EdgeInsets.only(
                      left: TtnflixSpacing.spacing10,
                      right: TtnflixSpacing.spacing10,
                      bottom: TtnflixSpacing.spacing10),
                  child: Column(
                    children: [
                      Text(
                        movieName ?? "",
                        style: TtnFlixTextStyle.defaultTextTheme.titleSmall
                            ?.copyWith(
                          color: TtnflixColors.frozenListYellow
                              .platformBrightnessColor(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: TtnflixSpacing.spacing8,top: TtnflixSpacing.spacing8),
                  child: Column(
                    children: [
                      Text(
                        _GridMovielistConstant.content,
                        style: TtnFlixTextStyle.defaultTextTheme.bodySmall
                            ?.copyWith(
                          color: TtnflixColors.frozenListYellow
                              .platformBrightnessColor(context),
                        ),
                      ),
                      Text(
                        language ?? "",
                        style: TtnFlixTextStyle.defaultTextTheme.bodySmall
                            ?.copyWith(
                          color: TtnflixColors.frozenListYellow
                              .platformBrightnessColor(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Positioned.fill(
                child: Align(
              alignment: Alignment.topRight,
              child: Icon(
                Icons.star_border,
                color: Colors.amber,
              ),
            ))
          ],
        )
      ],
    );
  }
}

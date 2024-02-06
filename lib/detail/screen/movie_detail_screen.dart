import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttn_flix/detail/widget/icon_widget.dart';
import 'package:ttn_flix/generated/l10n.dart';
import 'package:ttn_flix/home/favouriteList/cubit/favourite_list_cubit.dart';
import 'package:ttn_flix/home/model/ttnflix_movies.dart';
import 'package:ttn_flix/network/ttnflix_api_url.dart';
import 'package:ttn_flix/themes/ttnflix_colors.dart';
import 'package:ttn_flix/themes/ttnflix_spacing.dart';
import 'package:ttn_flix/themes/ttnflix_typography.dart';
import 'package:ttn_flix/widgets/icon/ttnflix_icon.dart';
import 'package:ttn_flix/widgets/text/ttnflix_text.dart';

class _MovieDetailScreenConstant {
  static const String detail = 'Movie Detail';
  static const double height  = 2.5;
}

@RoutePage()
class MovieDetailScreen extends StatelessWidget {
  MovieDetailScreen({
    super.key,
    required this.movie,
    required this.isFavourite,
  });

  final Movie movie;
  bool isFavourite;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TtnflixColors.textBlackColor.platformBrightnessColor(context),
      appBar: AppBar(
        title: TtnflixTextWidget(title: _MovieDetailScreenConstant.detail,
            style: TtnFlixTextStyle.defaultTextTheme.headlineSmall?.copyWith(
                color: TtnflixColors.frozenListYellow
                    .platformBrightnessColor(context))),
        backgroundColor: TtnflixColors.textBlackColor.platformBrightnessColor(context),
        actions: <Widget>[
          BlocProvider(
            create: (context) => FavouriteListCubit(),
            child: IconWidget(
              movie: movie,
              isFavourite: isFavourite,
            ),
          )
        ],
        leading: IconButton(
          onPressed: () {
            context.router.pop();
          },
          icon: TtnflixIconWidget(
            icon: Icons.arrow_back_outlined,
            color: TtnflixColors.frozenListYellow.platformBrightnessColor(context),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / _MovieDetailScreenConstant.height,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "${TtnflixApiUrl.imageBaseUrl}${movie.posterPath}"),
                      fit: BoxFit.fill),
                ),
              ),
            ),
            const SizedBox(
              height: TtnflixSpacing.spacing10,
            ),
            Padding(
              padding: const EdgeInsets.all(TtnflixSpacing.spacing8),
              child: TtnflixTextWidget(title: movie.title ?? '',
                style: TtnFlixTextStyle.defaultTextTheme.headlineLarge
                    ?.copyWith(
                        color: TtnflixColors.frozenListYellow
                            .platformBrightnessColor(context)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(TtnflixSpacing.spacing8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      TtnflixIconWidget(
                        icon: Icons.aspect_ratio,
                        color: TtnflixColors.frozenListYellow
                            .platformBrightnessColor(context),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: TtnflixSpacing.spacing5),
                        child: TtnflixTextWidget(
                          title: movie.getContentRating(),
                          style: TtnFlixTextStyle.defaultTextTheme.titleSmall
                              ?.copyWith(
                                  color: TtnflixColors.frozenListYellow
                                      .platformBrightnessColor(context)),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      TtnflixIconWidget(
                        icon: Icons.movie,
                        color: TtnflixColors.frozenListYellow
                            .platformBrightnessColor(context),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: TtnflixSpacing.spacing5),
                        child: TtnflixTextWidget(
                          title: movie.mediaType ?? '',
                          style: TtnFlixTextStyle.defaultTextTheme.titleSmall
                              ?.copyWith(
                                  color: TtnflixColors.frozenListYellow
                                      .platformBrightnessColor(context)),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      TtnflixIconWidget(
                        icon: Icons.language,
                        color: TtnflixColors.frozenListYellow
                            .platformBrightnessColor(context),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: TtnflixSpacing.spacing5),
                        child: TtnflixTextWidget(
                          title: movie.originalLanguage?.toUpperCase() ?? '',
                          style: TtnFlixTextStyle.defaultTextTheme.titleSmall
                              ?.copyWith(
                                  color: TtnflixColors.frozenListYellow
                                      .platformBrightnessColor(context)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: TtnflixSpacing.spacing8),
              child: TtnflixTextWidget(
                title: S.of(context).overview,
                textDirection: TextDirection.ltr,
                style: TtnFlixTextStyle.defaultTextTheme.labelLarge?.copyWith(
                    color: TtnflixColors.frozenListYellow
                        .platformBrightnessColor(context)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: TtnflixSpacing.spacing8),
              child: TtnflixTextWidget(
                title: movie.overview ?? '',
                textDirection: TextDirection.ltr,
                style: TtnFlixTextStyle.defaultTextTheme.titleSmall?.copyWith(
                    color: TtnflixColors.frozenListYellow
                        .platformBrightnessColor(context)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(TtnflixSpacing.spacing8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      TtnflixIconWidget(
                        icon: Icons.calendar_month,
                        color: TtnflixColors.frozenListYellow
                            .platformBrightnessColor(context),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: TtnflixSpacing.spacing8),
                        child: TtnflixTextWidget(
                          title: movie.releaseDate ?? '',
                          style: TtnFlixTextStyle.defaultTextTheme.titleSmall
                              ?.copyWith(
                                  color: TtnflixColors.frozenListYellow
                                      .platformBrightnessColor(context)),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      TtnflixIconWidget(
                        icon: Icons.thumb_up,
                        color: TtnflixColors.frozenListYellow
                            .platformBrightnessColor(context),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: TtnflixSpacing.spacing8),
                        child: TtnflixTextWidget(
                          title:  movie.voteAverage.toString(),
                          style: TtnFlixTextStyle.defaultTextTheme.titleSmall
                              ?.copyWith(
                                  color: TtnflixColors.frozenListYellow
                                      .platformBrightnessColor(context)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:ffi';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttn_flix/home/favouriteList/cubit/favourite_list_cubit.dart';
import 'package:ttn_flix/home/favouriteList/cubit/favourite_list_state.dart';
import 'package:ttn_flix/home/model/ttnflix_movies.dart';
import 'package:ttn_flix/network/ttnflix_api_url.dart';
import 'package:ttn_flix/themes/ttnflix_colors.dart';
import 'package:ttn_flix/themes/ttnflix_typography.dart';
import 'package:ttn_flix/utils/show_snackbar.dart';

class _MovieDetailScreenConstant {
  static const String detail = 'Movie Detail';
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(_MovieDetailScreenConstant.detail,
            style: TtnFlixTextStyle.defaultTextTheme.headlineSmall?.copyWith(
                color: TtnflixColors.frozenListYellow
                    .platformBrightnessColor(context))),
        backgroundColor: Colors.black,
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
          icon: Icon(
            Icons.arrow_back_outlined,
            color:
                TtnflixColors.frozenListYellow.platformBrightnessColor(context),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.5,
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
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movie.title ?? '',
                style: TtnFlixTextStyle.defaultTextTheme.headlineLarge
                    ?.copyWith(
                        color: TtnflixColors.frozenListYellow
                            .platformBrightnessColor(context)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.aspect_ratio,
                        color: TtnflixColors.frozenListYellow
                            .platformBrightnessColor(context),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          movie.getContentRating() ?? '',
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
                      Icon(
                        Icons.movie,
                        color: TtnflixColors.frozenListYellow
                            .platformBrightnessColor(context),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          movie.mediaType ?? '',
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
                      Icon(
                        Icons.language,
                        color: TtnflixColors.frozenListYellow
                            .platformBrightnessColor(context),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          movie.originalLanguage?.toUpperCase() ?? '',
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
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                'Overview',
                textDirection: TextDirection.ltr,
                style: TtnFlixTextStyle.defaultTextTheme.labelLarge?.copyWith(
                    color: TtnflixColors.frozenListYellow
                        .platformBrightnessColor(context)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                movie.overview ?? '',
                textDirection: TextDirection.ltr,
                style: TtnFlixTextStyle.defaultTextTheme.titleSmall?.copyWith(
                    color: TtnflixColors.frozenListYellow
                        .platformBrightnessColor(context)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: TtnflixColors.frozenListYellow
                            .platformBrightnessColor(context),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          movie.releaseDate ?? '',
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
                      Icon(
                        Icons.thumb_up,
                        color: TtnflixColors.frozenListYellow
                            .platformBrightnessColor(context),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          movie.voteAverage.toString(),
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

@RoutePage()
class IconWidget extends StatelessWidget {
  IconWidget({super.key, required this.movie, required this.isFavourite});
  final Movie movie;
  bool isFavourite;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavouriteListCubit, FavouriteListState>(
      listener: (context, state) {
        if (state is FavouriteListSuccess) {
          state.message.toString().showSnackbar(context);
        } else {
          toString().showSnackbar(context);
        }
      },
      builder: (context, state) {
        return IconButton(onPressed: () {
          final cubit = context.read<FavouriteListCubit>();
          cubit.addRemoveWishlist(context, movie, isNeedToAdd: !isFavourite);
        }, icon: Container(
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius:
            BorderRadius.all(Radius.circular(30)),
          ),
          child: BlocBuilder<FavouriteListCubit, FavouriteListState>(
            builder: (context, state) {
              if (state is FavouriteListSuccess) {
                isFavourite = state.isFavourite;
              }
              return Icon(
                Icons.star_outlined,
                color: isFavourite
                    ? TtnflixColors.whiteGlow
                    : TtnflixColors.frozenListYellow
                        .platformBrightnessColor(context),
              );
            },
          ),
        ));
      },
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttn_flix/home/cubit/home_cubit.dart';
import 'package:ttn_flix/home/favouriteList/cubit/favourite_list_cubit.dart';
import 'package:ttn_flix/home/favouriteList/cubit/favourite_list_state.dart';
import 'package:ttn_flix/home/model/ttnflix_movies.dart';
import 'package:ttn_flix/navigation/ttnflix_auto_route.dart';
import 'package:ttn_flix/network/ttnflix_api_url.dart';
import 'package:ttn_flix/themes/ttnflix_colors.dart';
import 'package:ttn_flix/themes/ttnflix_spacing.dart';
import 'package:ttn_flix/themes/ttnflix_typography.dart';
import 'package:ttn_flix/utils/show_snackbar.dart';

class _GridMovielistConstant {
  static const double gridHeight = 200.0;
  static const double blurRadius = 10.0;
  static const double borderRadius = 8;
  static const double offset = 1.0;
}

class GridMovielist extends StatelessWidget with ChangeNotifier {
  GridMovielist(
      {super.key,
      required this.context,
      this.height,
      this.carousalImage,
      this.language,
      this.standardSelected,
      this.onChanged,
      this.movieName,
      this.isComingFromHome = true,
      this.favouritesAction,
      required this.movie
      }){
    _wishlist = ValueNotifier<bool>(movie.isFavourite);
  }
  final BuildContext context;
  final double? height;
  final String? movieName;
  final String? carousalImage;
  final String? language;
  final Movie movie;
  final bool? standardSelected;
  final ValueChanged? onChanged;
  final Function(bool)? favouritesAction;
  final bool isComingFromHome;
  late ValueNotifier<bool>? _wishlist;
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
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                context.router.push(MovieDetailScreenRoute(
                    movie: movie, favouritesAction: favouritesAction)).then((value){
                  _wishlist?.value = movie.isFavourite;
                  _wishlist?.notifyListeners();
                });
              },
              child: Stack(
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
                        decoration: const BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.black54,
                                blurRadius: _GridMovielistConstant.blurRadius,
                                offset: Offset(_GridMovielistConstant.offset,
                                    _GridMovielistConstant.offset))
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
                              style: TtnFlixTextStyle
                                  .defaultTextTheme.titleSmall
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
                        padding: const EdgeInsets.only(
                            left: TtnflixSpacing.spacing8,
                            top: TtnflixSpacing.spacing8),
                        child: Column(
                          children: [
                            Text(
                              movie.getContentRating(),
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
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: () {
                        final cubit = context.read<FavouriteListCubit>();
                        cubit.addRemoveWishlist(movie);
                      },
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding:
                              const EdgeInsets.all(TtnflixSpacing.spacing5),
                          child: Container(
                            decoration: BoxDecoration(
                              color: TtnflixColors.textBlackColor
                                  .platformBrightnessColor(context),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(TtnflixSpacing.spacing30)),
                            ),
                            child: BlocBuilder<FavouriteListCubit,
                                FavouriteListState>(
                              builder: (context, state) {
                                if (state is FavouriteListSuccess) {
                                 if (!isComingFromHome) {
                                   movie.isFavourite = movie.isFavourite;
                                   favouritesAction?.call(movie.isFavourite);
                                 } else {
                                   movie.isFavourite = !movie.isFavourite;
                                 }

                                }
                                return ValueListenableBuilder(
                                    valueListenable: _wishlist!,
                                    builder: (context, value, _) {
                                      return Icon(
                                        Icons.star_outlined,
                                        color: movie.isFavourite
                                            ? TtnflixColors.skyRacing1Color
                                            .platformBrightnessColor(context)
                                            : TtnflixColors.frozenListYellow
                                            .platformBrightnessColor(context),
                                      );
                                    }
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttn_flix/home/favouriteList/cubit/favourite_list_cubit.dart';
import 'package:ttn_flix/home/favouriteList/cubit/favourite_list_state.dart';
import 'package:ttn_flix/home/model/ttnflix_movies.dart';
import 'package:ttn_flix/navigation/ttnflix_auto_route.dart';
import 'package:ttn_flix/network/ttnflix_api_url.dart';
import 'package:ttn_flix/themes/ttnflix_colors.dart';
import 'package:ttn_flix/themes/ttnflix_spacing.dart';
import 'package:ttn_flix/themes/ttnflix_typography.dart';
import 'package:ttn_flix/utils/show_snackbar.dart';

// ignore: must_be_immutable
class MovieListWidgets extends StatelessWidget with ChangeNotifier  {
  MovieListWidgets(
      {super.key,
      required this.context,
      this.height,
      this.carousalImage,
      this.movieName,
      this.language,
      required this.movie,
      this.favouritesAction}){
    _wishlist = ValueNotifier<bool>(movie.isFavourite);
  }

  final BuildContext context;
  final double? height;
  final String? carousalImage;
  final String? movieName;
  final String? language;
  final Movie movie;
  final Function(bool)? favouritesAction;
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
                      height: height,
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                          "${TtnflixApiUrl.imageBaseUrl}$carousalImage",
                          fit: BoxFit.fill)),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      decoration: BoxDecoration(
                          color: TtnflixColors.textBlackColor
                              .platformBrightnessColor(context)
                              ?.withOpacity(0.15)),
                      padding: const EdgeInsets.only(
                          left: TtnflixSpacing.spacing10,
                          right: TtnflixSpacing.spacing10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            movie.getContentRating(),
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
                                  movie.isFavourite = !movie.isFavourite;
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
                                },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: TtnflixSpacing.spacing5,
            ),
            Flexible(
              flex: 10,
              child: RichText(
                text: TextSpan(
                  text: movieName ?? "",
                  style: TtnFlixTextStyle.defaultTextTheme.titleMedium?.copyWith(
                      color: TtnflixColors.frozenListYellow
                          .platformBrightnessColor(context),
                      overflow: TextOverflow.ellipsis),
                ),
                maxLines: 1,
                softWrap: true,
              ),
            )
          ],
        );
      },
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttn_flix/favourites/cubit/favourite_cubit.dart';
import 'package:ttn_flix/favourites/cubit/favourite_state.dart';
import 'package:ttn_flix/generated/l10n.dart';
import 'package:ttn_flix/home/favouriteList/cubit/favourite_list_cubit.dart';

import '../../home/widgets/grid_movie_list.dart';
import '../../themes/ttnflix_colors.dart';
import '../../themes/ttnflix_spacing.dart';
import '../../themes/ttnflix_typography.dart';

class _FavouriteScreenConstant {
  static const double mainAxisHeight = 200.0;
  static const double gridHeight = 200.0;
  static const int crossAxisCount = 2;
}

@RoutePage()
class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavouriteCubit()..getWishlist(),
      child: Scaffold(
          appBar: AppBar(
            title: Text(S.current.favourites,
                style: TtnFlixTextStyle.defaultTextTheme.headlineSmall
                    ?.copyWith(
                        color: TtnflixColors.frozenListYellow
                            .platformBrightnessColor(context))),
            backgroundColor:
                TtnflixColors.textBlackColor.platformBrightnessColor(context),
          ),
          backgroundColor:
              TtnflixColors.textBlackColor.platformBrightnessColor(context),
          body: BlocBuilder<FavouriteCubit, FavouriteState>(
            builder: (context, state) {
              if (state is FavouriteInitState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is FavouriteListState &&
                  state.favouriteListItems.isNotEmpty) {
                return SingleChildScrollView(
                  child: Column(children: [
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          vertical: TtnflixSpacing.spacing8,
                          horizontal: TtnflixSpacing.spacing8),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: _FavouriteScreenConstant.crossAxisCount,
                        crossAxisSpacing: TtnflixSpacing.spacing8,
                        mainAxisSpacing: TtnflixSpacing.spacing8,
                        mainAxisExtent: _FavouriteScreenConstant
                            .mainAxisHeight, // here set custom Height You Want
                      ),
                      itemCount: state.favouriteListItems.length,
                      itemBuilder: (context, index) {
                        return BlocProvider(
                          create: (context) => FavouriteListCubit(),
                          child: GridMovielist(
                            context: context,
                            height: _FavouriteScreenConstant.gridHeight,
                            movieName: state.favouriteListItems[index].title,
                            carousalImage:
                                state.favouriteListItems[index].backdropPath ??
                                    '',
                            language: state
                                .favouriteListItems[index].originalLanguage
                                ?.toUpperCase(),
                            movie: state.favouriteListItems[index],
                            isFavourite: true,
                            isComingFromHome: false,
                            favouritesAction: (isFav) =>
                                context.read<FavouriteCubit>().getWishlist(),
                          ),
                        );
                      },
                    ),
                  ]),
                );
              } else {
                return Center(
                  child: Text(
                    S.current.noFavouritesYet,
                    style: TtnFlixTextStyle.defaultTextTheme.headlineSmall
                        ?.copyWith(
                            color: TtnflixColors.frozenListYellow
                                .platformBrightnessColor(context)),
                  ),
                );
              }
            },
          )),
    );
  }
}

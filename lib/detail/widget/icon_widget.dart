import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttn_flix/home/favouriteList/cubit/favourite_list_cubit.dart';
import 'package:ttn_flix/home/favouriteList/cubit/favourite_list_state.dart';
import 'package:ttn_flix/home/model/ttnflix_movies.dart';
import 'package:ttn_flix/themes/ttnflix_colors.dart';
import 'package:ttn_flix/themes/ttnflix_spacing.dart';
import 'package:ttn_flix/utils/show_snackbar.dart';

@RoutePage()
class IconWidget extends StatelessWidget {
  const IconWidget({super.key, required this.movie,  this.favouritesAction});
  final Movie movie;
  final Function(bool)? favouritesAction;
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
          cubit.addRemoveWishlist(movie);
        }, icon: Container(
          decoration: BoxDecoration(
            color: TtnflixColors.textBlackColor.platformBrightnessColor(context),
            borderRadius:
            const BorderRadius.all(Radius.circular(TtnflixSpacing.spacing30)),
          ),
          child: BlocBuilder<FavouriteListCubit, FavouriteListState>(
            builder: (context, state) {
              if (state is FavouriteListSuccess) {
                movie.isFavourite = !movie.isFavourite;
                favouritesAction?.call(movie.isFavourite);
              }
              return Icon(
                Icons.star_outlined,
                color: movie.isFavourite
                    ? TtnflixColors.skyRacing1Color.platformBrightnessColor(context)
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
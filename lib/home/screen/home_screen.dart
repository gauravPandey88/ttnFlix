import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttn_flix/home/cubit/indicator_cubit.dart';
import 'package:ttn_flix/home/widgets/carousal_widget.dart';
import 'package:ttn_flix/generated/l10n.dart';
import 'package:ttn_flix/home/cubit/home_cubit.dart';
import 'package:ttn_flix/home/cubit/home_state.dart';
import 'package:ttn_flix/home/favouriteList/cubit/favourite_list_cubit.dart';
import 'package:ttn_flix/home/widgets/grid_movie_list.dart';
import 'package:ttn_flix/home/repository/ttnflix_home_repositiory.dart';
import 'package:ttn_flix/themes/ttnflix_colors.dart';
import 'package:ttn_flix/themes/ttnflix_spacing.dart';
import 'package:ttn_flix/themes/ttnflix_typography.dart';
import 'package:ttn_flix/utils/context_extension.dart';

class _HomeScreenConstant {
  static const double carouselHeight = 280.0;
  static const double mainAxisHeight = 200.0;
  static const double gridHeight = 200.0;
  static const int crossAxisCount = 2;
}

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (_) =>
          HomeCubit(TtnflixHomeRepository())..getCarouselListMoviesData(),
      child: HomeBody(),
    );
  }
}

class HomeBody extends StatelessWidget {
  HomeBody({super.key});

  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          TtnflixColors.textBlackColor.platformBrightnessColor(context),
      appBar: AppBar(
        title: Center(
          child: Text(
            S.current.home,
            style: TtnFlixTextStyle.defaultTextTheme.headlineSmall?.copyWith(
                color: TtnflixColors.frozenListYellow
                    .platformBrightnessColor(context)),
          ),
        ),
        backgroundColor:
            TtnflixColors.textBlackColor.platformBrightnessColor(context),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoadedState) {
            return SingleChildScrollView(
              controller: initScrollListener(context),
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: _HomeScreenConstant.carouselHeight,
                    child: BlocProvider(
                      create: (context) => IndicatorCubit(),
                      child: CarousalWidget(state: state),
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        vertical: TtnflixSpacing.spacing8,
                        horizontal: TtnflixSpacing.spacing8),
                    gridDelegate:
                         SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: context.isLargeScreen ? 4 : context.isMediumScreen ? 3 : 2,
                      crossAxisSpacing: TtnflixSpacing.spacing8,
                      mainAxisSpacing: TtnflixSpacing.spacing8,
                      mainAxisExtent: _HomeScreenConstant
                          .mainAxisHeight, // here set custom Height You Want
                    ),
                    itemCount: state.gridMovieList?.length,
                    itemBuilder: (context, index) {
                      return BlocProvider<FavouriteListCubit>(
                        create: (BuildContext context) => FavouriteListCubit(),
                        child: GridMovielist(
                          context: context,
                          height: _HomeScreenConstant.gridHeight,
                          movieName: state.gridMovieList?[index].title,
                          carousalImage:
                              state.gridMovieList?[index].backdropPath ?? '',
                          language: state.gridMovieList?[index].originalLanguage
                              ?.toUpperCase(),
                          movie: state.gridMovieList![index],
                          isComingFromHome: true,
                        ),
                      );
                    },
                  ),
                  const Center(child: CircularProgressIndicator()),
                ],
              ),
            );
          } else if (state is HomeLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  ScrollController initScrollListener(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        BlocProvider.of<HomeCubit>(context).loadPaginationData();
      }
    });
    return _scrollController;
  }
}

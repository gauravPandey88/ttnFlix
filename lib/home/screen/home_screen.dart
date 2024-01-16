import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttn_flix/home/cubit/home_cubit.dart';
import 'package:ttn_flix/home/cubit/home_state.dart';
import 'package:ttn_flix/home/widgets/grid_movie_list.dart';
import 'package:ttn_flix/home/widgets/movie_list.dart';
import 'package:ttn_flix/home/repository/ttnflix_home_repositiory.dart';
import 'package:ttn_flix/themes/ttnflix_colors.dart';
import 'package:ttn_flix/themes/ttnflix_spacing.dart';
import 'package:ttn_flix/themes/ttnflix_typography.dart';

class _HomeScreenConstant {
  static const String home = 'Home';
  static const double movieListHeight = 215.0;
  static const double carouselHeight = 300.0;
  static const double carouselOptionsHeight = 280.0;
  static const double mainAxisHeight = 200.0;
  static const double gridHeight = 200.0;
  static const int carouselRotationDuration = 800;
  static const int carouselPlayInterval = 3;
  static const double borderRadius = 8.0;
  static const double dotsInitialSize = 8.0;
  static const double dotsActiveSize = 16.0;
  static const int dotsTotalCount = 10;
  static const int crossAxisCount = 2;
  static const double viewPortFraction = 1;
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          _HomeScreenConstant.home,
          style: TtnFlixTextStyle.defaultTextTheme.headlineSmall?.copyWith(
              color: TtnflixColors.frozenListYellow
                  .platformBrightnessColor(context)),
        ),
        backgroundColor: Colors.black,
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
                    child: Stack(children: [
                      CarouselSlider.builder(
                        itemCount: state.movieCarouselList?.length,
                        itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) {
                          return MovieListWidgets(
                            context: context,
                            height: _HomeScreenConstant.movieListHeight,
                            carousalImage: state.movieCarouselList?[itemIndex]
                                    .backdropPath ??
                                '',
                            movieName:
                                state.movieCarouselList?[itemIndex].title,
                            language: state
                                .movieCarouselList?[itemIndex].originalLanguage
                                ?.toUpperCase(),
                          );
                        },
                        options: CarouselOptions(
                          height: _HomeScreenConstant.carouselOptionsHeight,
                          viewportFraction:
                              _HomeScreenConstant.viewPortFraction,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: const Duration(
                              seconds:
                                  _HomeScreenConstant.carouselPlayInterval),
                          autoPlayAnimationDuration: const Duration(
                              milliseconds:
                                  _HomeScreenConstant.carouselRotationDuration),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) {
                            BlocProvider.of<HomeCubit>(context)
                                .updatePageIndicator(index);
                          },
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      Positioned(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: DotsIndicator(
                            dotsCount: _HomeScreenConstant.dotsTotalCount,
                            position: state.carousalMovieCurrentpage ?? 0,
                            decorator: DotsDecorator(
                              color: Colors.white,
                              activeColor: Colors.amber,
                              size: const Size.square(
                                  _HomeScreenConstant.dotsInitialSize),
                              activeSize: const Size(
                                  _HomeScreenConstant.dotsActiveSize,
                                  _HomeScreenConstant.dotsInitialSize),
                              activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    _HomeScreenConstant.borderRadius),
                              ),
                            ),
                          ),
                        ),
                      )
                    ]),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        vertical: TtnflixSpacing.spacing8,
                        horizontal: TtnflixSpacing.spacing8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _HomeScreenConstant.crossAxisCount,
                      crossAxisSpacing: TtnflixSpacing.spacing8,
                      mainAxisSpacing: TtnflixSpacing.spacing8,
                      mainAxisExtent: _HomeScreenConstant
                          .mainAxisHeight, // here set custom Height You Want
                    ),
                    itemCount: state.gridMovieList?.length,
                    itemBuilder: (context, index) {
                      return GridMovielist(
                        context: context,
                        height: _HomeScreenConstant.gridHeight,
                        movieName: state.gridMovieList?[index].title,
                        carousalImage:
                            state.gridMovieList?[index].backdropPath ?? '',
                        language: state.gridMovieList?[index].originalLanguage
                            ?.toUpperCase(),
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

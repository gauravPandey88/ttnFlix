import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttn_flix/home/cubit/home_cubit.dart';
import 'package:ttn_flix/home/cubit/home_state.dart';
import 'package:ttn_flix/home/cubit/indicator_cubit.dart';
import 'package:ttn_flix/home/cubit/indicator_state.dart';
import 'package:ttn_flix/home/favouriteList/cubit/favourite_list_cubit.dart';
import 'package:ttn_flix/home/widgets/movie_list.dart';
import 'package:ttn_flix/themes/ttnflix_colors.dart';

class _CarousalWidgetConstant {
  static const double movieListHeight = 215.0;
  static const double carouselHeight = 280.0;
  static const double carouselOptionsHeight = 280.0;
  static const int carouselRotationDuration = 800;
  static const int carouselPlayInterval = 3;
  static const double borderRadius = 8.0;
  static const double dotsInitialSize = 8.0;
  static const double dotsActiveSize = 16.0;
  static const int dotsTotalCount = 10;
  static const double viewPortFraction = 1;
  static const int itemCount = 10;
}

class CarousalWidget extends StatelessWidget {
  const CarousalWidget({
    super.key, required this.state,
  });

  final HomeLoadedState state;


  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      CarouselSlider.builder(
        itemCount: _CarousalWidgetConstant.itemCount,
        itemBuilder:
            (BuildContext context, int itemIndex, int pageViewIndex) {

          return BlocProvider<FavouriteListCubit>(
            create: (BuildContext context) => FavouriteListCubit(),
            child: MovieListWidgets(
              context: context,
              height: _CarousalWidgetConstant.movieListHeight,
              carousalImage:
              state.movieCarouselList?[itemIndex].backdropPath ?? '',
              movie: state.movieCarouselList![itemIndex],
              movieName: state.movieCarouselList?[itemIndex].title,
              language: state
                  .movieCarouselList?[itemIndex].originalLanguage
                  ?.toUpperCase(),
            ),
          );
        },
        options: CarouselOptions(
          height: _CarousalWidgetConstant.carouselOptionsHeight,
          viewportFraction: _CarousalWidgetConstant.viewPortFraction,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(
              seconds: _CarousalWidgetConstant.carouselPlayInterval),
          autoPlayAnimationDuration: const Duration(
              milliseconds:
              _CarousalWidgetConstant.carouselRotationDuration),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          onPageChanged: (index, reason) {
            BlocProvider.of<IndicatorCubit>(context)
                .updatePageIndicator(index);
          },
          scrollDirection: Axis.horizontal,
        ),
      ),
      Positioned(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: BlocBuilder<IndicatorCubit, IndicatorState>(
            builder: (context, indicatorState) {
              print('indicatorState');
              if (indicatorState is IndicatorLoadedState) {
                return DotsIndicator(
                  dotsCount: _CarousalWidgetConstant.dotsTotalCount,
                  position: indicatorState.carousalMovieCurrentPage ?? 0,
                  decorator: DotsDecorator(
                    color: TtnflixColors.titleColor
                        .platformBrightnessColor(context)!,
                    activeColor: TtnflixColors.frozenListYellow
                        .platformBrightnessColor(context),
                    size: const Size.square(
                        _CarousalWidgetConstant.dotsInitialSize),
                    activeSize: const Size(
                        _CarousalWidgetConstant.dotsActiveSize,
                        _CarousalWidgetConstant.dotsInitialSize),
                    activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          _CarousalWidgetConstant.borderRadius),
                    ),
                  ),
                );
              } else {
                return DotsIndicator(
                  dotsCount: _CarousalWidgetConstant.dotsTotalCount,
                  position: 0,
                  decorator: DotsDecorator(
                    color: TtnflixColors.titleColor
                        .platformBrightnessColor(context)!,
                    activeColor: TtnflixColors.frozenListYellow
                        .platformBrightnessColor(context),
                    size: const Size.square(
                        _CarousalWidgetConstant.dotsInitialSize),
                    activeSize: const Size(
                        _CarousalWidgetConstant.dotsActiveSize,
                        _CarousalWidgetConstant.dotsInitialSize),
                    activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          _CarousalWidgetConstant.borderRadius),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      )
    ]);
  }
}

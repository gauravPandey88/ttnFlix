import 'package:ttn_flix/home/model/ttnflix_movies.dart';
import 'package:ttn_flix/utils/default_equatable.dart';

abstract class HomeState extends DefaultEquatable {
  const HomeState();
}

class HomeLoadingState extends HomeState {
  const HomeLoadingState();
}

class HomeLoadedState extends HomeState {
  final List<Movie>? movieCarouselList;
  final List<Movie>? gridMovieList;
  final int currentPage;
  final int totalPages;
  final bool showNextPage;
  final bool? selectIcon;
  final int? carousalMovieCurrentpage;

  const HomeLoadedState(
      {this.movieCarouselList,
      this.gridMovieList,
      this.selectIcon,
      required this.currentPage,
      required this.totalPages,
      required this.showNextPage,
      this.carousalMovieCurrentpage});

  HomeLoadedState copyWith({
    final List<Movie>? movieCarouselList,
    final List<Movie>? gridMovieList,
    List<int>? favourite,
    final int? currentPage,
    final int? totalPages,
    final bool? showNextPage,
    final bool? selectIcon,
    final int? carousalMovieCurrentpage,
  }) {
    return HomeLoadedState(
        movieCarouselList: movieCarouselList ?? this.movieCarouselList,
        gridMovieList: gridMovieList ?? this.gridMovieList,
        currentPage: currentPage ?? this.currentPage,
        totalPages: totalPages ?? this.totalPages,
        selectIcon: selectIcon ?? this.selectIcon,
        carousalMovieCurrentpage:
            carousalMovieCurrentpage ?? this.carousalMovieCurrentpage,
        showNextPage: showNextPage ?? this.showNextPage);
  }

  @override
  List<Object?> get props => [
        movieCarouselList,
        gridMovieList,
        selectIcon,
        currentPage,
        totalPages,
        showNextPage,
        carousalMovieCurrentpage
      ];
}

class HomeErrorState extends HomeState {
  final String errorMessage;

  const HomeErrorState(this.errorMessage);
}

class AllWishListState extends HomeState {
  AllWishListState(this.wishListItems);
  final List<int> wishListItems;

}

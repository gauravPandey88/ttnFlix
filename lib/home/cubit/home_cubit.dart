import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttn_flix/home/cubit/home_state.dart';
import 'package:ttn_flix/home/repository/ttnflix_home_repositiory.dart';
import 'package:ttn_flix/network/ttnflix_custom_exception.dart';

class _HomeCubitConstant {
  static const int firstPage = 1;
  static const int secondPage = 2;
  static const int itemIndex = 10;

}

class HomeCubit extends Cubit<HomeState> {
  final TtnflixHomeRepository _ttnflixHomeRepository;

  HomeCubit(
    this._ttnflixHomeRepository,
  ) : super(const HomeLoadingState());

  Future<void> getCarouselListMoviesData() async {
    try {
      final carousalResponse = await _ttnflixHomeRepository.getHomePageDate(_HomeCubitConstant.firstPage);
      final gridResponse = await _ttnflixHomeRepository.getHomePageDate(_HomeCubitConstant.secondPage);
      emit(HomeLoadedState(
          movieCarouselList: carousalResponse.movieList,
          gridMovieList: gridResponse.movieList,
      totalPages: gridResponse.totalPages ?? 0,
      currentPage: gridResponse.page ?? 0,
      showNextPage: false));
    } on TtnflixCustomException catch (e) {
      emit(HomeErrorState(e.toString()));
    }
  }

  Future<void> getGridMovieListPagination(int pageNo) async {
    try {
      var homeLoadedState = state as HomeLoadedState;

      emit(homeLoadedState.copyWith(showNextPage: true));
      final gridResponse = await _ttnflixHomeRepository.getHomePageDate(pageNo);
      homeLoadedState.gridMovieList?.addAll(gridResponse.movieList ?? []);

      emit(homeLoadedState.copyWith(
          gridMovieList: homeLoadedState.gridMovieList,
          currentPage: gridResponse.page ?? 0,
          totalPages: gridResponse.totalPages ?? 0,
          showNextPage: false));
    } on TtnflixCustomException catch (e) {
      emit(HomeErrorState(e.toString()));
    }
  }

  Future<void> loadPaginationData() async {
    if (state is HomeLoadedState) {
      var currentState = state as HomeLoadedState;

      if (!currentState.showNextPage &&
          currentState.totalPages >= currentState.currentPage) {
        int currentPage = currentState.currentPage;
        getGridMovieListPagination(++currentPage);
      }
    }
  }

  void updatePageIndicator(int index){
    if (state is HomeLoadedState) {
      var currentState = state as HomeLoadedState;
      if ( index >= _HomeCubitConstant.itemIndex){
        emit(currentState.copyWith(carousalMovieCurrentpage: index % _HomeCubitConstant.itemIndex));
      } else {
        emit(currentState.copyWith(carousalMovieCurrentpage: index));
      }


    }
  }
}

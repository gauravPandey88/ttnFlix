import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttn_flix/di/service_locator_impl.dart';
import 'package:ttn_flix/favourites/cubit/favourite_state.dart';
import 'package:ttn_flix/home/cubit/home_state.dart';
import 'package:ttn_flix/home/repository/ttnflix_home_repositiory.dart';
import 'package:ttn_flix/network/ttnflix_custom_exception.dart';
import 'package:ttn_flix/utils/database_Manager.dart';

class _HomeCubitConstant {
  static const int firstPage = 1;
  static const int secondPage = 2;
}

class HomeCubit extends Cubit<HomeState> {
  final TtnflixHomeRepository _ttnflixHomeRepository;
  List<int> wishListIds = [];

  HomeCubit(
    this._ttnflixHomeRepository,
  ) : super(const HomeLoadingState());

  void fetchWishListData() async {
    wishListIds = await ServiceLocatorImpl.serviceLocator<DBManager>().getAllIds();
  }

  Future<void> getCarouselListMoviesData() async {
    fetchWishListData();
    print('getCarouselListMoviesData');
    try {
      final carousalResponse = await _ttnflixHomeRepository
          .getHomePageDate(_HomeCubitConstant.firstPage);
      final gridResponse = await _ttnflixHomeRepository
          .getHomePageDate(_HomeCubitConstant.secondPage);
      // List<int> ids =
      //     await ServiceLocatorImpl.serviceLocator<DBManager>().getAllIds();

      carousalResponse.movieList?.forEach((element) {
        if (wishListIds.contains(element.id)) {
          element.isFavourite = true;
        }
      });
      gridResponse.movieList?.forEach((element) {
        if (wishListIds.contains(element.id)) {
          element.isFavourite = true;
        }
      });
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
      // List<int> ids =
      //     await ServiceLocatorImpl.serviceLocator<DBManager>().getAllIds();
      gridResponse.movieList?.forEach((element) {
        if (wishListIds.contains(element.id)) {
          element.isFavourite = true;
        }
      });
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

  void updatePageIndicator(int index) {
    if (state is HomeLoadedState) {
      var currentState = state as HomeLoadedState;
      emit(currentState.copyWith(carousalMovieCurrentpage: index));
    }
  }

  void selectedIcon({required bool selectIcon}) {
    if (state is HomeLoadedState) {
      var currentState = state as HomeLoadedState;
      selectIcon = !selectIcon;
      emit(currentState.copyWith(selectIcon: selectIcon));
    }
  }
}

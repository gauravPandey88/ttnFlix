import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttn_flix/di/service_locator.dart';
import 'package:ttn_flix/di/service_locator_impl.dart';
import 'package:ttn_flix/generated/l10n.dart';
import 'package:ttn_flix/home/favouriteList/cubit/favourite_list_state.dart';
import 'package:ttn_flix/home/model/ttnflix_movies.dart';
import 'package:ttn_flix/utils/database_Manager.dart';

class FavouriteListCubit extends Cubit<FavouriteListState> {
  FavouriteListCubit({DBManager? dbManager})
      : _dbManager =
            dbManager ?? ServiceLocatorImpl.serviceLocator<DBManager>(),
        super(FavouriteListInitState());

  final DBManager _dbManager;

  void addRemoveWishlist(Movie movie, {bool isNeedToAdd = true}) async {

    if (isNeedToAdd) {
      var result = await _dbManager.insert(movie);
      if (result > 0) {
        emit(FavouriteListSuccess(S.current.addSuccessfully, true));
      } else {
        emit(FavouriteListError(S.current.notAdd));
      }
    } else {
      var result = await _dbManager.delete(movie.id ?? 0);
      if (result > 0) {
        emit(FavouriteListSuccess(S.current.removeSuccessfully, false));
      } else {
        emit(FavouriteListError(S.current.error));
      }
    }
  }
}

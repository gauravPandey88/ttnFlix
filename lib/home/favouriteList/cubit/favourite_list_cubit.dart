import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttn_flix/di/service_locator_impl.dart';
import 'package:ttn_flix/home/favouriteList/cubit/favourite_list_state.dart';
import 'package:ttn_flix/home/model/ttnflix_movies.dart';
import 'package:ttn_flix/utils/database_Manager.dart';

class FavouriteListCubit extends Cubit<FavouriteListState> {
  FavouriteListCubit() : super(FavouriteListInitState()) { }

  void addRemoveWishlist(BuildContext context, Movie movie, {bool isNeedToAdd = true}) async {
    var db = ServiceLocatorImpl.serviceLocator<DBManager>();
    if (isNeedToAdd) {
      var result = await db.insert(movie);
      if (result > 0) {
        if (context.mounted) emit(FavouriteListSuccess('Successfully add', true));
      } else {
        if (context.mounted) emit(FavouriteListError('Not add'));
      }
    } else {
      var result = await db.delete(movie.id ?? 0);
      if (result > 0) {
        if (context.mounted) {
          emit(FavouriteListSuccess('Successfully removed', false));
        }

      } else {
        if (context.mounted)  emit(FavouriteListError('error'));
      }
    }
  }
}
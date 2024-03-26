import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttn_flix/di/service_locator_impl.dart';
import 'package:ttn_flix/generated/l10n.dart';
import 'package:ttn_flix/home/favouriteList/cubit/favourite_list_state.dart';
import 'package:ttn_flix/home/model/ttnflix_movies.dart';
import 'package:ttn_flix/utils/database_manager.dart';
import 'package:ttn_flix/utils/shared_preferences.dart';

class FavouriteListCubit extends Cubit<FavouriteListState> {
  FavouriteListCubit({DBManager? dbManager})
      : _dbManager =
            dbManager ?? ServiceLocatorImpl.serviceLocator<DBManager>(),
        super(FavouriteListInitState());

  final DBManager _dbManager;

  void addRemoveWishlist(Movie movie) async {
    var allFavouritedList =
        ServiceLocatorImpl.serviceLocator<SharedPreferencesService>()
            .getList('favouriteList', Movie.fromJson);
    if (!movie.isFavourite) {
      allFavouritedList.add(movie);

      var result = ServiceLocatorImpl.serviceLocator<SharedPreferencesService>()
          .saveList('favouriteList',
              allFavouritedList.map((fav) => fav.toJson()).toList());
      if (await result) {
        emit(FavouriteListSuccess(S.current.addSuccessfully, true));
      } else {
        emit(FavouriteListError(S.current.notAdd));
      }
    } else {
      allFavouritedList.removeWhere((element) => element.id == movie.id);

      var result = ServiceLocatorImpl.serviceLocator<SharedPreferencesService>()
          .saveList('favouriteList', allFavouritedList);
      if (await result) {
        emit(FavouriteListSuccess(S.current.removeSuccessfully, false));
      } else {
        emit(FavouriteListError(S.current.error));
      }
    }
  }
}

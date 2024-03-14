import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttn_flix/di/service_locator_impl.dart';
import 'package:ttn_flix/favourites/cubit/favourite_state.dart';
import 'package:ttn_flix/utils/database_manager.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitState()) {
    getWishlist();
  }

  void getWishlist() async {
    var db = ServiceLocatorImpl.serviceLocator<DBManager>();
    var result = await db.queryAllMovies();
    emit(FavouriteListState(result));
  }
}

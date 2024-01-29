import 'package:ttn_flix/home/model/ttnflix_movies.dart';

abstract class FavouriteState {
  const FavouriteState();

  List<Object> get props => [];
}
class FavouriteInitState extends FavouriteState { }


class FavouriteListState extends FavouriteState {
  FavouriteListState(this.favouriteListItems);
  final List<Movie> favouriteListItems;

}
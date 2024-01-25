import 'package:ttn_flix/home/model/ttnflix_movies.dart';

abstract class FavouriteState {
  const FavouriteState();

  @override
  List<Object> get props => [];
}
class FavouriteInitState extends FavouriteState { }


class AllWishListState extends FavouriteState {
  AllWishListState(this.wishListItems, this.favourite);
  final List<Movie> wishListItems;
  final List<int> favourite;

}
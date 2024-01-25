

abstract class FavouriteListState {}

class FavouriteListInitState extends FavouriteListState { }

class FavouriteListSuccess extends FavouriteListState {
  FavouriteListSuccess(this.message, this.isFavourite);
  final String? message;
  final bool isFavourite;

}
class FavouriteListError extends FavouriteListState {
  FavouriteListError(this.message);
  String? message;
}
part of 'favourites_bloc.dart';

@immutable
class FavouritesState {
  List<songsmodel> newFavouritesList=[];
  FavouritesState({required this.newFavouritesList});
}

class FavouritesInitial extends FavouritesState {
  FavouritesInitial() : super(newFavouritesList: allFavouriteListGlobal);
}

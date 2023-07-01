part of 'favourites_bloc.dart';

@immutable
abstract class FavouritesEvent {}

class FavoriteListSongAdding extends FavouritesEvent{
  songsmodel newfavsongdata;
  FavoriteListSongAdding({required this.newfavsongdata});
}

class FavoriteListSongDeleting extends FavouritesEvent{
  songsmodel favsongdeletesong;
  FavoriteListSongDeleting({required this.favsongdeletesong});
}

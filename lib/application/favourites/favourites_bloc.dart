import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:naromusic/domain/db/functions/db_functions.dart';

import '../../domain/db/models/songsmodel.dart';

part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  FavouritesBloc() : super(FavouritesInitial()) {
    on<FavoriteListSongAdding>(favoriteListSongAdding);
    on<FavoriteListSongDeleting>(favoriteListSongDeleting);
  }


  FutureOr<void> favoriteListSongAdding(FavoriteListSongAdding event, Emitter<FavouritesState> emit) {
    addtofavroutiedbfunction(event.newfavsongdata);
    emit(FavouritesState(newFavouritesList: allFavouriteListGlobal));
  }

  FutureOr<void> favoriteListSongDeleting(FavoriteListSongDeleting event, Emitter<FavouritesState> emit) {
     favsongslistdelete(event.favsongdeletesong);
    emit(FavouritesState(newFavouritesList: allFavouriteListGlobal));
  }
}

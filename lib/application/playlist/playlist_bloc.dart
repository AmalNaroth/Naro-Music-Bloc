import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:naromusic/domain/db/functions/db_functions.dart';
import 'package:naromusic/domain/db/models/songsmodel.dart';

import '../../domain/db/models/playlistmodel.dart';

part 'playlist_event.dart';
part 'playlist_state.dart';

class PlaylistBloc extends Bloc<PlaylistEvent, PlaylistState> {
  PlaylistBloc() : super(PlaylistInitial()) {
   on<NewPlayList>(newPlayList);
   on<DeletePlayList>(deletePlayList);
  }

  FutureOr<void> newPlayList(NewPlayList event, Emitter<PlaylistState> emit) {
    List<songsmodel> NewPlayList=[];
    addplaylisttodatabase(event.newPlayListName, NewPlayList);
    emit(PlaylistState(newplayList: allPlayListNameGlobal));
  }

  FutureOr<void> deletePlayList(DeletePlayList event, Emitter<PlaylistState> emit) {
    playlistdelete(event.deletedata);
    emit(PlaylistState(newplayList: allPlayListNameGlobal));
  }
}
